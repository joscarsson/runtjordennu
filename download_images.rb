require 'open-uri'
require 'uri'

def download_image(dir_name, url, src_in_html: false)
  uri = URI.parse(url)
  filename = URI.unescape(File.basename(uri.path))
  return if File.exists?("images/#{dir_name}/#{filename}")
  Dir.mkdir "images/#{dir_name}" unless File.exists?("images/#{dir_name}")
  print "Downloading #{filename}: "
  if src_in_html
    # When Google puts the actual image in a HTML page...
    content =  open(url).read
    actual_url = content.scan(/<img.*?src="(.*?)"/).map { |match| match[0] }[0]
    open("images/#{dir_name}/#{filename}", "wb") do |file|
      file << open(actual_url).read
    end
  else
    open("images/#{dir_name}/#{filename}", "wb") do |file|
      file << open(url).read
    end
  end

  puts "done"
end

def process_post(post)
  post_name = File.basename(post, '.html')
  puts "Processing #{post_name}"

  if post_name != "2011-03-01-en-avslutande-reflektion-om-indien-och"
    return
  end

  content = File.read(post)
  img_urls = content.scan(/<img.*?src="(.*?)"/).map { |match| match[0] }
  a_urls = content.scan(/<a.*?href="(.*?)"/).map { |match| match[0] }
  image_urls = a_urls.select { |url| url.end_with?('.jpg') }
  other_urls = a_urls - image_urls

  puts "Found #{img_urls.length} <img> urls:", img_urls
  puts "Found #{image_urls.length} <a> urls pointing to images:", image_urls
  puts "Found #{other_urls.length} <a> urls pointing to other things:", other_urls

  for url in img_urls
    download_image(post_name, url)
  end
  for url in image_urls
    download_image(post_name, url, src_in_html: true)
  end

  text = File.read(post)
  for url in img_urls + image_urls
    uri = URI.parse(url)
    filename = File.basename(uri.path)
    text = text.gsub(url, "{{ '/images/#{post_name}/#{filename}' | prepend: site.baseurl }}")
  end
  File.open(post, "w") { |file| file.puts text }

  puts
end

posts = Dir['_posts/*.html']

for post in posts
  process_post(post)
end

