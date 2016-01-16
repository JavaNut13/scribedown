require_relative '../res/resources'
require_relative 'helpers'

module ScribeDown
  module Renderer
    @@settings = nil
    @@sections = nil
    @@templates = nil
    
    def self.head_tags
      rendered = Array.new
      @@settings[:styles].each do |style|
        rendered.push(stylesheet_tag style)
      end
      rendered.join "\n\n"
    end
    
    def self.content
      rendered_sections = Array.new
      @@sections.each do |section|
        rendered_sections.push render_section(section)
      end
      rendered_sections.join "\n\n"
    end
    
    def self.render_section(section)
      if @@templates.has_key? section.container
        template = @@templates[section.container]
      else
        template = Res.read_file(section.container, format: :plain)
        @@templates[section.container] = template
      end
      
      content = Res.read_file(section.path, format: section.format.to_sym, binding: binding)
      Res.erb_contents(template, binding)
    end
    
    def self.add(file_name, options={})
      options[:binding] = binding
      Res.read_file(file_name, options)
    end
    
    def self.to_html(sections, settings)
      @@settings = settings
      @@sections = sections
      @@templates = Hash.new
      
      return Res.read_file(settings[:base], binding: binding)
    end
  end
end