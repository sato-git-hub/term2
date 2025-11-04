##　手順
1.リポジトリをクローン
 - GitHubのこのリポジトリーをクローンする
```bash
    git clone このリポジトリのurl
```
 - クローンしたディレクトリに移動
 ```bash 
  cd term2
 ```

2.MySQLの起動
```bash
    mysql -u ユーザー名 -p 
```

3.データベースの作成
 - internet_tv_dbという名前で、データベースを作ります
 ```sql
    CREATE DATABASE internet_tv_db;
  ```
 - 作成したデータベースを選択
 ```sql
    USE internet_tv_db;
  ```
 - MySQLを終了
```sql
    QUIT;
  ```

4.テーブルの構築
```bash
    mysql -u ユーザー名 -p internet_tv_db < create_tables.sql
```
5.テーブルにサンプルデータを入れる
```bash
    mysql -u ユーザー名 -p internet_tv_db < insert_data.sql
    ```

## テーブル設計






