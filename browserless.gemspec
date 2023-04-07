# frozen_string_literal: true

require_relative "lib/browserless/version"

Gem::Specification.new do |spec|
  spec.name = "browserless"
  spec.version = Browserless::VERSION
  spec.authors = ["Thomas Van Holder"]
  spec.email = ["thomasvanholder@hey.com"]

  spec.summary = "A Ruby wrapper for the Browserless PDF API with support for modern CSS such as TailwindCSS"
  spec.description = "This gem provides a simple interface for interacting with the Browserless PDF API. It handles all the HTTP requests and responses, and provides methods for configuring the API endpoint, setting authentication credentials, and specifying options for the PDF generation process. This gem is ideal for developers who want to generate PDFs without managing any infrastructure."
  spec.homepage = "https://github.com/thomasvanholder/browserless"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = "https://github.com/thomasvanholder/browserless"
  spec.metadata["source_code_uri"] = "https://github.com/thomasvanholder/browserless"
  spec.metadata["changelog_uri"] = "https://github.com/thomasvanholder/browserless"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject do |f|
  #     (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
  #   end
  # end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "debug", "~> 1.7.2"
  spec.add_development_dependency "standard", "~> 1.26.0"

  # spec.add_dependency "httpary", "~> 0.18"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
