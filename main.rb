# ファイル名
FILE_PATH = "ALL-PROG.TXT"
# プログラム開始文字
PROGRAM_START = /O[0-9]{4}/
# プログラム終了文字
PROGRAM_END = ["M30", "M99"]

# ファイルを行の配列で読み込む
lines = File.readlines(FILE_PATH)

count = 0
program_data = ""
program_name = ""
lines.each do |line|
  # プログラム開始行を探す
  match_result = line.match(PROGRAM_START)

  # プログラム開始行を見つけたら初期化
  if match_result
    program_name = match_result[0]
    program_data = "%\n"
  end

  program_data <<= line

  # プログラム終了行を見つけたらファイルに書き出す
  if PROGRAM_END.any? { |t| line.include?(t) }
    count += 1
    program_data <<= "%\n"
    File.open(program_name, "w") do |f|
      f.puts(program_data)
    end
  end
end

puts "#{count} 個のファイルを作成"
