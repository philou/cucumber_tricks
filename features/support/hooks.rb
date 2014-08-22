require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

Before do
  FileUtils.rm_r ('tmp/features') if File.exist?('tmp/features')
end
