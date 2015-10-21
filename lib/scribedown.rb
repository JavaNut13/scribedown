require 'kramdown'
require 'fileutils'
require 'json'

TEXT = <<-EOF
# THINGS AND STUFF

Yes, that was cool
EOF

CHAPTER_DEFAULT = {
  'chapters' => [],
  'template' => 'pages.html',
  'styles' => 'styles.css'
}

class ScribeDown
  def self.hi
    Kramdown::Document.new(TEXT, :auto_ids => true).to_html
  end
  
  def self.init
    FileUtils::mkdir_p 'chapters'
    create_file('chapters.json', CHAPTER_DEFAULT.to_json)
    create_file('styles.css')
    create_file('pages.html')
  end
  
  def self.generate
    
  end
  
  private
  def self.create_file(path, contents='')
    File.open(path, 'w') do |file|
      file.write(contents)
    end
  end
end