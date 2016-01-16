require 'fileutils'
require 'yaml'
require 'erb'

require_relative 'tools/init'
require_relative 'tools/resources'
require_relative 'helpers/helpers'

module ScribeDown
  def self.generate
    title = 'poop'
    content = read_file('sections/test.md')
    head_tags = stylesheet_link_tag 'style.css'
    result = read_file('index.html.erb', binding)
    create_file('index.html', result)
  end
end