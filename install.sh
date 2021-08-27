#!/bin/bash
SCRIPT_NAME=$(basename "${BASH_SOURCE:-$0}")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" &>/dev/null && pwd)"
PROJECT_ROOT_DIR="$(cd "${SCRIPT_DIR}" &>/dev/null && pwd)"
DOTFILES_DIR="${PROJECT_ROOT_DIR}/dotfiles"
TIMESTAMP=$(date +%Y.%m.%d-%H.%M.%S)

function usage() {
  cat <<EOS

   Usage: ${SCRIPT_NAME} [--force] [--verbose] [--dry-run]

   optional arguments:
     -h, --help           show this help message and exit
     -f, --force          install dotfiles, must pass this option explicitly 
     -v, --verbose        increase the verbosity of the bash script
     -n, --dry-run        do a dry run, dont change any files, default true

EOS
}

POSITIONAL=()
DRYRUN="true"
VERBOSE="false"
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -h | --help)
    usage
    exit
    ;;
  -f | --force)
    DRYRUN="false"
    shift
    ;;
  -v | --verbose)
    VERBOSE="true"
    shift
    ;;
  -n | --dry-run)
    shift
    ;;
  *) # unknown option
    POSITIONAL+=("$1")
    shift
    ;;
  esac
done

DATA_DIR="${XDG_DATA_HOME:-"${HOME}/.local/share"}/dotfiles"
STATE_DIR="${XDG_STATE_HOME:-"${HOME}/.local/state"}/dotfiles"
BACKUP_DIR="${DATA_DIR}/backup"
MARKER_FILE="${STATE_DIR}/marker-file"

function vcat() {
  # verbose cat
  if "${VERBOSE}"; then
    cat "$@"
  fi
}

function dryrun_command() {
  if "${DRYRUN}"; then
    echo "$@"
  else
    "$@"
  fi
}

backup_recursively() {
  local src="$(realpath "$1")"
  local dest="${BACKUP_DIR}/$(basename "${src}")"

  if [ -n "${BACKED_UP_DOTFILES["${src}"]}" ]; then
    echo "This entry is already backed up. skipping. ${src}" | vcat -
    return 0
  fi

  if [ -e "${src}" ]; then
    echo "backup: $src $dest" | vcat -
    dryrun_command cp -R $src $dest
  else
    echo "The source file/directory not found, no need to backup: ${src}" | vcat - 1>&2
  fi

  # mark as backed up
  BACKED_UP_DOTFILES["${src}"]="${dest}"
}

write_marker_file() {
  echo "Write marker file. ${MARKER_FILE}"
    cat - <<EOS | tee ${MARKER_FILE}
EOS
  for key in "${!BACKED_UP_DOTFILES[@]}"; do
    echo "BACKED_UP_DOTFILES[\""${key}"\"]=\""${BACKED_UP_DOTFILES[${key}]}"\"" | tee -a ${MARKER_FILE}
  done
}

if "${DRYRUN}"; then
  echo "Dry run mode defaults to true. nothing to do." 1>&2
  echo "Pass the -f option to install dotfiles." 1>&2
  echo "" 1>&2
fi

# Ensure the directories exist
mkdir -p "${STATE_DIR}"
mkdir -p "${DATA_DIR}"
mkdir -p "${BACKUP_DIR}"

# Load markers to see which steps have already run
declare -A BACKED_UP_DOTFILES
if [ -f "${MARKER_FILE}" ]; then
  echo "Marker file found:" | vcat -
  vcat "${MARKER_FILE}"
  source "${MARKER_FILE}"
fi

# backup original dotfiles
root_entries=$(ls -1a ${DOTFILES_DIR}/ | tail -n +3)
for root_entry in ${root_entries}; do
  original_path="${HOME}/${root_entry}"
  backup_recursively "${original_path}"
done

# Write marker file
dryrun_command write_marker_file

# List dotfiles in this repo
dotfiles=$(find ${DOTFILES_DIR}/ -type f)

# just overwrite dotfiles
for src in $dotfiles; do
  relative_path=$(realpath --relative-to "${DOTFILES_DIR}" "${src}")
  dest="${HOME}/${relative_path}"
  dryrun_command mkdir -p $(dirname ${dest})
  dryrun_command cp ${src} ${dest}
done
