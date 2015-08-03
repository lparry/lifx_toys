require "bundler/gem_tasks"
require "rake/testtask"
require "lifx_toys"

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
