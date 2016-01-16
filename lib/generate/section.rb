require_relative '../tools/resources'

module ScribeDown
  class Section
    attr_accessor :path, :options
  
    def initialize(path, options={})
      self.path = path
      self.options = options
    end
  
    def to_s
      "(#{path}: #{options})"
    end
    
    def to_html
    end
  end
end