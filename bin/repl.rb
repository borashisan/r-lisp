# bin/rlisp.rb
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'r_lisp'
require 'readline'

interpreter = Usecase::Interpreter.new

# 引数がある場合はファイル実行モード
if ARGV.any?
  filename = ARGV[0]
  unless File.exist?(filename)
    puts "Error: File not found: #{filename}"
    exit 1
  end

  begin
    # ファイル全体を読み込んで実行
    code = File.read(filename)
    # 複数のS式（(define ...) (fact 5)など）が並んでいる場合に対応するため
    # 簡易的に1つずつパースして評価するループを回すのが理想ですが、
    # 今のParserは1つのS式を想定しているので、まずは一括評価を試みます。
    result = interpreter.execute(code)
    p result unless result.nil?
  rescue StandardError => e
    puts "Error during execution: #{e.message}"
    exit 1
  end

# 引数がない場合はREPLモード
else
  puts "R-Lisp REPL (Type 'exit' to quit)"
  loop do
    line = Readline.readline("r-lisp> ", true)
    break if line.nil? || line == "exit"
    next if line.strip.empty?
    begin
      p interpreter.execute(line)
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end
