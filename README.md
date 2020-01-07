# BistMatch

 一緒に食事をしたい人同士をマッチングして、普段、中々出会えない人同士の出会いや普段行けないようなお店や
レストランに行ける機会を創出する食事プランのマッチングサイトです。

 ホストはシェアしたいお店、場所での食事の体験を食事プランとして公開し、ユーザーに利用機会を提供します。
 ユーザーは目的に応じて、参加したい食事プランに参加希望をして、ホストから承認をうけることで、その食事プランに参加をする事ができます。

## リンク

https://bistmatch.com

Testuserログインボタンからそのままログイン可能です。

## 使用技術

* Ruby 2.5.7, Rails 5.2.3
* Nginx, Puma
* AWS(EC2, RDS, S3, VPC, Route53, ALB, ACM)
* Vagrant, Virtual Box
* Rspec, SASS, Bootstrap, JQuery

## 機能一覧

* ユーザー登録、ログイン機能(devise)
* ソーシャル認証、ログイン機能(Facebook, Google)
* プラン投稿機能(画像アップロードにはRefileを使用(複数画像同時アップロード対応))
* プラン投稿一覧、投稿詳細機能表示機能
* 投稿管理機能
* プラン参加申請、承認機能
* ページネーション機能(Kaminari)
* いいね機能（Ajax）
* 検索機能(Ransack+GoogleMap API+Geocording API)
* クレジットカード決済機能（Stripe API）
* レストラン・飲食店情報検索・取得機能（ぐるなびレストラン検索API）
* レビュー機能
* 管理者機能
* 通知機能
* 収益確認機能(Chartkick)
* Line風UIのチャット・DM機能（ActionCable）

## 使用画面サンプル
<br/>

### トップ画面
[![Image from Gyazo](https://i.gyazo.com/f6671728a38581ce8d99291cb668d891.jpg)](https://gyazo.com/f6671728a38581ce8d99291cb668d891)

### 食事プラン詳細画面(一部)
[![Image from Gyazo](https://i.gyazo.com/dbbc2d9cf06ae363e4455c5b435c41ae.jpg)](https://gyazo.com/dbbc2d9cf06ae363e4455c5b435c41ae)

### チャット機能
[![Image from Gyazo](https://i.gyazo.com/dbede48639961c5ae5d7546c9f27921c.png)](https://gyazo.com/dbede48639961c5ae5d7546c9f27921c)

### 検索機能
[![Image from Gyazo](https://i.gyazo.com/d2ed66b236f51fe4aacf47bb6901419f.jpg)](https://gyazo.com/d2ed66b236f51fe4aacf47bb6901419f)

### レビュー機能
[![Image from Gyazo](https://i.gyazo.com/a1018daa8f63f8e8508e73d09ad68aea.png)](https://gyazo.com/a1018daa8f63f8e8508e73d09ad68aea)
