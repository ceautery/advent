desc "Make a new folder and copy template files into it. Example: rake 'make_day[2023,day01]'"
task :make_day, [:year, :day] do |_, args|
  year = args[:year]
  day = args[:day]

  params = { day: day, klass: day.capitalize }
  dir = "#{year}/#{day}"

  if Dir.exists?(dir)
    puts "Directory already exists, aborting"
    next
  end

  Dir.mkdir(dir)

  code = File.read('template/code_template.txt')
  io = File.open("#{dir}/#{day}.rb", 'w')
  io.write(code % params)
  io.close

  specs = File.read('template/spec_template.txt')
  io = File.open("#{dir}/#{day}_spec.rb", 'w')
  io.write(specs % params)
  io.close
end
