require_relative 'resources'

module ScribeDown
  def self.init
    if File.exist? 'scribe.yml'
      raise 'ScribeDown already initialised: scribe.yml exists'
    end
    FileUtils::mkdir_p 'sections'
    create_file('scribe.yml', read_res('scribe.yml'))
    # create_file('styles.css')
    # create_file('pages.html')
  end
end