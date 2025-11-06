-- よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
SELECT episode_name, view_count 
	FROM episodes
ORDER BY view_count DESC
limit 3;

-- よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
SELECT s.show_name, ss.season_number, e.episode_number, e.episode_name, e.view_count
	FROM episodes AS e
JOIN shows AS s 
	ON e.show_id = s.show_id
LEFT JOIN seasons AS ss
	ON e.season_id = ss.season_id
ORDER BY e.view_count DESC
LIMIT 3;

-- 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
SELECT c.channel_name, s.start_time, s.end_time, ss.season_number, e.episode_number, e.episode_name, e.episode_detail
FROM episodes AS e
JOIN program_channels AS pc
ON e.episode_id = pc.episode_id
JOIN channels AS c
ON pc.channel_id = c.channel_id
JOIN schedules AS s
ON e.schedule_id = s.schedule_id
LEFT JOIN seasons AS ss
ON e.season_id = ss.season_id
WHERE DATE(s.start_time) = DATE(NOW());

-- Prime Channelというチャンネルがあったとして、Prime Channelのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。Prime Channelのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
SELECT c.channel_name, s.start_time, s.end_time, ss.season_number, e.episode_number, e.episode_name, e.episode_detail
FROM episodes AS e
JOIN program_channels AS pc
ON e.episode_id = pc.episode_id
JOIN channels AS c
ON pc.channel_id = c.channel_id
JOIN schedules AS s
ON e.schedule_id = s.schedule_id
LEFT JOIN seasons AS ss
ON e.season_id = ss.season_id
WHERE DATE(s.start_time) < DATE(NOW() + INTERVAL 7 DAY)
AND DATE(s.start_time) >= DATE(NOW())
AND c.channel_name = 'Prime Channel';

-- (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
SELECT s.show_name, SUM(e.view_count) AS total_view_count FROM episodes AS e
JOIN shows AS s
ON e.show_id = s.show_id
JOIN schedules AS sc
ON e.schedule_id = sc.schedule_id
-- WHEREはGROUP BYの前に記載
WHERE DATE(sc.start_time) >= DATE(NOW() - INTERVAL 7 DAY)
AND DATE(sc.start_time) < DATE(NOW())
-- episodesテーブルの中で,show_idが同じレコードをグループ化
GROUP BY e.show_id
ORDER BY total_view_count DESC
LIMIT 2;

-- (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

SELECT g.genre_name, s.show_name, avc.average_view_count
FROM genres AS g
JOIN shows AS s
ON g.genre_id = s.genre_id
JOIN (
SELECT show_id, AVG(e.view_count) AS average_view_count
FROM episodes AS e
-- episodesテーブルの中で,show_idが同じレコードをグループ化
GROUP BY e.show_id
) AS avc
ON s.show_id = avc.show_id
WHERE 
avc.average_view_count 
IN 
(
SELECT MAX(avc_1.average_view_count_1)
FROM genres AS g
JOIN shows AS s
ON g.genre_id = s.genre_id
JOIN (
SELECT show_id, AVG(e.view_count) AS average_view_count_1
FROM episodes AS e
-- episodesテーブルの中で,show_idが同じレコードをグループ化
GROUP BY e.show_id
) AS avc_1
ON s.show_id = avc_1.show_id
-- ジャンルごとのmax(平均視聴率)
GROUP BY g.genre_id
);