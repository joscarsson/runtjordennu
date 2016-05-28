# runtjorden.nu

This is a static copy/archive from a blog I used on a trip around the world year 2011. At the time it was present on http://runtjorden.nu, but was actually hosted on Blogspot/Blogger (http://runtjordennu.blogspot.com). Blog posts were written in Windows Live Writer (yes, you read that right) and all photos were stored on authors' Google accounts (Picasa Web Albums).

As I'd like the blog to be available in the future, not being dependent on the dynamic rendering through Blogger and the Google photo storage, I decided to create a snapshot version of the blog using only static files and local images. Hence this repo - it's now hosted on GitHub Pages with no external dependencies. The site itself is rendered once using [Jekyll](https://jekyllrb.com/) from `master` and committed to the `gh-pages` branch. The actual blog can be seen at http://joscarsson.github.io/runtjordennu.

## Import process

I'll describe the steps I took to create this site below, mostly for my own reference:

 1. Log in to Blogger, go to **Settings** > **Other**, click **Back up Content**.
 2. Create a new repo with this [Gemfile](Gemfile).
 3. Run `bundle install`.
 4. Generate a new Jekyll site, something like `bundle exec jekyll new my-site`.
 5. Modify `_config.yml` as needed.
 6. Use the script `import.rb` to import the blog posts from the archive downloaded in (1).
 7. The plugins in this repo provided two things, use as appropriate:
    1. `static_comments.rb`: Static comments exposed per post.
    2. `i18n_filter.rb`: Localization for dates according to `lang` set in `_config.yml`.
 8. Modify layout/CSS etc to liking (`_layouts` and `_sass`).
 9. Run the script `download_images.rb` to pull down all external images and save them in the repo `images` folder (one directory per blog post). This script also changes the `img src` URLs in the post to point to the local versions instead.
 10. Build the branch locally using `bundle exec jekyll build`. The actual site will be available in `_site`.
 10. `git checkout --orphan gh-pages` to create an empty branch, move the generated content `_site/*` to the root of this branch, commit and push.
 11. 🍻! The site is now publicly accessible through http://&lt;username&gt;.github.io/&lt;reponame&gt;!


