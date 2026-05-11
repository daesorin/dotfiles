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
  local ext=$?

  # conditional ssh context
  local ctx=""
  if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
    ctx="${c_purple}\u@\h "
  fi

  # virtual environment detection
  local venv=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="${c_cyan}venv:$(basename "$VIRTUAL_ENV") "
  fi

  # git branch and dirty state
  local git_info=""
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    local dirty=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      dirty="*"
    fi
    git_info=" ${c_gray}git:${c_blue}${branch}${c_red}${dirty}"
  fi

  # error catching
  local err=""
  if [ $ext -ne 0 ]; then
    err="${c_red}[err:${ext}] "
  fi

  # final construction
  PS1="\n${err}${ctx}${venv}${c_green}\w${git_info}\n${c_blue}❯${c_reset} "
}

PROMPT_COMMAND=build_prompt
