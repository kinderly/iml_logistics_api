require File.expand_path("../lib/iml_logistics_api/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "iml_logistics_api"
  s.version = ::ImlLogisticsApi::VERSION
  s.authors = ["Kinderly LTD"]
  s.email = ["nuinuhin@gmail.com"]
  s.homepage = "https://github.com/kinderly/iml_logistics_api"

  s.summary = %q{A wrapper for IML Logistics API}
  s.description = %q{This gem provides a Ruby wrapper over IML Logistics API.}
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('nokogiri', '~>1.6')
end
