## 手順
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

- channels
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
| channel_id| int | |PRIMARY||YES|
|  channel_name |  varchar(100)| |UNIQUE|||

- shows
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
| show_id| int | |PRIMARY||YES|
| genre_id |int| |FOREIGN, UNIQUE(uk_genre_show)|||
| show_name |varchar(100)|UNIQUE(uk_genre_show)||||
| show_detail |varchar(200)|NULL||||

- genres
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
| genre_id| int | |PRIMARY||YES|
| genre_name | varchar(100)| |UNIQUE|||

- seasons
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
|season_id| int | |PRIMARY||YES|
|show_id | int| |FOREIGN, UNIQUE(uk_show_season)|||
| season_number |int| |UNIQUE(uk_show_season)|||

- episodes
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
| episode_id | int | |PRIMARY||YES|
| show_id | int| |FOREIGN,UNIQUE(uk_show_episode)|||
| season_id |int|NULL|FOREIGN|||
| schedule_id |int| |FOREIGN|||
| episode_number |  int| |UNIQUE(uk_show_episode)|||
| episode_name |  varchar(100)| ||||
| viewing_time | time| ||||
| view |  bigint(20)| ||0||
| episode_detail |  varchar(200)|NULL||||

- schedules
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
|schedule_id| int | |PRIMARY||YES|
| start_time| DATETIME| |UNIQUE(uk_schedule_time)|||
| end_time| DATETIME||UNIQUE(uk_schedule_time)|||

- program_schedules
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
|program_schedule_id| int | |PRIMARY||YES|
|episode_id| int| |FOREIGN, UNIQUE(uk_episode_schedule)|||
|schedule_id| int| |FOREIGN, UNIQUE(uk_episode_schedule)|||

- program_channels
  
| カラム名 | データ型 |NULL |キー|初期値|AUTO INCREMENT|
|-|-|-|-|-|-|
|program_channel_id| int | |PRIMARY||YES|
|episode_id| int| |FOREIGN, UNIQUE(uk_episode_channel)|||
|channel_id| int| |FOREIGN, UNIQUE(uk_episode_channel)|||
