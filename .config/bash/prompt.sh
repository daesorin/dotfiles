#!/usr/bin/env bash

# COLOUR DEFINITIONS
c_red="\[\e[1;31m\]"
c_green="\[\e[1;32m\]"
c_blue="\[\e[1;34m\]"
c_cyan="\[\e[1;36m\]"
c_purple="\[\e[1;35m\]"
c_gray="\[\e[1;30m\]"
c_reset="\[\e[0m\]"

build_prompt() {
  local exit_code=$?

  # Error indicator (only when non-zero)
  local err=""
  if ((exit_code != 0)); then
    err="${c_red}[err:${exit_code}] "
  fi

  # Virtual environment
  local venv=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="${c_cyan}venv:$(basename "$VIRTUAL_ENV") "
  fi

  # Git branch and dirty marker
  local git_info=""
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    local dirty=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      dirty="*"
    fi
    git_info="${c_gray}git:${c_blue}${branch}${c_red}${dirty} "
  fi

  # Current directory (replace $HOME with ~)
  local dir
  dir=$(dirs +0) # same as $PWD but respects pushd if used

  # Build the [ ... ] part
  PS1="${err}${c_gray}[${c_reset}${venv}${git_info}${c_green}${dir}${c_gray}]${c_reset} ${c_blue}❯${c_reset} "
}

PROMPT_COMMAND=build_prompt
