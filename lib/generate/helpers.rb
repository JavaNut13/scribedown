require_relative '../tools/resources'

module ScribeDown
  module Renderer
    def self.link_to(text, url, options={})
      extras = options.map {|k,v| "#{k}=\"#{v}\"" }.join ' '
      "<a href=\"#{url}\" #{extras}>#{text}</a>"
    end
  
    def self.stylesheet_link_tag(file_name)
      "<style>\n" + ScribeDown.read_file(file_name) + "\n</style>"
    end
  end
end