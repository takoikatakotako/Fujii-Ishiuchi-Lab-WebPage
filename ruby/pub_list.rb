require 'json'

jsonFilePath = 'list.json'
# 論文の.jsonの読み込み
jsonData = open(jsonFilePath) do |io|
  JSON.load(io)
end

pubCount = 0
#業績数を数える
jsonData.each{|contents|
  pubCount += contents["contents"].length
}

# 出力
File.open("pub_list_body.html", "w") do |f|
  jsonData.each{|contents|
    f.puts '<h2 class="sub_title">' + contents["year"] + '年</h2>'
    f.puts '<div class="sub_contents">'

    contents["contents"].each{ |list|
      f.puts '<div class="pub">[' + pubCount.to_s + ']'
      f.puts '<div class="pub_title"><strong>&ldquo;' + list["title"] + '&rdquo;</strong></div>'
      f.puts '<div class="author">' + list["author"] + '</div>'
      f.puts '<div class="pub_desc"><i>' + list["journal"] + '</i> '
      f.puts '<strong>' + list["issue"] + '</strong>, '
      f.puts list["page"] + ' (' + list["year"] + ').'
      if list["url"] != "" then
        f.puts '<a href="' + list["url"] + '" target="_blank">Link</a>'
      end
      if list["message"] != "" then
        f.puts list["message"]
      end
      f.puts '</div>'
      f.puts '<hr>'
      f.puts '</div>'
      pubCount -= 1
    }
    f.puts '</div>'
    # f.puts '<div class="right" style="margin-bottom:10px;"><a href="#">このページの先頭へ</a></div>'
  }
end
