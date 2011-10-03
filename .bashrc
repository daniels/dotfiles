export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:$PATH
export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
if [ -f /opt/local/etc/bash_completion ]; then
	source /opt/local/etc/bash_completion
fi
# Git in the prompt
#PS1='[\u@\h:\W$(__git_ps1 " (%s)")]\$ '

# Use ~/.shenv for system specific config
# source ~/.shenv now if it exists
test -r ~/.shenv &&
source ~/.shenv

# rvm-install added line:
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
