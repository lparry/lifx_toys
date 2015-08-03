require "bundler/gem_tasks"
require "rake/testtask"
require "lifx_toys"
require "lifx_toys/clouds"
require "lifx_toys/colors"
require "lifx_toys/sunrise"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test


desc 'Cloud lighting simulation on all_lights'
task :clouds do
  LifxToys::Clouds.new.run
end

desc 'Cycle random Hue, Saturation and brightness on all lights'
task :colors do
  LifxToys::Colors.new.run
end

desc '30 minute sunrise, 0-15M brightness:0-100% kelvin:2500, 15-30M kelvin:2500-9000'
task :sunrise do
  LifxToys::Sunrise.new.run
end

task :info do
  puts LifxToys::LifxNetworkObject.new('all').get_info
end
