require "middleman-core"

# Creates new site resource
class SitemapResource
  TEMPLATES_DIR = File.expand_path "../middleman-behance/templates/source/",
    __FILE__

  def initialize(app, path, type, data, options)
    @type = type
    @data = data
    @options = options
    @path = path
    @sitemap = app.sitemap
    @source_dir = app.source_dir
  end

  def resource
    Middleman::Sitemap::Resource
      .new(@sitemap, "#{@path}.html", source_file)
      .tap { |res| res.add_metadata locals: send("#{@type}_locals"), ignore: true }
  end

  private

  def portfolio_locals
    {
      index_path: @path,
      projects: @data,
      tags: @options.tags_whitelist
    }
  end

  def project_locals
    {
      project: @data
    }
  end

  def source_file
    filename = @options.send "#{@type}_template"
    custom_template = File.join @source_dir, filename
    return custom_template if File.exist?(custom_template)

    template = File.join TEMPLATES_DIR, filename
    raise "Template #{@type} does not exist" unless File.exist?(template)

    template
  end
end
