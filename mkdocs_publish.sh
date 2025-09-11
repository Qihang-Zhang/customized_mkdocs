#!/bin/bash

# default commit message
commit_msg="auto publish"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--message)
            commit_msg="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [ -n "$GENYML_URL" ]; then
  curl -fsSL "$GENYML_URL" | bash -s -- -p
else
  uv run bash ./customized_mkdocs/mkdocs_genyml.sh -p
fi

uv run mkdocs gh-deploy --force
git add .
git commit -m "$commit_msg"
git push

echo "--------------------------------"
echo "publish done"

uv run bash ./customized_mkdocs/maintain_config/remove_config.sh

echo "--------------------------------"
echo "remove config done"

rm -rf site
rm -rf tmp
rm -rf mkdocs.yml
rm -rf customized_mkdocs
rm -rf main.py

echo "--------------------------------"
echo "remove cached files done"
echo "--------------------------------"