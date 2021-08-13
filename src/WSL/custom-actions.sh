################################################################################
#                                  ZSH Aliases                                 #
################################################################################

## Edit Zsh configuration
alias editprofile="vim $HOME/.zshrc"

## Refresh Zsh configuration
alias sourceprofile="source $HOME/.zshrc"

################################################################################
#                              Directories Aliases                             #
################################################################################

## Create folder and navigate to it
mkcd() {
  mkdir -p -v "$1"
  cd "$1"
}

################################################################################
#                          System Maintenance Aliases                          #
################################################################################

## Update system
updsys() {
  sudo apt --yes update;
  sudo apt --yes upgrade;
}

################################################################################
#                         Environment Variables Aliases                        #
################################################################################

## List the content of PATH environment variables
alias pathl="echo '$PATH' | tr ':' '\n' | nl"

################################################################################
#                                  Git Aliases                                 #
################################################################################

## Git soft reset last commit
alias gsrlc="git reset --soft HEAD^1"

## Git clone, load submodules and navigate to the repository folder
gsc() {
  git clone "$1";
  cd "$(basename "$1" .git)";
  git submodule init;
  git submodule update;
}

################################################################################
#                                  Vim Aliases                                 #
################################################################################

## Edit init.vim file
alias editvim="vim $HOME/.vimrc"

## Refresh Vim configuration
alias sourcevim="source $HOME/.vimrc"

################################################################################
#                                Docker Aliases                                #
################################################################################

## Download Docker image
alias dpl="docker pull"

## List the Docker containers working
alias dlc="docker container ls"

## List all the Docker containers
alias dlca="docker container ls -a"

## List all the Docker images
alias dli="docker images"

## Stop Docker container
alias dsc="docker container stop"

## Delete Docker container
alias drc="docker container rm"

## Delete Docker image
alias dri="docker image rm"

################################################################################
#                                  NPM Aliases                                 #
################################################################################

## List global NPM packages
alias ngl="npm list -g"

## List outdated global NPM packages
alias ngo="npm outdated -g"

## Update global NPM package
alias ngu="sudo npm update -g"

################################################################################
#                                 Yarn Aliases                                 #
################################################################################

## Install Yarn package
alias yi="yarn add"

## Install Yarn package as dev dependency
yid() {
  yarn add "$1" -D
}

## List all Yarn packages locally installed
alias yl="yarn list"

## List outdated Yarn packages locally installed
alias ylo="yarn outdated"

## Update Yarn package
alias yu="yarn upgrade"

## Upgrade all Yarn packages
alias yua="yarn-upgrade-all"

## Remove Yarn package
alias yr="yarn remove"

################################################################################
#                                NestJS Aliases                                #
################################################################################

## Create a new project with NestJS
nestnew() {
  nest new "$1" --package-manager 'yarn' --skip-install --language 'TS'
  cd "$1"
  gaa
  gcmsg "Initial commit"
}

################################################################################
#                                Angular Aliases                               #
################################################################################

## Create a new project with Angular
ngnew() {
  ng new --package-manager 'yarn' --skip-install --strict --style 'css' --commit false --routing "$1"
  cd "$1"
  gaa
  gcmsg "Initial commit"
}

################################################################################
#                                  Go Aliases                                  #
################################################################################

## Initialize Go modules
alias gmi="go mod init"