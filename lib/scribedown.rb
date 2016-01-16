require 'kramdown'
require 'fileutils'
require 'yaml'
require 'erb'

require_relative 'tools/init'
require_relative 'tools/resources'

TEXT = <<-EOF
# THINGS AND STUFF

Yes, that was cool
EOF

module ScribeDown
  # def self.hi
  #   Kramdown::Document.new(TEXT, :auto_ids => true).to_html
  # end
  
  def self.generate
    title = 'poop'
    render_content = "HEllo world"
    puts read_file('index.html.erb', binding)
  end
end