{
  "eslint.workingDirectories": [
    {{if .Backend}}"./stacks/api",{{end}}
    {{if .Frontend}}"./stacks/client"{{end}}
  ],
  "files.exclude": {
    "**/.git": true,
    "**/node_modules": true
  },
  "eslint.codeActionsOnSave.mode": "all"
}
