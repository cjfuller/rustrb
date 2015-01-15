`rake clean`
`rm target/*.o`
`rm lib/*.bundle`
`mkdir target`
puts `BASE_DIR=#{Dir.pwd} rake compile`

$:.unshift "#{Dir.pwd}/lib"

require 'rustrb'

t = Test.new
t.testmethod
