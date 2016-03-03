require_relative '../res/resources'

module ScribeDown
  module Renderer
    def self.link_to(text, url, options={})
      extras = options.map {|k,v| "#{k}=\"#{v}\"" }.join ' '
      "<a href=\"#{url}\" #{extras}>#{text}</a>"
    end
  
    def self.stylesheet_tag(file_name)
      "<style>\n" + Res.read_file(file_name) + "\n</style>"
    end
    
    def self.image_tag(url, options={})
      extras = options.map {|k,v| "#{k}=\"#{v}\"" }.join ' '
      "<img src=\"#{url}\" #{extras}/>"
    end
  end
end