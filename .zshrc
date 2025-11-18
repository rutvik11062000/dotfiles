
# Set up fzf key bindings and fuzzy completion
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
function nvml() {
  export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
}

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
source ~/zsh-snap/znap.zsh


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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# gem path
export PATH="$PATH:$HOME/.rvm/gems/ruby-3.0.0"
export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export PATH="/Users/ritvik/Downloads/nvim-macos-x86_64/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export DISABLE_SPRING=true


# personal alias
alias r='cd ~/bscode/railsApp/ && code .'
alias s='cd ~/bscode/SeleniumHub/ && code .'
alias i='cd ~/bscode/infra-config/ && code .'
export PATH=$PATH:/opt/homebrew/bin:/Users/ritvik/.rvm/gems/ruby-2.6.6/bin:/Users/ritvik/.rvm/gems/ruby-2.6.6@global/bin:/Users/ritvik/.rvm/rubies/ruby-2.6.6/bin:/usr/local/opt/openssl@1.0/bin:/Users/ritvik/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/ritvik/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export ANDROID_HOME=$HOME/Library/Android/sdk

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

vault_login() {
    export VAULT_ADDR=https://gandalf.browserstack.com
    # You'll need to set your GitHub token: export GITHUB_TOKEN=your_token_here
    vault login -method=github token=$GITHUB_TOKEN > foo.txt
}

ssl_cert() {
  vault_login()
  vault kv get -field value /prod/certs/local_bsstag_com_crt > bsstag.com.crt
  vault kv get -field value /prod/certs/local_bsstag_com_key > bsstag.com.key
}

vault_creds() {
  vault_login
  echo "greenmini: $(vault kv get -field value /prod/core/smokeping/users/greenmini/password)"
  echo "mobile deploy: $(vault kv get -field value /prod/show/mobile/deploy-ui/pass/0)"
  echo "deploy_admin: $(vault kv get -field value /prod/platform/deploy_admin)"
  echo "kibana_viewer: $(vault kv get -field value /prod/chitragupta_keys/elasticsearch/kibana_viewer)"
}

# echo 'if which jenv > /dev/null; then eval "$(jenv init -)"; fi'
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH=$PATH:/Users/ritvik/Downloads/elasticsearch-6.8.1/bin
export PATH=$PATH:/Users/ritvik/Downloads/kibana-6.8.1-darwin-x86_64/bin

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

download_using_ip() {
  machine_ip=$1
  root_path=$2
  download_path=$3
  ssh -J rutvik.c@hop.browserstack.com rutvik.c@$machine_ip "sudo chmod -R +r $root_path/*"
  scp -o ProxyJump=rutvik.c@hop.browserstack.com rutvik.c@$machine_ip:$download_path .
}
export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export PATH="/usr/local/opt/influxdb@1/bin:$PATH"
export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"
export PATH="/Users/ritvik/Downloads/browsermob-proxy-2.1.4/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@8.0/lib/pkgconfig"
# Added by GDK bootstrap
# source /Users/ritvik/.asdf/asdf.sh
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export BDK_BASE_DIR="/Users/ritvik/bscode/bdk"

# Added by Windsurf
export PATH="/Users/ritvik/.codeium/windsurf/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ritvik/bscode/automate-debugging-utilities/deploy-metrics/google-cloud-sdk/completion.zsh.inc'; fi
