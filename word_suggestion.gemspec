Gem::Specification.new do |s|
    s.name        = "word_suggestion"
    s.version     = "1.0.0"
    s.summary     = "Search for possible word options using n-gram search indexes"
    s.description = "An n-gram index that returns related words to a word."
    s.authors     = ["Chukwuemeka Ajah"]
    s.email       = "talk2ajah@gmail.com"
    s.files       = Dir.glob(["lib/**/*.rb", "*.md", "bin/*"])
    s.homepage    = "https://github.com/ChukwuEmekaAjah/word_suggestion"
    s.license     = "MIT"
    s.executables = []
end