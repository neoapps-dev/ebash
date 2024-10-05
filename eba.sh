#!/bin/bash

#                                                                                             
#                                                                                             
#                    BBBBBBBBBBBBBBBBB                                    hhhhhhh             
#                    B::::::::::::::::B                                   h:::::h             
#                    B::::::BBBBBB:::::B                                  h:::::h             
#                    BB:::::B     B:::::B                                 h:::::h             
#      eeeeeeeeeeee    B::::B     B:::::B  aaaaaaaaaaaaa      ssssssssss   h::::h hhhhh       
#    ee::::::::::::ee  B::::B     B:::::B  a::::::::::::a   ss::::::::::s  h::::hh:::::hhh    
#   e::::::eeeee:::::eeB::::BBBBBB:::::B   aaaaaaaaa:::::ass:::::::::::::s h::::::::::::::hh  
#  e::::::e     e:::::eB:::::::::::::BB             a::::as::::::ssss:::::sh:::::::hhh::::::h 
#  e:::::::eeeee::::::eB::::BBBBBB:::::B     aaaaaaa:::::a s:::::s  ssssss h::::::h   h::::::h
#  e:::::::::::::::::e B::::B     B:::::B  aa::::::::::::a   s::::::s      h:::::h     h:::::h
#  e::::::eeeeeeeeeee  B::::B     B:::::B a::::aaaa::::::a      s::::::s   h:::::h     h:::::h
#  e:::::::e           B::::B     B:::::Ba::::a    a:::::assssss   s:::::s h:::::h     h:::::h
#  e::::::::e        BB:::::BBBBBB::::::Ba::::a    a:::::as:::::ssss::::::sh:::::h     h:::::h
#   e::::::::eeeeeeeeB:::::::::::::::::B a:::::aaaa::::::as::::::::::::::s h:::::h     h:::::h
#    ee:::::::::::::eB::::::::::::::::B   a::::::::::aa:::as:::::::::::ss  h:::::h     h:::::h
#      eeeeeeeeeeeeeeBBBBBBBBBBBBBBBBB     aaaaaaaaaa  aaaa sssssssssss    hhhhhhh     hhhhhhh
#                                                                                             
#                                                                                             
#                                                                                             
#                                                                                             
#                                                                                             
#                                                                                             
#         

###############################################################
#####                 eBash -- Easier Bash --             ##### 
#####  THIS CODE IS LICENSED UNDER THE GNU GPL V3 LICENSE ##### 
#####           READ LICENSE FILE FOR MORE INFO           ##### 
#####                                                     ##### 
#####                Made by NEOAPPS :)                   ##### 
###############################################################

# Important note: This script is meant to be used as a reference for your own bash scripts.
# You can customize it to fit your needs.

# This script contains a variety of aliases and functions to make your bash experience easier.


EBASH_VERSION=1.0.0


alias import=source # usage: import file.sh
alias ebash="echo eBash -- Version $EBASH_VERSION;" # usage: ebash
alias debug="set -x" # usage: debug
alias debugoff="set +x" # usage: debugoff
alias ll='ls -la' # usage: ll
alias l='ls -l' # usage: l
alias ls='ls --color=auto' # usage: ls
alias rmf='rm -rf' # usage: rmf file.txt
alias mkd='mkdir -p' # usage: mkd dir
alias c='clear' # usage: c
alias user_cp='rsync -ah --info=progress2' # usage: user_cp file.txt file2.txt
alias user_mv='mv -i' # usage: user_mv file.txt file2.txt
alias myip='curl ifconfig.me' # usage: myip
alias mypip="hostname -I | awk '{print $1}'" # usage: mypip
alias flushdns='sudo systemctl restart systemd-resolved' # GNU/LINUX ONLY AND PROBABLY MACOS         # usage: flushdns
alias gs='git status' # usage: gs
alias gc='git commit -m' # usage: gc "first commit"
alias gp='git push' # usage: gp
alias ga='git add *' # usage: ga
alias gl='git log --oneline --graph --decorate' # usage: gl
alias dps='docker ps' # usage: dps
alias di='docker images' # usage: di
alias drm='docker rm $(docker ps -a -q)' # usage: drm   # DELETES ALL RUNNING IMAGES
alias drmi='docker rmi $(docker images -q)' # usage: drmi  # DELETES ALL IMAGES
alias ~='cd ~' # usage: ~
alias docs='cd ~/Documents' # usage: docs
alias dl='cd ~/Downloads' # usage: dl
alias ports='netstat -a; echo ^C' # usage: ports
alias meminfo='free -h' # usage: meminfo
alias diskinfo='df -h' # usage: diskinfo
alias cpuinfo='lscpu' # usage: cpuinfo
alias grep='grep --color=auto -n' # usage: grep
alias exit_on_error="set -e; trap 'echo eBash: Error on line $LINENO.' ERR" # usage: exit_on_error
alias uuid="cat /proc/sys/kernel/random/uuid" # usage: uuid
alias dc='docker-compose' # usage: dc
alias dcb='docker-compose build' # usage: dcb
alias dcu='docker-compose up' # usage: dcu
alias dcd='docker-compose down' # usage: dcd
alias dstop='docker stop $(docker ps -aq)' # usage: dstop   # stops all running docker containers

alias dmsg='dialog --msgbox'
alias dyesno='dialog --yesno'
alias dinput='dialog --inputbox'
alias dmenu='dialog --menu'
alias dgauge='dialog --gauge'

alias wmsg='whiptail --msgbox'
alias wyesno='whiptail --yesno'
alias winput='whiptail --inputbox'
alias wmenu='whiptail --menu'
alias wgauge='whiptail --gauge'


_help_=false
_version_=false
_file_=false
_output_=false
_input_=false
job_queue=()

log() { # usage: log INFO hi
    local level="$1"; shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $2" >> $3
}
reload() { # usage: reload
    source ~/.bashrc
    log INFO "Shell reloaded."
}
echoe() { # usage: echoe "This is a \e[1;32mgreen\e[0m text!"
    local text="$1"; shift
    echo -e "$text" | sed 's/\\e/\\033/g'
}
main() { # Sets _type_ to the argument type. useful for CLIs
for arg in "$@"; do
    case $arg in
        -h|--help|-help)
            _help_=true
            ;;
    esac
	case $arg in
        -v|--version|-version)
            _version_=true
            ;;
    esac
	case $arg in
        -f|--file|-file)
            _file_=true
            ;;
    esac
	case $arg in
        -o|--output|-output)
            _output_=true
            ;;
    esac
	case $arg in
        -i|--input|-input)
            _input_=true
            ;;
    esac
done
}
extract() { # usage: extract archive.zip
    local file="$1"
    if [[ -f "$file" ]]; then
        case "$file" in
            *.tar.bz2) tar xvjf "$file" ;;
            *.tar.gz) tar xvzf "$file" ;;
            *.tar.xz) tar xvJf "$file" ;;
            *.bz2) bunzip2 "$file" ;;
            *.rar) unrar x "$file" ;;
            *.gz) gunzip "$file" ;;
            *.tar) tar xvf "$file" ;;
            *.tbz2) tar xvjf "$file" ;;
            *.tgz) tar xvzf "$file" ;;
            *.zip) unzip "$file" ;;
            *.Z) uncompress "$file" ;;
            *.7z) 7z x "$file" ;;
            *) die "eBash: Cannot extract $file. Unknown Format" ;;
        esac
        log INFO "eBash: Extracted: $file" ebash.log
    else
        die "eBash: File not found: $file"
    fi
}
check_url() { # usage: check_url https://google.com
    local url="$1"
    if curl -Is "$url" | head -n 1 | grep "200 OK" &>/dev/null; then
        log INFO "Website is up: $url"
    else
        log ERROR "Website is down: $url"
    fi
}
download_unzip() { # usage: download_unzip https://example.com/file.zip
    local url="$1"
    local target_dir="$2"
    local filename=$(basename "$url")

    log INFO "Downloading $url..."
    curl -O "$url" || die "eBash: Failed to download $url"

    log INFO "Unzipping $filename to $target_dir..."
    unzip "$filename" -d "$target_dir" || die "eBash: Failed to unzip $filename"
}
yes() { # usage: yes | command
    while true; do echo "y"; done
}
no() { # usage: no | command
    while true; do echo "n"; done
}
user_kill() { # usage: user_kill firefox
    local process_name="$1"
    if pgrep "$process_name" &>/dev/null; then
        echo "Process $process_name is running. Kill it? [y/N]"
        read -r confirm
        if [[ "$confirm" == [yY] ]]; then
            pkill "$process_name"
            log INFO "Killed process: $process_name"
        else
            log INFO "Process not killed: $process_name"
        fi
    else
        log INFO "No running process found for: $process_name"
    fi
}
require_root() { # usage: require_root
    if [[ "$EUID" -ne 0 ]]; then
        die "This script must be run as root."
    fi
}
die() { # usage: die "Failed to execute command"
	log "ERROR" "$1"
    echo "$1" >&2
    exit 1
}
retry() { # usage: retry 5 1 ping hdhdhdhd.com
    local retries="$1"; shift
    local delay="$2"; shift
    local attempt=0

    until "$@"; do
        attempt=$(( attempt + 1 ))
        if [[ "$attempt" -ge "$retries" ]]; then
            die "Command failed after $retries attempts."
        fi
        log WARN "Retrying ($attempt/$retries)..."
        sleep "$delay"
    done
}
benchmark() { # usage: benchmark ping google.com
    local start_time=$(date +%s)
    "$@"
    local end_time=$(date +%s)
    local elapsed=$(( end_time - start_time ))
    echo "eBash: Time taken: $elapsed seconds."
}
confirm() { # usage: confirm "Are you sure to delete this file?" rm file.txt
    local prompt="$1"; shift
    read -p "$prompt [y/N]: " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        "$@"
    else
        echo ""
    fi
}
check_space() { # usage: check_space 1000      # checks if there is atleast a gigabyte available
    local min_space_mb="$1"
    local available=$(df / | tail -1 | awk '{print $4}')
    if (( available < min_space_mb * 1024 )); then
        echo "Not enough space. Need at least ${min_space_mb}MB."
        exit 1
    else
        $@
    fi
}
update_system() {
    if command -v apt > /dev/null; then
        sudo apt update && sudo apt upgrade -y
    elif command -v dnf > /dev/null; then
        sudo dnf upgrade --refresh
    elif command -v pacman > /dev/null; then
        sudo pacman -Syu
    else
        errore "No compatible package manager found."
    fi
}

load_env() { # usage: load_env   # loads .env file
    if [[ -f ".env" ]]; then
        export $(grep -v '^#' .env | xargs)
    else
        echo "eBash: .env file not found."
    fi
}
filesize() { # usage: filesize file.txt
    local file="$1"
    if [[ -f "$file" ]]; then
        du -sh "$file" | awk '{print $1}'
    else
        echo "eBash: File not found. $1"
    fi
}
errore() { # usage: errore "Error message"
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}
backupe() { # usage: backupe /path/to/file
    local src="$1"
    local backup="$src.$(date +'%Y%m%d%H%M%S').bak"
    cp -r "$src" "$backup"
    log INFO "Backup of $src created at $backup" ebash.log
}
upper() { # usage: upper "hello"
    echo "$1" | tr '[:lower:]' '[:upper:]'
}
lower() { # usage: lower "hello"
    echo "$1" | tr '[:upper:]' '[:lower:]'
}
timestamp() { # usage: timestamp
    date +"%Y-%m-%d %H:%M:%S"
}
checknet() { # usage: checknet
    if ping -c 1 google.com &> /dev/null; then
        echo "Network is available."
    else
        errore "No network connection."
    fi
}
jsonp() { # usage: jsonp '{"key": "value"}' key
    local json="$1"
    local key="$2"
    if command -v jq > /dev/null; then
        echo "$json" | jq -r "$key"
    else
        errore "'jq' is required for JSON parsing."
    fi
}
randome() { # usage: randome 8
    local length="${1:-12}"
    < /dev/urandom tr -dc 'A-Za-z0-9_@#%^&*' | head -c "$length"; echo
}
spin() { # usage: spin [PID]     # shows a loading until the proccess [PID] ends
    local pid=$1
    local delay=0.1
    local spinchars="/-\|"
    while ps -p $pid > /dev/null; do
        for i in $(seq 0 3); do
            echo -ne "\r${spinchars:i:1}  "
            sleep $delay
        done
    done
    echo -ne "\r"
}
checkdep() { # usage: checkdep [DEP]          # Checks if [DEP] is installed and if not, it will tell the user
    for cmd in "$@"; do
        command -v "$cmd" >/dev/null 2>&1 || handle_error 1 "$cmd is required but not installed."
    done
}
sigint() { # not in-use by scripts. it's in use by eBash.
	echo eBash: INTERRUPT SIGNAL RECEIVED. EXITING...
	exit 1
}
add_job() { # usage: add_job [COMMAND] [ARGS]
    job_queue+=("$@")
}
run_jobs() { # usage: run_jobs
    for job in "${job_queue[@]}"; do
        $job &
    done
    wait
}
getinput() { # usage: getinput
    local input
    while true; do
        read -p "$1" input
        if [[ -n "$input" ]]; then
            echo "$input"
            break
        else
            echo "Input cannot be empty. Please try again."
        fi
    done
}
installpkg() { # usage: installpkg [PACKAGES]
    case $(uname) in
        Linux)
            if [ -f /etc/arch-release ]; then
                sudo pacman -S --noconfirm "$@"  # Arch-based systems
            elif [ -f /etc/fedora-release ]; then
                sudo dnf install -y "$@"          # Fedora-based systems
            elif [ -f /etc/debian_version ]; then
                sudo apt install -y "$@"           # Debian-based systems
            elif [ -f /etc/mandrake-release ]; then
                sudo urpmi "$@"                     # Mandrake/Mandriva systems
            elif [ -f /etc/SuSE-release ]; then
                sudo zypper install -y "$@"         # openSUSE systems
            elif [ -f /etc/redhat-release ]; then
                sudo yum install -y "$@"            # RHEL/CentOS systems
            elif [ -f /etc/gentoo-release ]; then
                sudo emerge "$@"                     # Gentoo systems
            elif [ -f /etc/alpine-release ]; then
                sudo apk add "$@"                    # Alpine GNU/Linux
            elif [ -f /etc/void-release ]; then
                sudo xbps-install -y "$@"            # Void GNU/Linux
            elif [ -f /etc/solus-release ]; then
                sudo eopkg install "$@"               # Solus
            elif [ -f /etc/puppy-version ]; then
                echo "Please use PPM or suitable command for Puppy GNU/Linux to install '$@'"
                return 1
            elif [ -f /etc/NixOS ]; then
                nix-env -iA nixpkgs."$@"            # NixOS
            elif [ -f /etc/clear-linux/os-release ]; then
                sudo swupd bundle-add "$@"           # Clear GNU/Linux
            elif [ -f /etc/deepin-version ]; then
                sudo apt install -y "$@"             # Deepin (based on Debian)
            elif [ -f /etc/slackware-version ]; then
                sudo slackpkg install "$@"            # Slackware
            elif [ -f /etc/artix-release ]; then
                sudo pacman -S --noconfirm "$@"      # Artix (Arch-based)
            elif [ -f /etc/raspbian_version ]; then
                sudo apt install -y "$@"              # Raspbian
            elif [ -f /etc/linuxmint/version ]; then
                sudo apt install -y "$@"              # GNU/Linux Mint
            elif [ -f /etc/zorin-release ]; then
                sudo apt install -y "$@"              # Zorin OS
            elif [ -f /etc/peppermint-version ]; then
                sudo apt install -y "$@"              # Peppermint OS
            elif [ -f /etc/parrot-version ]; then
                sudo apt install -y "$@"              # Parrot Security OS
            elif [ -f /etc/kaos-release ]; then
                sudo pacman -S --noconfirm "$@"      # KaOS
            else
                echo "Unsupported GNU/Linux distribution"
                return 1
            fi
            ;;
        Darwin)
            brew install "$@"  # macOS/Darwin
            ;;
		FreeBSD)
			sudo pkg install "$@"   # FreeBSD
			;;
		OpenBSD)
            sudo pkg_add "$@"          # OpenBSD
            ;;
        NetBSD)
            sudo pkg_add "$@"          # NetBSD
            ;;
        *)
            echo "Unsupported OS"
            return 1
            ;;
    esac
}

main "$@"
trap sigint SIGINT