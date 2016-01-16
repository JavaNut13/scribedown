require_relative 'res/resources'
require_relative 'generate/helpers'
require_relative 'generate/renderer'
require_relative 'section'

module ScribeDown
  def self.generate
    begin
      settings = Res.yaml_contents(Res.read_file('scribe.yml', in_fs: true))
    rescue
      abort 'FATAL: Not a scribedown directory. Unable to read scribe.yml.'
    end
    sections_yaml = settings[:sections]
    sections = Array.new
    
    lookup = lookup_files()
    failed = Array.new
    
    glob_default = Res.yaml_contents(Res.read_file('default.yml'))[:default]
    defaults = settings[:default] || {}
    
    if glob_default
      defaults.merge! glob_default
    end
    Res.symbolize(defaults)
    
    sections_yaml.each do |section|
      name = section
      ops = defaults.clone
      if section.is_a? Hash
        name = section.select {|k, v| v == nil }.first.first
        ops = ops.merge(section)
        ops.delete(name)
      end
      path = lookup[name.downcase]
      if path
        ops[:path] = path
        ops[:name] = name
        sections.push Section.new(ops)
      else
        failed.push section
      end
    end

    res = Renderer.to_html sections, defaults
    Res.create_file(defaults[:output], res)
  end
  
  def self.lookup_files
    file_lookup = Hash.new
    Dir['**/*'].each do |file|
      name = File.basename(file).split('.').first.downcase
      file_lookup[name] = file
    end
    file_lookup
  end
  
  def self.init
    if File.exist? 'scribe.yml'
      abort 'ScribeDown already initialised: scribe.yml exists'
    end
    FileUtils::mkdir_p 'sections'
    create_file('scribe.yml', read_res('scribe.yml'))
  end
end