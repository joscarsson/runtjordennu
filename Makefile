.PHONY = deploy

serve:
	bundle exec jekyll serve

deploy:
	bundle exec jekyll build
	git branch -D gh-pages
	git checkout --orphan gh-pages
	git reset
	git clean -df
	mv _site/* .
	rmdir _site
	rm -rf .sass-cache
	git add . 
	git commit -m "Deploy"
	git push -f origin gh-pages
	git checkout master

