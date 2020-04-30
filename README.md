# アプリケーションの概要
カレンダーにコーディネート写真を登録することで、毎日の服選びの手間を解消するためのサービスです。  
作品URL (https://www.goutfit-app.xyz/)

# 使用した技術
- バックエンド
  - Ruby2.5.1
  - Ruby on Rails(Rails5.2)
  - MySQL
  - Nginx
- フロントエンド
  - HTML
  - SCSS
  - jQuery
## インフラストラクチャー
- CircleCI
  - Githubへpushに対してCI
  - masterブランチへの push と marge に対してCD
  - Capistrano
- AWS
  - EC2
  - RDS
  - S3
  - Route53
  - ALB
  - ACM
- Docker (開発環境)
  - Dockerfile
  - docker-compose

# アプリケーションの機能一覧
- アカウント登録、ログイン機能（devise)
- 画像(コーディネート写真)投稿機能（CarrierWave）
- 画像一覧表示機能
- ページネーション機能（kaminari）
- カレンダーに画像を登録、表示する機能（simple calendar）
- カレンダーに登録した内容を編集・削除する機能

# アプリケーションに関するコメント
- 「毎日の服選びが面倒臭い」そんな気持ちが少しでも解消できればいいなという思いで作成しました。
- 技術に関しては、AWSでデフォルトのVPCやSubnetは使用せず自分で１から設定を行い、スクールカリキュラムでは取り扱わなかった、RDS・Route53・ALB・ACM にも新たに挑戦いたしました。また、より実践的な開発環境にする為に、DockerとCircleCIを新たに学習し、導入いたしました。

# アプリサンプル画像
<img src="https://i.gyazo.com/b418c100a31063b12cbf2a9daeff71ad.png" alt="Image from Gyazo" width="250"/> <img src="https://i.gyazo.com/67fd5f13950e69ad5eb5b92db3ff5956.png" alt="Image from Gyazo" width="250"/> <img src="https://i.gyazo.com/a71adc6acf8010e5a524e2f8e86379f0.png" alt="Image from Gyazo" width="250"/> <img src="https://i.gyazo.com/4c3badd206e9ac07209a3bef7c7765ed.jpg" alt="Image from Gyazo" width="250"/> <img src="https://i.gyazo.com/9a571350a29ff5cb10e5701e9f20d927.png" alt="Image from Gyazo" width="250"/> <img src="https://i.gyazo.com/c4f000433a7e89664e3f448b6bc33f6e.png" alt="Image from Gyazo" width="250"/>

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

# 今後の開発予定
- ~~開発環境にDockerを導入~~　（← 導入完了しました 4/21 up）
- ~~CircleCIによるCI/CDパイプラインの構築~~ (← 導入しました 4/30 up)
- コーディネートランダム選択機能
- 複数画像投稿機能
- APIによる天気予報の表示機能
