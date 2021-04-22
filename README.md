# ながのCAKE

このサイトは、長野県にある小さな洋菓子店「ながのCAKE」さんの商品を通販するためのサイトです。

昨年始めたInstagramから人気となり、全国から注文が来るようになったため、このサイトを開設しました。

「ながのCAKE」さん自慢のケーキや焼き菓子などをこのサイトから購入することができます。

## 使用技術

* Ruby 2.6.3
* Rails 5.2.5
* SQlite3
* Puma 3.11
* AWS
* Sass-Rails 5.0

## 機能一覧

* ユーザー登録、ログイン機能（devise）
* 投稿機能
  * 画像アップロード（refile）
  * 画像リサイズ（refile-mini_magick）
* レイアウト編集
  * CSSフレームワーク(bootstrap 4.5)
  * Jquery導入(jquery-rails)
  * アイコン(Font-Awesome-Sass 5.13)
* ページネーション機能（kaminari 1.2.1）
* バリデーションの日本語表記（rails-I18n）
