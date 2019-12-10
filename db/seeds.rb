# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# ジャンル情報

arrjobs = ["和食", "寿司", "カフェ", "ラーメン・そば・うどん", "焼き鳥・串焼き", "焼肉", "スイーツ",
            "ステーキ・ハンバーグ", "洋食", "パスタ・ピザ", "ハンバーガー", "フレンチ", "イタリアン",
             "スペイン料理", "中華料理", "韓国料理", "エスニック料理", "カレー", "鍋料理", "居酒屋・ダイニングバー"]

for i in arrjobs do

  Jenre.create!(
      name: i
  )
end

# テストユーザー

User.create!(
    fullname: "Jo Inoue",
    email: 'test@gmail.com',
    password: 'aaaaaa',
    phone_number: '09012349876',
    description: 'ジョーです！皆さん、一緒に美味しいもの食べに行きましょう!',
    age: 24,
    sex: 0,
    favorite_store: 'ジョエル・ロブション',
    job: '会社経営者',
    jenre_id: 2,
    active: 1
)
