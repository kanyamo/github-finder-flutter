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

4. pre-commit フックを有効化
    ```bash
    pre-commit install
    ```

5. アプリを実行
    ```bash
    flutter run
    ```

## 機能

### リポジトリ検索

- リポジトリの検索を行うことができます。検索方法には、基本検索機能と詳細検索機能があります。
- 検索可能なリポジトリは、GitHub の公開リポジトリのみです。

#### 基本検索機能

基本検索機能では、キーワードを用いて検索が行えるようになっています。

#### 詳細検索機能

- 詳細検索機能では、キーワードに加え、リポジトリのユーザー名、organizationでの検索が行うことができます。
- さらに、リポジトリ名や説明、topics, READMEの中それぞれについてキーワード検索を行うか否かを個別に指定できます。
- 詳細検索画面を閉じても検索条件は保持されますが、詳細検索を行った後に基本検索を行った場合、キーワードのみが検索条件として使用されます。その後再度詳細検索画面を開くと、前回の詳細検索条件が復元されます。

### 検索結果の表示

- 検索結果にリポジトリ名とオーナーのアイコン、Star数が一覧表示されます。
- リポジトリ名をタップすると、リポジトリの詳細情報を表示する画面に遷移します。

### リポジトリの詳細情報の表示

- リポジトリの詳細情報（名前、オーナーアイコン、説明、言語、Star数、Watcher数、Fork数、Issue数）を表示します。
- Issue数はオープン中のもののみを表示します。
- "このユーザーが作成したリポジトリを検索する" ボタンで、オーナーのリポジトリを検索することができます。
- "View on GitHub" ボタンで、GitHub のリポジトリページを開くことができます。

## 状態管理パッケージについて

このアプリでは、[Riverpod](https://pub.dev/packages/riverpod) を使用して状態管理を行っています。

## API

- GitHub Search Repositories API
  - [API ドキュメント](https://docs.github.com/en/rest/reference/search#search-repositories)
  - [API エンドポイント](https://api.github.com/search/repositories)

## ライセンス

このプロジェクトは MIT ライセンスの下でライセンスされています。
