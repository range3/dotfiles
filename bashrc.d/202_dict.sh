# GENE95 dictionary
# http://www.namazu.org/~tsuchiya/sdic/data/gene.html

DICT_PATH="${HOME}/.gene.txt"

function ejdict() {
  if [ -f "${DICT_PATH}" ]; then
    grep "$*" "${DICT_PATH}" -E -A 1 -wi --color=always | less -R -FX
  fi
}

alias dict=ejdict

function jedict() {
  if [ -f "${DICT_PATH}" ]; then
    grep "$*" "${DICT_PATH}" -E -B 1 -wi --color=always | less -R -FX
  fi
}

