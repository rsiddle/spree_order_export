Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_order_export'
  s.version     = '1.0.0'
  s.summary     = 'Export Orders to CSV'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.9.2'
  s.authors     = [""]
  s.author            = 'Kris Triplett'
  s.email             = 'kris@therealkris.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  #s.add_dependency('spree_core', '>= 0.80.0.beta')

end

