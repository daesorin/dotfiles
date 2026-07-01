# .zsh

This directory contains a modularised Zsh configuration. The shell environment is broken down into distinct, numbered files to enforce a strict and predictable execution order during the startup sequence.

## CORE INITIALISATION
* **.zshrc:** The primary interactive shell entry point that sources the subsequent configuration modules.
* **00-umask.zsh:** Defines default file creation permissions.
* **01-path.zsh:** Constructs the `$PATH` variable and defines executable routes for the system.
* **02-options.zsh:** Configures core Zsh behaviour and shell directives via `setopt`.

## ENVIRONMENT AND STATE
* **03-history.zsh:** Configures command history logging, file size limits, and retention behaviour.
* **04-env.zsh:** Exports global environment variables required by the system and user applications.
* **05-completion.zsh:** Initialises the Zsh completion system (`compinit`) and configures tab-completion behaviour.

## EXTENSIONS AND WORKFLOW
* **06-plugins.zsh:** Loads shell extensions, syntax highlighting, and prompt integrations.
* **07-binds.zsh:** Defines custom keyboard shortcuts and configures input handling (such as vi-mode bindings).
* **08-aliases.zsh:** Maps custom command shortcuts and overrides for daily utilities.

## SCRIPTING AND LOGIC
* **09-functions.zsh:** The initialisation script for loading user-defined shell functions.
* **.functions:** A directory containing discrete, standalone shell scripts and complex logical functions sourced into the environment.
