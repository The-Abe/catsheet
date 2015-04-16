Gem::Specification.new do |s|
  s.name        = 'catsheet'
  s.version     = '1.1.2'
  s.date        = '2015-04-16'
  s.summary     = "A cat-like tool for spreadsheets."
  s.description = "A simple gem that prints spreadsheets like cat prints text files."
  s.authors     = ["Abe van der Wielen"]
  s.email       = 'abevanderwielen@gmail.com'
  s.files       = ["bin/catsheet","lib/catsheet.rb"]
  s.homepage    = 'https://github.com/the-abe/catsheet'
  s.add_dependency "spreadsheet"
  s.executables = ["catsheet"]
end
