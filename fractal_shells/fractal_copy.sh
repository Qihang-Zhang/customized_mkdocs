TARGET_DIR="./customized_mkdocs"

# Remove existing directory if present
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

mkdir -p "$TARGET_DIR"

cp -r ./*.sh "$TARGET_DIR"
cp -r ./*.py "$TARGET_DIR"
cp -r ./*.yml "$TARGET_DIR"
cp -r ./maintain_config "$TARGET_DIR"

chmod +x "$TARGET_DIR"
source "$TARGET_DIR/mkdocs_alias.sh"