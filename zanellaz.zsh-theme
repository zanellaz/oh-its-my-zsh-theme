# literally steeef theme with some archcraft arrows

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('%F{blue}`basename $VIRTUAL_ENV`%f')'
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%} ●"
FMT_STAGED="%{$limegreen%} ●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST})"
        else
            FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

echo "                                          
            ▓▓▓▓▓▓░░                      
          ▒▒▒▒░░░░▒▒░░                    
        ░░▒▒░░░░░░░░▒▒                    
      ░░░░▒▒▒▒░░░░░░▒▒                    
            ░░▒▒▒▒░░▒▒                    
              ▒▒░░░░▒▒                    
          ░░▓▓▒▒░░▒▒                      
        ▒▒▒▒▒▒▒▒▓▓                        
      ▓▓▓▓▓▓▓▓▓▓██░░▒▒▒▒░░                
    ▒▒▓▓▓▓▓▓▓▓██▓▓▒▒░░░░▒▒░░▒▒            
    ▓▓▓▓▓▓██▓▓▒▒░░▒▒▓▓▓▓▒▒░░░░▒▒▒▒        
    ▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░▓▓██▓▓▓▓░░  ▒▒░░    
    ██▓▓██▒▒▒▒▒▒▒▒░░░░░░░░▓▓████▓▓▒▒▒▒    
    ████▓▓▒▒▒▒▒▒░░░░░░▒▒░░░░░░██▒▒▓▓▓▓  ▒▒
    ░░██▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░  ░░░░░░░░  
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▒▒░░  
          ██▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓░░        
            ▒▒▒▒▒▒▓▓▓▓▒▒░░                
                  ░░░░                    
            ░░▒▒▒▒░░▒▒                    " > /tmp/duck-image.txt

neofetch --source /tmp/duck-image.txt | lolcat

echo "-------------------------------------------------------------------------------------"

cowsay -f `ls /usr/share/cowsay/cows/ | shuf -n 1` $(cat /usr/share/splash/splash.txt | awk "NR == $(shuf -i1-$(awk 'END { print NR }' /usr/share/splash/splash.txt) -n1)") | lolcat

echo "𓅰" > /tmp/duck-zsh.txt
function pato {
    pato=$(cat /tmp/duck-zsh.txt)
    if [ $pato = "𓅰" ];
    then
        echo "𓅭" > /tmp/duck-zsh.txt && echo "𓅭";
    else
        echo "𓅰" > /tmp/duck-zsh.txt && echo "𓅰";
    fi
}

function folder {
    if [ -z "$(command ls -A $1)" ]; then
        echo 🗀
    else
        echo 🖿
    fi
}

PROMPT=$'%{$fg_bold[red]%}>%{$fg_bold[cyan]%}>%{$fg_bold[yellow]%}> %{$FG[208]%}%n${PR_RST} %{$FG[015]%}at %{$FG[129]%}%m${PR_RST} %{$FG[015]%}in $(folder) %{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)$(pato)
$ %{$reset_color%}'
