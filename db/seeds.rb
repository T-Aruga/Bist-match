# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# ジャンル情報

arrjenres = ["和食", "寿司", "カフェ", "ラーメン・そば・うどん", "焼き鳥・串焼き", "焼肉", "スイーツ",
            "ステーキ・ハンバーグ", "洋食", "パスタ・ピザ", "ハンバーガー", "フレンチ", "イタリアン",
             "スペイン料理", "中華料理", "韓国料理", "エスニック料理", "カレー", "鍋料理", "居酒屋・ダイニングバー"]

for i in arrjenres do

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

User.create!(
    fullname: "Adam Smith",
    email: 'sample@gmail.com',
    password: 'aaaaaa',
    phone_number: '09012349876',
    description: 'アダムです！皆さん、一緒に美味しいもの食べに行きましょう!',
    age: 30,
    sex: 0,
    favorite_store: '叙々苑',
    job: 'デザイナー',
    jenre_id: 6,
    active: 1
)

10.times do |n|
	User.create!(
		fullname: Faker::Name.name,
    email: Faker::Internet.unique.free_email,
    password: 'aaaaaa',
    phone_number: '09012349876',
    description: Faker::Lorem.sentence(word_count: 20),
    age: rand(18..50),
    sex: rand(0..1),
    favorite_store: Faker::Company.name,
    job: Faker::Job.title,
    jenre_id: rand(1..20),
    active: 1
	)
end



# 地域情報

arrAreas = ["新宿", "渋谷", "池袋", "恵比寿", "東京・日本橋", "六本木", "銀座", "新梅・汐留", "上野・浅草", "原宿・青山・表参道", "赤坂・永田町", "秋葉原・神田", "目黒・五反田"]

for i in arrAreas do

  Area.create!(
      name: i
  )
end
