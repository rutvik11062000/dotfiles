
# Set up fzf key bindings and fuzzy completion
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
function nvml() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
    [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

    # ensure active nvm version is first
    export PATH="$NVM_BIN:$PATH"
}

# portkey
export PORTKEY_API_KEY='Zwla7QFANFO2cK/bYemY3JJrDfRc'

# nvml

export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

function txa() {
  tmux attach -t $1
}


function rosetta() {
  arch -x86_64 zsh
}

alias vmrss="/Users/ritvik/vmrss.sh"
alias tx='tmux'

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# source /Users/ritvik/bscode/SeleniumHub/script/hub_machines_aliases.sh


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ========== ENVIRONMENT VARIABLES ==========
export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export DISABLE_SPRING=true
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/ritvik/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

winssh() {
 ssh -o PubkeyAcceptedAlgorithms=+ssh-rsa -p 4022 Administrator@"$1" 
}


macssh() {
    ssh -p 4022 ritesharora@"$1"
}

mssh() {
  ssh -A app@"$1" -p 4022
}

prodssh() {
    ssh -J rutvik.c@hop.browserstack.com rutvik.c@"$1"
}

prodappssh() {
    ssh -J rutvik.c@hop.browserstack.com app@"$1"
}

bssh() {
  python3 /Users/ritvik/bscode/bstackssh/ssh_manager.py
}

# echo 'if which jenv > /dev/null; then eval "$(jenv init -)"; fi'
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export ANDROID_HOME=$HOME/Library/Android/sdk
export BDK_BASE_DIR="/Users/rutvik/bscode/bdk"

# function ios_scrcpy() {
#   ps aux | grep ssh | grep 45671 | awk '{print $2}' | xargs kill

#   ssh -CN -A -p 4022 -L 45671:localhost:45671 app@$1 &
#   sleep 6
#   open "http://localhost:45671/snapshot?device=$2&cheap_stream=true"
# }

# function clunky_live() {
#   UDID=$1
#   if [ -z $2 ]; then
#       IP=`<path to mobile knife gem> $UDID --ip` # e.g /Users/<yourusername>/.rvm/gems/<ruby-version>/bin/mobile-knife
#   else
#       IP=$2
#   fi
#   set -x
#   lsof -i | grep 5037 |  awk '{ print $2 }' | xargs kill -9
#   ps aux | grep ssh | grep localhost | awk '{ print $2 }' | xargs kill -9
#   ssh -CN -L5037:localhost:5037 -L27183:localhost:27183 ritesharora@$IP -p 4022 &
#   adb_running=`lsof -i | grep 5037 | grep adb`
#   adb kill-server
#   sleep 1
#   scrcpy -w --force-adb-forward -s $UDID -b1m -m800
# }



download_using_ip() {
  machine_ip=$1
  root_path=$2
  download_path=$3
  ssh -J rutvik.c@hop.browserstack.com rutvik.c@$machine_ip "sudo chmod -R +r $root_path/*"
  scp -o ProxyJump=rutvik.c@hop.browserstack.com rutvik.c@$machine_ip:$download_path .
}

h_ide() {
  cd /Users/rutvik/hcode/ideaas-frontend
  tmux rename-window ideaas
  nvml
  nvm use
}

h_vs() {
  cd /Users/rutvik/hcode/hackerrank-vscode/
  tmux rename-window hvscode
  nvml
  nvm use
}

h_co() {
    cd /Users/rutvik/hcode/hackerrank-vscode-copilot-chat
    tmux rename-window hvscode
    nvml
    nvm use
}

alias o="opencode ."

# Added by GDK bootstrap
# source /Users/ritvik/.asdf/asdf.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

# Google Cloud SDK
if [ -f '/Users/rutvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/path.zsh.inc' ]; then 
  . '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/rutvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/completion.zsh.inc' ]; then 
  . '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/completion.zsh.inc'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rutvik/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rutvik/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rutvik/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rutvik/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

DISABLE_AUTO_TITLE="true"

# ========== CONSOLIDATED PATH SETUP ==========
# Build PATH with all directories in priority order
export PATH_CUSTOM=""
PATH_CUSTOM="$PATH_CUSTOM:$HOME/.bun/bin"                                    # Bun
PATH_CUSTOM="$PATH_CUSTOM:/Users/rutvik/.opencode/bin"                       # OpenCode
PATH_CUSTOM="$PATH_CUSTOM:/Users/rutvik/.codeium/windsurf/bin"               # Windsurf
PATH_CUSTOM="$PATH_CUSTOM:$HOME/.local/bin"                                  # Local bin
PATH_CUSTOM="$PATH_CUSTOM:/opt/homebrew/bin"                                 # Homebrew
PATH_CUSTOM="$PATH_CUSTOM:/opt/homebrew/sbin"                                # Homebrew sbin
PATH_CUSTOM="$PATH_CUSTOM:/opt/homebrew/opt/openssl@3/bin"                   # OpenSSL 3
PATH_CUSTOM="$PATH_CUSTOM:/opt/homebrew/opt/libpq/bin"                       # PostgreSQL (homebrew)
PATH_CUSTOM="$PATH_CUSTOM:/usr/local/opt/openssl@1.0/bin"                    # OpenSSL 1.0
PATH_CUSTOM="$PATH_CUSTOM:/usr/local/opt/influxdb@1/bin"                     # InfluxDB
PATH_CUSTOM="$PATH_CUSTOM:/usr/local/opt/mysql@8.0/bin"                      # MySQL
PATH_CUSTOM="$PATH_CUSTOM:/usr/local/opt/libpq/bin"                          # PostgreSQL (local)
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/Downloads/browsermob-proxy-2.1.4/bin" # BrowserMob Proxy
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/Downloads/elasticsearch-6.8.1/bin"   # Elasticsearch
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/Downloads/kibana-6.8.1-darwin-x86_64/bin" # Kibana
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/Downloads/nvim-macos-x86_64/bin"    # NeoVim
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/.rvm/gems/ruby-3.0.0/bin"           # RVM Ruby 3.0
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/.rvm/gems/ruby-2.6.6/bin"           # RVM Ruby 2.6
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/.rvm/gems/ruby-2.6.6@global/bin"    # RVM Global 2.6
PATH_CUSTOM="$PATH_CUSTOM:/Users/ritvik/.rvm/rubies/ruby-2.6.6/bin"         # RVM Rubies 2.6
export EDITOR=nvim
export PATH="$PATH_CUSTOM:$PATH"

# bun completions
[ -s "/Users/rutvik/.bun/_bun" ] && source "/Users/rutvik/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@8.0/lib/pkgconfig"
