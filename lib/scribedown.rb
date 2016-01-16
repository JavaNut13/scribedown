require_relative 'tools/init'
require_relative 'tools/resources'
require_relative 'generate/helpers'
require_relative 'generate/section'
require_relative 'generate/renderer'

module ScribeDown
  def self.generate
    begin
      settings = yaml_contents(read_file('scribe.yml', in_fs: true))
    rescue
      abort 'FATAL: Not a scribedown directory. Unable to read scribe.yml.'
    end
    sections_yaml = settings[:sections]
    sections = Array.new
    
    lookup = lookup_files()
    failed = Array.new
    
    glob_default = yaml_contents(read_file('default.yml'))[:default]
    defaults = settings[:default] || {}
    
    if glob_default
      defaults.merge! glob_default
    end
    symbolize(defaults)
    
    sections_yaml.each do |section|
      name = section
      ops = defaults
      if section.is_a? Hash
        name = section.select {|k, v| v == nil }.first.first
        ops = ops.merge(section)
        ops.delete(name)
      end
      path = lookup[name]
      if path
        sections.push Section.new(path, name, ops)
      else
        failed.push section
      end
    end

    res = Renderer.render sections, defaults
    create_file(defaults[:output], res)
  end
  
  def self.lookup_files
    file_lookup = Hash.new
    Dir['**/*'].each do |file|
      name = File.basename(file).split('.').first
      file_lookup[name] = file
    end
    file_lookup
  end
end