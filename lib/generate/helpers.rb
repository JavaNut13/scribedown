require_relative '../tools/resources'

module ScribeDown
  def self.link_to(text, url, options={})
    extras = options.map {|k,v| "#{k}=\"#{v}\"" }.join ' '
    "<a href=\"#{url}\" #{extras}>#{text}</a>"
  end
  
  def self.stylesheet_link_tag(file_name)
    "<style>\n" + read_file(file_name) + "\n</style>"
  end
end