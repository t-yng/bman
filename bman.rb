#!/usr/bin/ruby
require 'json'

path = File.expand_path(__FILE__)
if File.ftype(path) == 'link' then
  # 実行ファイルがシンボリックの場合はリンク先にあるマニュアルを参照
  link        = File.readlink(path)
  MANUAL_JSON = File.expand_path("#{File.dirname(link)}/manual.json")
else
  MANUAL_JSON = File.expand_path("#{File.dirname(__FILE__)}/manual.json")
end

def loadJSON(file)
  open(file) do |f|
    return JSON.load(f)
  end
end

def updateJSON(json, file)
  open(file,'w') do |f|
    f.write(json)
  end
end

def printNoManualError()
  puts "No manual entry for \"#{command}\""
  puts "Please add manual by \"bman --config\""
end

def openManual(command)
  manual = loadJSON(MANUAL_JSON)['manual']
  item = manual.find{|obj| obj['command'] == command}

  # コマンドが存在しない場合はエラーメッセージを表示
  if item == nil then
    printNoManualError()
    return
  end

  url    = item['url']
  `open #{url}`
end

def updateManual(command, url)
  # マニュアルの情報を標準入力から取得
  puts 'add or update manual'
  print 'command: '
  command = STDIN.gets.chop
  print "url of manual: "
  url     = STDIN.gets.chop

  # マニュアルを更新（すでにコマンドが存在する場合は上書き）
  hash = loadJSON(MANUAL_JSON)
  hash['manual'].push({'command' => command, 'url' => url})
  updateJSON(hash.to_json, MANUAL_JSON)
end

def main()
  arg = ARGV[0]

  if arg == '--config' then
    updateManual(command, url)
  else
    openManual(arg)
  end
end

main()
