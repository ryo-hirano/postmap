#親カテゴリ
all_category = Category.create(name: "全カテゴリ")
all_genre = Category.create(name: "全ジャンル")
all_type = Category.create(name: "全タイプ")

#子カテゴリー
all_category_fashion = all_category.children.create(name: "ファッション")
all_category_beauty = all_category.children.create(name: "ビューティ")
all_category_food = all_category.children.create(name: "グルメ")
all_category_art = all_category.children.create(name: "アート")
all_category_movie = all_category.children.create(name: "映画")
all_category_music = all_category.children.create(name: "音楽")
all_category_lifestyle = all_category.children.create(name: "ライフスタイル・カルチャー")

all_genre_item = all_genre.children.create(name: "アイテム")
all_genre_event = all_genre.children.create(name: "イベント")
all_genre_topic = all_genre.children.create(name: "トピック")
all_genre_shop = all_genre.children.create(name: "ショップ")
all_genre_collection = all_genre.children.create(name: "コレクション")
all_genre_feature = all_genre.children.create(name: "特集")
all_genre_interview = all_genre.children.create(name: "インタビュー")

all_type_womens = all_type.children.create(name: "ウィメンズ")
all_type_mens = all_type.children.create(name: "メンズ")
all_type_womensmens = all_type.children.create(name: "ウィメンズ&メンズ")