require 'middleman-core'

# Creates new site resource
class SitemapResource
  TEMPLATES_DIR = File.expand_path '../middleman-behance/templates/source/',
                                   __FILE__

  def initialize(app, path, type, data)
    @sitemap = app.sitemap
    @source_dir = app.source_dir
    @type = type
    @data = data
    @path = path
  end

  def resource
    Middleman::Sitemap::Resource
    .new(@sitemap, "#{@path}.html", source_file)
    .tap { |res| res.add_metadata locals: self.send("#{@type}_locals") }
  end

  private

  def portfolio_locals
    {
      index_path: @path,
      projects: @data
    }
  end

  def project_locals
    {
      project: @data
    }
  end

  def source_file
    filename = "#{@type}.html.erb"
    custom_template = File.join @source_dir, filename
    return custom_template if File.exist?(custom_template)

    template = File.join TEMPLATES_DIR, filename
    raise "Template #{@type} does not exist" if !File.exist?(template)

    template
  end
end
