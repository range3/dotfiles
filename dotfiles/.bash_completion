_goto() {
  local opt cur
  COMPREPLY=()
  if [ $COMP_CWORD -lt 2 ]; then
    opt=$(ls -1 "$HOME/.bookmarks" 2>/dev/null)
    cur="${COMP_WORDS[${COMP_CWORD}]}"
    COMPREPLY=($(compgen -W "${opt}" -- "${cur}"))
  fi
}
complete -F _goto goto
