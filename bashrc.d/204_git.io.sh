# git.io - url shortener

function gitio() {
GITIO_URL=https://git.io

url="$1"
code="$2"

  if [ -z "$url" ] ; then
      echo Usage:
      echo "  gitio URL [CODE]"
      return
  fi

  if [ -n "$code" ] && grep -E '[^a-zA-Z0-9_-]' <<<"$code" >/dev/null 2>&1 ; then
      echo "code is only alpha-numeric and _ and -."
      return
  fi

  echo "url = $url"
  if [ -n "$code" ] ; then
      echo "code = $code"
  fi

  if [ -z "$code" ] ; then
      curl -i $GITIO_URL -F "url=$url"
  else
      curl -i $GITIO_URL -F "url=$url" -F "code=$code"
  fi

  echo ""
}
