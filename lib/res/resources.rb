require 'kramdown'
require 'yaml'
require 'erb'
require 'csv'

module ScribeDown
  module Res
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
  
    def self.read_file(file_name, options={})
      binding = options[:binding]
      format = options[:format]
      only_in_fs = options[:in_fs]
    
      if File.exist? file_name
        name = file_name
      elsif File.exist?(root('resources/' + file_name)) && !only_in_fs
        name = root('resources/' + file_name)
      else
        raise "File or resource does not exist: #{file_name}"
      end
    
      contents = File.open(name).read()
      if format == :plain
        return contents
      end
      if binding && (name.end_with?('.erb') || format == :erb)
        name = name.chomp('.erb')
        contents = erb_contents(contents, binding)
      end
      if name.end_with?('.md') || name.end_with?('.markdown') || format == :markdown
        contents = markdown_contents(contents)
      end
      if name.end_with?('.csv') || format == :csv
        contents = csv_contents(contents)
      end
      return contents
    end
  
    def self.markdown_contents(content)
      Kramdown::Document.new(content, :auto_ids => true).to_html
    end
  
    def self.erb_contents(contents, bind)
      ERB.new(contents).result bind
    end
  
    def self.yaml_contents(contents)
      res = YAML.load(contents)
      symbolize(res)
      return res
    end
  
    def self.csv_contents(contents)
      all = CSV.parse(contents)
      headers = all[0]
      return if headers == nil
      data = all[1..-1]
      data_classes = headers.map {|h| h.gsub(/\W+/, '-') }
    
      read_file('csv_template.html.erb', binding: binding)
    end
  
    def self.symbolize(hash)
      hash.default_proc = proc do |h, k|
       case k
         when String then sym = k.to_sym; h[sym] if h.key?(sym)
         when Symbol then str = k.to_s; h[str] if h.key?(str)
       end
      end
    end
  
    def self.create_file(path, contents='')
      File.open(path, 'w') do |file|
        file.write(contents)
      end
    end
  end
end