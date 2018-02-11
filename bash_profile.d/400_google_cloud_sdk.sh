# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/local/src/google-cloud-sdk/path.bash.inc" ]; then
  source "${HOME}/local/src/google-cloud-sdk/path.bash.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/local/src/google-cloud-sdk/completion.bash.inc" ]; then
  source "${HOME}/local/src/google-cloud-sdk/completion.bash.inc"
fi
