print_var() {
  if [ -n "$1" ]; then
    if declare -p "$1" 2>/dev/null | grep -q '^declare \-a'; then
      # The variable is array
      printf "%7s : %s\n" "$1" "$(eval echo '${'$1[@]})"
    else
      printf "%7s : %s\n" "$1" ${!1:-(null)}
    fi
  fi
}
