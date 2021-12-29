package inapp

import (
	"embed"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"text/template"

	"360medics.com/inapp-cli/v2/copy"
)

type InApp struct {
	frontend      bool
	backend       bool
	name          string
	directory     string
	baseDirectory string
	boilerplateFS *embed.FS
}

type InappOpts struct {
	Frontend      bool
	Backend       bool
	Name          string
	BaseDirectory string
}

func NewInApp(opts InappOpts, boilerplate *embed.FS) *InApp {
	return &InApp{
		frontend:      opts.Frontend,
		backend:       opts.Backend,
		name:          opts.Name,
		baseDirectory: opts.BaseDirectory,
		boilerplateFS: boilerplate,
	}
}

func (i *InApp) Init() error {
	i.directory = filepath.Join(i.baseDirectory, i.name)

	err := i.createDirectoryStructure()
	if err != nil {
		return err
	}

	err = i.writeTemplates()
	if err != nil {
		return err
	}

	err = i.createDotEnv()
	if err != nil {
		return err
	}

	fmt.Printf("Installing npm dependencies...\n")
	err = i.runNpmInstall()

	return err
}

func (i *InApp) runNpmInstall() error {
	command := exec.Command("npm", "install", "--prefix", i.directory)
	command.Stdout = os.Stdout
	command.Stderr = os.Stderr
	return command.Run()
}

func (i *InApp) createDirectoryStructure() error {
	err := os.MkdirAll(i.directory, 0755)
	if err != nil {
		return err
	}

	err = os.MkdirAll(filepath.Join(i.directory, "stacks"), 0755)
	if err != nil {
		return err
	}

	err = os.MkdirAll(filepath.Join(i.directory, "deploy"), 0755)
	if err != nil {
		return err
	}

	err = os.MkdirAll(filepath.Join(i.directory, ".vscode"), 0755)
	if err != nil {
		return err
	}

	err = os.MkdirAll(filepath.Join(i.directory, ".circleci"), 0755)
	if err != nil {
		return err
	}

	if i.Frontend() {
		err = os.MkdirAll(filepath.Join(i.directory, "stacks", "client"), 0755)
		if err != nil {
			return err
		}
	}

	if i.Backend() {
		err = os.MkdirAll(filepath.Join(i.directory, "stacks", "api"), 0755)
		if err != nil {
			return err
		}
	}

	return nil
}

func (i *InApp) writeTemplates() error {
	boilerPlateDirectory := "boilerplate"
	rootPattern := filepath.Join(boilerPlateDirectory, "*.tpl")

	rootTemplates, err := template.ParseFS(i.boilerplateFS, rootPattern)
	if err != nil {
		return err
	}

	for _, t := range rootTemplates.Templates() {
		fmt.Printf("processing root template: %v\n", t.Name())
		f, err := os.Create(filepath.Join(i.directory, strings.Replace(t.Name(), ".tpl", "", 1)))
		if err != nil {
			return err
		}
		err = t.Execute(f, i)
		if err != nil {
			return err
		}
	}

	// .vscode
	vscodePattern := filepath.Join(boilerPlateDirectory, ".vscode", "*.tpl")
	vscodeTemplates, err := template.ParseFS(i.boilerplateFS, vscodePattern)
	if err != nil {
		return err
	}

	for _, t := range vscodeTemplates.Templates() {
		fmt.Printf("processing vscode template: %v\n", t.Name())
		f, err := os.Create(filepath.Join(i.directory, ".vscode", strings.Replace(t.Name(), ".tpl", "", 1)))
		if err != nil {
			return err
		}
		err = t.Execute(f, i)
		if err != nil {
			return err
		}
	}

	// .circleci
	circleciPattern := filepath.Join(boilerPlateDirectory, ".circleci", "*.tpl")
	circleciTemplates, err := template.ParseFS(i.boilerplateFS, circleciPattern)
	if err != nil {
		return err
	}

	for _, t := range circleciTemplates.Templates() {
		fmt.Printf("processing circleci template: %v\n", t.Name())
		f, err := os.Create(filepath.Join(i.directory, ".circleci", strings.Replace(t.Name(), ".tpl", "", 1)))
		if err != nil {
			return err
		}
		err = t.Execute(f, i)
		if err != nil {
			return err
		}
	}

	// client
	if i.Frontend() {
		fmt.Println("processing client")
		err := copy.CopyFromEmbedded(i.boilerplateFS, filepath.Join(boilerPlateDirectory, "stacks", "client"), filepath.Join(i.directory, "stacks", "client"))
		if err != nil {
			return err
		}
	}

	// api
	if i.Backend() {
		fmt.Println("processing api")
		err := copy.CopyFromEmbedded(i.boilerplateFS, filepath.Join(boilerPlateDirectory, "stacks", "api"), filepath.Join(i.directory, "stacks", "api"))
		if err != nil {
			return err
		}
	}

	// deploy
	fmt.Println("processing deploy")
	err = copy.CopyFromEmbedded(i.boilerplateFS, filepath.Join(boilerPlateDirectory, "deploy"), filepath.Join(i.directory, "deploy"))

	return err
}

func (i *InApp) createDotEnv() error {
	fr, err := os.Open(filepath.Join(i.directory, ".env.local"))
	if err != nil {
		return err
	}
	defer fr.Close()

	fw, err := os.Create(filepath.Join(i.directory, ".env"))
	if err != nil {
		return err
	}
	defer fw.Close()

	_, err = io.Copy(fw, fr)

	return err
}

func (i *InApp) Frontend() bool {
	return i.frontend
}

func (i *InApp) Backend() bool {
	return i.backend
}

func (i *InApp) Name() string {
	return i.name
}

func (i *InApp) Directory() string {
	return i.directory
}
