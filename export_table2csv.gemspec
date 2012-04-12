# -*- encoding: utf-8 -*-
require File.expand_path('../lib/export_table2csv/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["weidewang"]
  gem.email         = ["dewang.wei@gmail.com"]
  gem.description   = %q{导出数据表成csv文件}
  gem.summary       = %q{导出数据表成csv文件}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "export_table2csv"
  gem.require_paths = ["lib"]
  gem.version       = ExportTable2csv::VERSION
end
