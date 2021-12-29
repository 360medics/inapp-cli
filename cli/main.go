package main

import (
	"embed"

	"360medics.com/inapp-cli/v2/cmd"
)

// the line below will show an error if you don't have Go 1.18beta1+
//go:embed all:boilerplate/*
var boilerplateFS embed.FS

func main() {
	cmd.Execute(boilerplateFS)
}
