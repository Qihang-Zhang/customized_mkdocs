publish=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--publish)
      publish=true
      shift
      ;;
    *)
      echo "Usage: $0 [-p|--publish]"
      exit 1
      ;;
  esac
done

# Load environment variables from .env if present
if [ -f .env ]; then
  set -a
  . ./.env
  set +a
fi

# Determine blog directory from env, default to "Blog"
blog_dir="${BLOG_DIR:-Blog}"

mkdir -p tmp

python3 ./customized_mkdocs/yml_add_ifpublish.py \
    --will-publish ${publish} \
    -i mkdocs_config.yml \
    -o tmp/mkdocs_config.yml

python3 ./customized_mkdocs/yml_merge.py \
    -b customized_mkdocs/base_mkdocs.yml \
    -c tmp/mkdocs_config.yml \
    -o tmp/mkdocs.yml

python3 ./customized_mkdocs/yml_add_nav.py \
    --blog_dir "${blog_dir}" \
    -i tmp/mkdocs.yml \
    -o mkdocs.yml

# rm -rf tmp