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
    end
    contents = File.open(name).read()
    if name.end_with?('.erb') && binding
      return erb_contents(contents, binding)
    else
      return contents
    end
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