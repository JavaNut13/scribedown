module ScribeDown
  class Section
    attr_accessor :options
  
    def initialize(options={})
      self.options = options
    end
  
    def to_s
      "(#{path}: #{options})"
    end
    
    def method_missing(method)
      if options.has_key?(method.to_sym)
        return self.options[method.to_sym]
      elsif options.has_key?(method.to_s)
        return self.options[method.to_s]
      else
        super.method_missing(method)
      end
    end
  end
end