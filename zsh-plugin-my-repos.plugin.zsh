#!/bin/zsh

###
 # My Repos
 #
 # @since Tuesday, April 19, 2022
 ##

###
 # A way to output a dirty message.
 #
 # @since Friday, August 27, 2021
 ##
function __dirty_message {

	full="\e[31m⑂\e[0m \e[33m$1\e[0m is dirty"
	tilde="~"

	echo -e "${full/$HOME/$tilde}"
}

###
 # Wrapper for git-is-clean messaging
 #
 # @since Friday, August 27, 2021
 ##
function __git-is-clean {
	git-is-clean "$1" || ( __dirty_message "$1" )
}

# Watch these repositories for dirtiness.
__git-is-clean "$HOME/Repos/github.com/aubreypwd/iTerm2"
__git-is-clean "$HOME/Repos/github.com/aubreypwd/Alfred.alfredpreferences"
__git-is-clean "$HOME/Repos/github.com/aubreypwd/subl-snippets"
__git-is-clean "$HOME/Repos/github.com/aubreypwd/safari-user-scripts"
__git-is-clean "$HOME/iCloud/Profile Photos"
__git-is-clean "$HOME/.antigen/bundles/aubreypwd/zsh-plugin-my-aliases"

if [[ ! $( command -v vcsh ) ]]; then

	echo "vcsh missing, please install so I can watch pub and priv!"
else

	# Have to do something special here for vcsh.
	vcsh pub diff-index --quiet --ignore-submodules HEAD || __dirty_message "pub"
	vcsh priv diff-index --quiet --ignore-submodules HEAD || __dirty_message "priv"

fi
