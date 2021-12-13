package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"

	"github.com/spf13/viper"
)

var cfgFile string

var rootCmd = &cobra.Command{
	Use:   "inapp",
	Short: "InApp CLI",
	Long:  `Create and Modify InApp easily.`,
}

func Execute() {
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	cobra.OnInitialize(initConfig)

	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is /.inapp.yaml)")
}

// initConfig reads in config file and ENV variables if set
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag
		viper.SetConfigFile(cfgFile)
	} else {
		// Find root directory
		directory, err := os.Getwd()
		cobra.CheckErr(err)

		// Search config
		viper.AddConfigPath(directory)
		viper.SetConfigType("yaml")
		viper.SetConfigName(".inapp")

		// Create config file if not exist
		viper.SafeWriteConfig()
	}

	// read in environment variables that match
	viper.AutomaticEnv()

	// If a config file is found, read it in
	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}
