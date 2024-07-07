# github_finder_flutter

GitHub リポジトリを検索するための Flutter アプリです。

## 要件

- Flutter SDK（最新の安定版）
- Dart SDK（最新の安定版）

## セットアップ

1. リポジトリをクローン
   ```bash
   git clone <repository_url>
   ```

2. プロジェクトのディレクトリに移動
   ```bash
   cd github_finder_flutter
   ```

3. 依存パッケージをインストール
   ```bash
    flutter pub get
    ```

4. アプリを実行
    ```bash
    flutter run
    ```

## 機能

- キーワードで GitHub リポジトリを検索
- 検索結果にリポジトリ名を表示
- リポジトリの詳細情報（名前、オーナーアイコン、言語、Star数、Watcher数、Fork数、Issue数）を表示

## 状態管理パッケージについて

このアプリでは、[Provider](https://pub.dev/packages/provider) パッケージを使用して状態管理を行っています。

## API

- GitHub Search Repositories API
  - [API ドキュメント](https://docs.github.com/en/rest/reference/search#search-repositories)
  - [API エンドポイント](https://api.github.com/search/repositories)

## ライセンス

このプロジェクトは MIT ライセンスの下でライセンスされています。
