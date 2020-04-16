## アプリケーションの概要
カレンダーにコーディネート写真を登録することで、毎日の服選びの手間を解消するためのサービスです。  
作品URL (https://www.goutfit-app.xyz/)

## アプリケーション内で使用した技術
Ruby on Rails(Rails5.2) / jQuery / MySQL  
AWS / EC2 / RDS / S3 / Route53 / ELB / ACM  
Capistrano / Nginx

## アプリケーションの機能一覧
- ユーザー管理機能（devise)
- 画像(コーディネート写真)投稿機能（CarrierWave）
- 画像一覧表示機能
- ページネーション機能（kaminari）
- カレンダーに画像を登録、表示する機能（simple calendar）
- カレンダーに登録した内容を編集する機能

## アプリケーションに関するコメント
- 「毎日の服選びが面倒臭い」そんな気持ちが少しでも解消できればいいなという思いで作成しました。
- 技術に関しては、AWSでVPCやSubnetの設定から自分で行い、スクールカリキュラムでは取り扱わなかった、RDS・Route53・ELB・ACM に新たに挑戦いたしました。

## メイン機能の詳細
- コーディネート写真登録 &  一覧表示  
ファイルから画像を選択し、アップロードすることができます。
<img src="https://i.gyazo.com/9229a3ccb9a5dc64106c22e2d11b710a.gif" alt="Image from Gyazo" width="250"/>

- カレンダー登録 & 表示  
登録したコーディネート写真の中から選択し、お好きな日付に登録することができます。
<img src="https://i.gyazo.com/c92fe94ee2be63aa5ca8dd0441f88053.gif" alt="Image from Gyazo" width="250"/>

## 使用法
#### テスト用アカウント（※ログイン画面にも記載してあります！）  
- e-mail  
 goutfit_t_user@gmail.com  
- password  
 goutfit_t_user  
- テスト用画像  
 [ダウンロード](https://www.goutfit-app.xyz/download)  
 
テスト用アカウントでログインいただき、  
ヘッダーの「Closet」をクリックでコーディネート登録&一覧表示へ、  
「Calendar」をクリックでカレンダー登録機能へ遷移し、各機能をご確認いただけます。
<img src="https://i.gyazo.com/2e36eac6aa2a51f0f17f45bd8d8efb97.png" alt="Image from Gyazo" width="400"/>

#### ローカル環境で利用する場合
```
$ git clone https://github.com/nom30523/goutfit.git
$ cd goutfit
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s
👉 http://localhost:3000
```
## 今後の開発予定
- 開発環境にDockerを導入
- CircleCIによるCI/CDパイプラインの構築
- コーディネートランダム選択機能
- 複数画像投稿機能
- APIによる天気予報の表示機能
