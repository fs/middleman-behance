require 'middleman-core'

# Creates new site resource
class SitemapResource
  TEMPLATES_DIR = File.expand_path('../templates/source/', __FILE__)

  def initialize(sitemap, path, type, data)
    @sitemap = sitemap
    @type = type
    @data = data
    @path = path

    build
  end

  private

  def build
    Middleman::Sitemap::Resource
    .new(@sitemap, "#{@path}.html", source_file)
    .tap { |res| res.add_metadata locals: self.send("#{@type}_locals") }
  end

  def portfolio_locals
    {
      index_path: path,
      projects: @data
    }
  end

  def project_locals
    {
      project: @data
    }
  end

  def source_file
    p path
    binding.pry
    path = File.join TEMPLATES_DIR, "#{@type}.html.erb"
    raise "Template #{@type} does not exist" if !File.exist?(path)

    path
  end
end
