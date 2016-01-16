require_relative '../tools/resources'

module ScribeDown
  module Renderer
    def self.render(sections, settings)
      puts "Using settings:\n#{settings.inspect}"
      puts settings[:format]
      return 'butts'
    end
  end
end