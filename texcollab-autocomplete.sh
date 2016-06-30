#!/usr/bin/env bash

function _texcollab(){
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local prev="${COMP_WORDS[COMP_CWORD-1]}"

	# options we will complete
    local opts="init clone branch add-collab commit push pull extras compile \
        compare log view status save new push-all pull-all help usage"

    # if the previous command is a plain file, return branches/revisions
    if [ -f "${prev}" ]; then
        local branches=$(git branch | sed 's/\*//')
        COMPREPLY=($(compgen -W "${branches}" -- ${cur}))
        return 0
    fi

	case "${prev}" in
        texcollab)
			COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
			return 0
			;;
		branch)
			local branches=$(git branch | sed 's/\*//')
			COMPREPLY=($(compgen -W "${branches}" -- ${cur}))
			return 0
			;;
        extras)
            local commands="push pull"
            COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
            return 0
            ;;
		*)
            COMPREPLY=($(compgen -W "$(git ls-files)" -- ${cur}))
			return 0
			;;
	esac
}
complete -F _texcollab texcollab
