# rubocop:disable Style/FileName
require "middleman-core"
require "middleman-behance/version"

::Middleman::Extensions.register(:behance) do
  require "middleman-behance/extension"
  ::Middleman::BehanceExtension
end
