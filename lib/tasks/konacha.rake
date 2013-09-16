namespace :konacha do
  task :message do
    puts "Running Konacha tests...\n"
  end
end

task 'konacha:run' => 'konacha:message'

task :default => 'konacha:run'