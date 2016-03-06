require 'fileutils'
require_relative 'res/resources'
require_relative 'generate/helpers'
require_relative 'generate/renderer'
require_relative 'section'

module ScribeDown
  def self.generate(options={})
    begin
      settings = Res.yaml_contents(Res.read_file('scribe.yml', in_fs: true))
    rescue Exception => e
      abort "FATAL: Not a scribedown directory. Unable to read scribe.yml.\n" + e.message
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
    # Extra styles don't override the defaults
    defaults[:styles] += defaults[:extra_styles] || []
    
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

    output = defaults[:output]
    type = output['default']
    html = Renderer.to_html sections, defaults
    if type == 'all' || type == 'html'
      Res.create_file(defaults[:output]['html'], html)
    end
    if type == 'all' || type == 'pdf'
      pdf = Renderer.to_pdf html
      Res.create_file(defaults[:output]['pdf'], pdf)
    end
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
    FileUtils.cp_r(Res.root('resources/init/.'), '.')
    # Res.create_file('scribe.yml', Res.read_res('scribe.yml'))
    # Res.create_file('sections/default_section.md', Res.read_res('default_section.md'))
  end
  
  def self.new_section(name)
    begin
      settings = Res.yaml_contents(Res.read_file('scribe.yml', in_fs: true))
    rescue
      abort 'FATAL: Not a scribedown directory. Unable to read scribe.yml.'
    end
    new_name = name.split('.').first
    if new_name == name
      name = name + '.md'
    end
    settings[:sections].push new_name
    Res.create_file('sections/' + name, '# ' + new_name)
    Res.create_file('scribe.yml', settings.to_yaml)
  end
end