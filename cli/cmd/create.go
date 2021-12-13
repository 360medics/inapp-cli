package cmd

import (
	"fmt"
	"os"

	"360medics.com/inapp-cli/v2/inapp"
	"github.com/gobeam/stringy"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create an InApp boilerplate",
	Long:  ``,
	Run:   RunCreate,
}

func init() {
	rootCmd.AddCommand(createCmd)

	createCmd.Flags().StringP("inapp-name", "n", "", "InApp Project Name in kebab-case (eg. dev-logbook)")
	createCmd.MarkFlagRequired("inapp-name")

	createCmd.Flags().StringP("type", "t", "", "InApp type (front, back or full)")
	createCmd.MarkFlagRequired("type")
}

func RunCreate(cmd *cobra.Command, args []string) {
	inappName := stringy.New(cmd.Flag("inapp-name").Value.String()).KebabCase().ToLower()
	inappType := cmd.Flag("type").Value.String()

	if (inappType != "front") && (inappType != "back") && (inappType != "full") {
		fmt.Printf("Invalid type: must be one of 'front', 'back' or 'full'\n")
		os.Exit(1)
	}

	// checking existance of the project
	// @TODO: decomment this
	// hasBeenInited := viper.GetBool("init")
	// if hasBeenInited {
	// 	fmt.Printf("Project already exists.\n")
	// 	os.Exit(1)
	// }

	fmt.Printf("Creating project %s of type %s\n", inappName, inappType)

	app := inapp.NewInApp(inapp.InappOpts{Frontend: inappType == "front" || inappType == "full", Backend: inappType == "back" || inappType == "full", Name: inappName})
	err := app.Init()
	cobra.CheckErr(err)

	viper.Set("inapp-name", inappName)
	viper.Set("type", inappType)
	viper.Set("init", true)

	viper.WriteConfig()
}
