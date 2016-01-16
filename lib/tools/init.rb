require_relative 'resources'

module ScribeDown
  def self.init()
    FileUtils::mkdir_p 'sections'
    create_file('sections.yml', read_res('sections.yaml'))
    # create_file('styles.css')
    # create_file('pages.html')
  end
end