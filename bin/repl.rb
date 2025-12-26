require 'readline'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'r_lisp'

begin
  interpreter = Usecase::Interpreter.new

  if ARGV.any?
    filename = ARGV[0]
    unless File.exist?(filename)
      puts "Error: File not found: #{filename}"
      exit 1
    end

    begin
      code = File.read(filename)
      interpreter.execute(code)
    rescue StandardError => e
      puts "Error during execution: #{e.message}"
      exit 1
    end
  else
    puts "\e[32;1mWelcome to R-Lisp REPL\e[0m"
    puts "Type 'exit' to exit"

    loop do
      line = Readline.readline("r-lisp> ", true)
      break if line.nil? || line == "exit"
      next if line.strip.empty?

      begin
        result = interpreter.execute(line)
        puts "\e[36m=> \e[0m#{result.inspect}"
      rescue StandardError => e
        puts "\e[36m=> \e[0m#{e.message}"
      end
    end
    puts "Bye!"
  end
rescue Interrupt
  puts "\nBye!"
end
