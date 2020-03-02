lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "debian_version_puppet/gem_version"

Gem::Specification.new do |spec|
  spec.name          = "debian_version_puppet"
  spec.version       = DebianVersionPuppet::VERSION
  spec.authors       = ["Ciprian Badescu"]
  spec.email         = ["ciprian.badescu@puppet.com"]

  spec.summary       = %q{Version class to handle debian packages versioning}
  spec.homepage      = "https://github.com/ciprianbadescu/debian_version_puppet"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ciprianbadescu/debian_version_puppet"
  spec.metadata["changelog_uri"] = "https://github.com/ciprianbadescu/debian_version_puppet"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.2"
end
