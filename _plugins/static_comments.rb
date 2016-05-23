
module StaticComments
  class Generator < Jekyll::Generator
    def generate(site)
      comments = site.collections['comments'].docs
      for post in site.posts.docs
        post.data['comments'] = comments.select { |c| post.data['blogger_id'] == c.data['blogger_post_id'] }
      end
    end
  end
end
