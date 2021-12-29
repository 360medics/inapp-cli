package cmd

import (
	"embed"
	"fmt"
	"os"

	"github.com/spf13/cobra"

	"github.com/spf13/viper"
)

var boilerplateFS embed.FS
var cfgFile string

var rootCmd = &cobra.Command{
	Use:   "inapp",
	Short: "InApp CLI",
	Long:  `Create and Modify InApp easily.`,
}

func Execute(boilerplate embed.FS) {
	boilerplateFS = boilerplate
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	cobra.OnInitialize(initConfig)

	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is .inapp.yaml)")
	rootCmd.PersistentFlags().String("cwd", ".", "cwd")
}

// initConfig reads in config file and ENV variables if set
func initConfig() {

	if cfgFile != "" {
		// Use config file from the flag
		viper.SetConfigFile(cfgFile)
	}

	// read in environment variables that match
	viper.AutomaticEnv()

	// If a config file is found, read it in
	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}
