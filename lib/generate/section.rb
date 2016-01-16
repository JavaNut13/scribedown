require_relative '../tools/resources'

module ScribeDown
  class Section
    attr_accessor :path, :options, :name
  
    def initialize(path, name, options={})
      self.path = path
      self.name = name
      self.options = options
    end
  
    def to_s
      "(#{path}: #{options})"
    end
    
    def to_html
    end
  end
end