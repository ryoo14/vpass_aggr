lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vpass_aggr/version"

Gem::Specification.new do |spec|
  spec.name          = "vpass_aggr"
  spec.version       = VpassAggr::VERSION
  spec.authors       = ["ryoo14"]
  spec.email         = ["anana12185@gmail.com"]

  spec.summary       = %q{vpassからエクスポートした支払い明細をいい感じに集計する}
  spec.description   = %q{vpassからエクスポートした支払い明細をいい感じに集計する}
  spec.homepage      = "https://github.com/ryoo14/vpass_aggr.git"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ryoo14/vpass_aggr.git"
  spec.metadata["changelog_uri"] = "https://github.com/ryoo14/vpass_aggr/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "thor"
end
