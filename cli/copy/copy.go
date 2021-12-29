package copy

import (
	"embed"
	"io/ioutil"
	"os"
	"path/filepath"
)

func CopyFromEmbedded(fs *embed.FS, source string, dst string) error {
	clientDirectory, err := fs.ReadDir(source)
	if err != nil {
		return err
	}

	err = os.MkdirAll(dst, 0755)
	if err != nil {
		return err
	}

	for _, f := range clientDirectory {
		if f.IsDir() {
			err = CopyFromEmbedded(fs, filepath.Join(source, f.Name()), filepath.Join(dst, f.Name()))
			if err != nil {
				return err
			}
		} else {
			err = CopyFileFromEmbedded(fs, filepath.Join(source, f.Name()), filepath.Join(dst, f.Name()))
			if err != nil {
				return err
			}
		}
	}

	return nil
}

func CopyFileFromEmbedded(fs *embed.FS, source string, dst string) error {
	// read file
	fileBytes, err := fs.ReadFile(source)
	if err != nil {
		return err
	}

	// copy file
	err = ioutil.WriteFile(dst, fileBytes, 0777)
	if err != nil {
		return err
	}

	return nil
}
