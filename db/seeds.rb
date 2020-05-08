news_child_array = ['カテゴリ','ジャンル','性別','その他']

news_grandchild_array = [['ファッション','ビューティ','グルメ','アート','映画','音楽','ライフスタイル・カルチャー','その他'],['アイテム','イベント','トピック','ショップ','コレクション','特集','インタビュー','その他'],['すべて','ウィメンズ','メンズ','ウィメンズ&メンズ'],['すべて']]

parent = Category.create(name: 'ニュース')
news_child_array.each.each_with_index do |child, i|
 child = parent.children.create(name: child)
 news_grandchild_array[i].each do |grandchild|
   child.children.create(name: grandchild)
 end
end