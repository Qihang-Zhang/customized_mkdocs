./fractal_shells/fractal_copy.sh

uv run mkdocs gh-deploy --force
git add .
git commit -m "auto publish"
git push

rm -rf customized_mkdocs
rm -rf tmp
rm -rf site
rm -rf docs/Blog