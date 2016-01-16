require 'kramdown'

module ScribeDown
  def self.root(file=nil)
    path = File.expand_path '../..', File.dirname(__FILE__)
    if file
      path += '/' + file
    end
    return path
  end
  
  def self.read_res(res_name)
    File.open(self.root + '/resources/' + res_name).read()
  end
  
  def self.read_file(file_name, binding=nil)
    if File.exist? file_name
      name = file_name
    elsif File.exist? root('resources/' + file_name)
      name = root('resources/' + file_name)
    else
      raise "File or resource does not exist: #{file_name}"
    end
    
    contents = File.open(name).read()
    if name.end_with?('.erb') && binding
      name = name.chomp('.erb')
      contents = erb_contents(contents, binding)
    end
    if name.end_with?('.md') || name.end_with?('.markdown')
      contents = markdown_contents(contents)
    end
    return contents
  end
  
  def self.markdown_contents(content)
    Kramdown::Document.new(content, :auto_ids => true).to_html
  end
  
  def self.erb_contents(contents, bind)
    ERB.new(contents).result bind
  end
  
  def self.create_file(path, contents='')
    File.open(path, 'w') do |file|
      file.write(contents)
    end
  end
end