# frozen_string_literal: true

require_relative "lib/hello_sign/client/version"

Gem::Specification.new do |spec|
  spec.name          = "hello_sign-client"
  spec.version       = HelloSign::Client::VERSION
  spec.authors       = ["Nate Klaiber"]
  spec.email         = ["nklaiber@goedps.com"]

  spec.summary       = "API Client SDK to interact with the HelloSignAPI."
  spec.description   = "API Client SDK to interact with the HelloSignAPI."
  spec.homepage      = "https://github.com/ElectronicDataPaymentSystems/hello-sign-client-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ElectronicDataPaymentSystems/hello-sign-client-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/ElectronicDataPaymentSystems/hello-sign-client-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency('faraday')
  spec.add_dependency('faraday_middleware')
  spec.add_dependency('multi_json')
  spec.add_dependency('restless_router')
  spec.add_dependency('phonelib')
  spec.add_dependency('email_address')
  spec.add_dependency('dotenv')
  spec.add_dependency("timezone")
  spec.add_dependency('mimemagic')
  spec.add_dependency('mime-types')
  spec.add_dependency('ruby-units')
  spec.add_dependency('terminal-table')

  spec.add_development_dependency("rspec")
  spec.add_development_dependency("yard")

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
