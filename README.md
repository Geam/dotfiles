# Config

Dotfiles backup inspired by https://www.atlassian.com/git/tutorials/dotfiles 

## Pre-requisite

You only need `git`

## Installation

```bash
# Clone the repo
git clone --bare <git-repo-url> ${HOME}/.myconfig

# Add this helper alias in your current shell
alias config="/usr/bin/git --git-dir=${HOME}/.myconfig --work-tree=${HOME}"

# checkout the config
config checkout

# set flag to not show untracked file
config config --local status.showUntrackedFiles no
```

## Usage

```bash
# get the status
config status

# add file
config add .vimrc

# commit
config commit -m "add vimrc"

# push
config push
```
