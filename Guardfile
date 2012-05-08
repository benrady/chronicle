# A sample Guardfile
# More info at https://github.com/guard/guard#readme

interactor :simple

guard 'rspec', :cli => "--color" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/chronicle/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/chronicle.rb})     { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end
