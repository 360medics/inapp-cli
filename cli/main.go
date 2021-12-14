package main

import (
	"embed"

	"360medics.com/inapp-cli/v2/cmd"
)

//go:embed boilerplate/*
var boilerplateFS embed.FS

func main() {
	cmd.Execute(boilerplateFS)
}
