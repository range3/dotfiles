#!/bin/bash
SCRIPT_NAME=$(basename "${BASH_SOURCE:-$0}")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" &>/dev/null && pwd)"
PROJECT_ROOT_DIR="$(cd "${SCRIPT_DIR}" &>/dev/null && pwd)"
DOTFILES_DIR="${PROJECT_ROOT_DIR}/dotfiles"
DOTFILES_PRIVATE_DIR="${PROJECT_ROOT_DIR}/externals/dotfiles-private/dotfiles"
TIMESTAMP=$(date +%Y.%m.%d-%H.%M.%S)

function usage() {
  cat <<EOS

   Usage: ${SCRIPT_NAME} [--verbose] [--dry-run]

   optional arguments:
     -h, --help           show this help message and exit
     -v, --verbose        increase the verbosity of the bash script
     -n, --dry-run        do a dry run, dont change any files

EOS
}

POSITIONAL=()
DRYRUN="false"
VERBOSE="false"
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -h | --help)
    usage
    exit
    ;;
  -v | --verbose)
    VERBOSE="true"
    shift
    ;;
  -n | --dry-run)
    DRYRUN="true"
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

list_relative_file_path() {
  local base_dir="$(realpath "$1")"
  [ -d "${base_dir}" ] && \
    find "${base_dir}/" -type f | xargs -r -L 1 realpath --relative-to="${base_dir}"
}

backup() {
  local relative_file="$1"
  local src_base_dir="${HOME}"
  local dest_base_dir="${BACKUP_DIR}"
  local src="${src_base_dir}/${relative_file}"
  local dest="${dest_base_dir}/${relative_file}"

  if [ -n "${BACKED_UP_DOTFILES["${src}"]}" ]; then
    echo "This entry is already backed up. skipping. ${src}" | vcat -
    return 0
  fi

  if [ -e "${src}" ]; then
    echo "backup: $src to $dest" | vcat -
    dryrun_command cd "${src_base_dir}" && \
    dryrun_command cp --parents --preserve=mode "$relative_file" "$dest_base_dir"
  else
    echo "The source file/directory not found, no need to backup: ${src}" | vcat - 1>&2
  fi

  # mark as backed up
  BACKED_UP_DOTFILES["${src}"]="${dest}"
}

write_marker_file() {
  echo "Write marker file. ${MARKER_FILE}" | vcat -
  cat - <<EOS > ${MARKER_FILE}
EOS
  for key in "${!BACKED_UP_DOTFILES[@]}"; do
    echo "BACKED_UP_DOTFILES[\""${key}"\"]=\""${BACKED_UP_DOTFILES[${key}]}"\"" >> ${MARKER_FILE}
  done
}

if "${DRYRUN}"; then
  echo "Dry run mode." 1>&2
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

# backup dotfiles in the home directory
relpath_dotfiles=$(list_relative_file_path "${DOTFILES_DIR}"; list_relative_file_path "${DOTFILES_PRIVATE_DIR}")
for relpath_dotfile in ${relpath_dotfiles}; do
  backup ${relpath_dotfile}
done

# Write marker file
dryrun_command write_marker_file

# just overwrite dotfiles
dryrun_command cp -RT --preserve=mode "${DOTFILES_DIR}" "${HOME}"
dryrun_command cp -RT --preserve=mode "${DOTFILES_PRIVATE_DIR}" "${HOME}"
