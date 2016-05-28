require "jekyll-import";

JekyllImport::Importers::Blogger.run({
  "source"                => "blog-05-22-2016.xml",
  "no-blogger-info"       => true,
  "replace-internal-link" => false,
  "comments"              => true,
})
