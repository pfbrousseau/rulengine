# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rulengine/version"

Gem::Specification.new do |spec|
  spec.name          = "rulengine"
  spec.version       = Rulengine::VERSION
  spec.authors       = ["Pierre-Francoys Brousseau"]
  spec.email         = ["pierre@francoys.com"]

  spec.summary       = %q{A Rule Engine that can apply rules tell when rules will conflict.}
  spec.description   = %q{Not only can this rule engine tell when rules conflict but it can be expanded in many ways, including as an automatic theorem solver}
  spec.homepage      = "http://rulengine.francoys.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "activerecord", "~> 5.0"
  # spec.add_dependency "sqlite3" # pg?
end
