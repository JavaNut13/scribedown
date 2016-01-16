require_relative '../tools/resources'
require_relative 'helpers'

module ScribeDown
  module Renderer
    
    def self.render(sections, settings)
      puts "Using settings:\n#{settings.inspect}"
      puts settings[:format]
      section_template = ScribeDown.read_file(settings[:section_container], format: :plain)
      rendered_sections = Array.new
      sections.each do |section|
        content = ScribeDown.read_file(section.path, format: settings[:format].to_sym)
        rendered_sections.push ScribeDown.erb_contents(section_template, binding)
      end
      
      content = rendered_sections.join "\n\n"
      puts settings[:base_styles].first
      head_tags = stylesheet_link_tag settings[:base_styles].first
      
      return ScribeDown.read_file(settings[:base], binding: binding)
    end
  end
end