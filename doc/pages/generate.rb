require 'rubygems'
require 'wlang'

WLang::file_extension_map('.redcloth', 'wlang/xhtml')
here = File.dirname(__FILE__)
main = File.join(here, 'layouts', 'main.wtpl')
Dir["#{here}/posts/*.redcloth"].each do |file|
  basename = File.basename(file, '.redcloth')
  output = File.join(here, 'output', "#{basename}.html")
  
  File.open(output, 'w') do |io|
    io << WLang::file_instantiate(main, :post => basename)
  end
end