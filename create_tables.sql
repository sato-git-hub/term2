CREATE TABLE channels (
    channel_id INT NOT NULL AUTO_INCREMENT,  
    channel_name VARCHAR(100) NOT NULL,        
    PRIMARY KEY(channel_id),
    UNIQUE KEY(channel_name)                    
);

CREATE TABLE genres (
    genre_id INT NOT NULL AUTO_INCREMENT,  
    genre_name VARCHAR(100) NOT NULL,    
    PRIMARY KEY(genre_id),
    UNIQUE KEY(genre_name) 
);

CREATE TABLE shows (
    show_id INT NOT NULL AUTO_INCREMENT, 
    genre_id INT NOT NULL,   
    show_name VARCHAR(100) NOT NULL,  
    show_detail VARCHAR(200) NULL,      
    PRIMARY KEY(show_id), 
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),   
    
    UNIQUE KEY uk_genre_show (genre_id, show_name)                 
);

CREATE TABLE seasons (
		season_id INT NOT NULL AUTO_INCREMENT, 
    show_id INT NOT NULL, 
    season_number INT NOT NULL,  
		PRIMARY KEY(season_id),
		FOREIGN KEY (show_id) REFERENCES shows(show_id),  
		UNIQUE KEY uk_show_season (show_id, season_number)
);

CREATE TABLE schedules (
    schedule_id INT NOT NULL AUTO_INCREMENT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    
    PRIMARY KEY(schedule_id),

    UNIQUE KEY uk_schedule_time (start_time, end_time)
);

CREATE TABLE episodes (
    episode_id INT NOT NULL AUTO_INCREMENT,
    show_id INT NOT NULL,
    season_id INT NULL,                      
    schedule_id INT NOT NULL,                
    episode_number INT NOT NULL,             
    episode_name VARCHAR(100) NOT NULL,
    viewing_time TIME NOT NULL,         
    view_count BIGINT NOT NULL DEFAULT 0,         
    episode_detail VARCHAR(200) NULL,             
		PRIMARY KEY(episode_id),
    
    FOREIGN KEY (show_id) REFERENCES shows(show_id),
    FOREIGN KEY (season_id) REFERENCES seasons(season_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id),

    UNIQUE KEY uk_show_episode_season (show_id, episode_number, season_id)
);

CREATE TABLE program_schedules (
    program_schedule_id INT NOT NULL AUTO_INCREMENT,
    episode_id INT NOT NULL,
    schedule_id INT NOT NULL,

    PRIMARY KEY(program_schedule_id),
    
    UNIQUE KEY uk_episode_schedule (episode_id, schedule_id),

    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
);

CREATE TABLE program_channels (
    program_channel_id INT NOT NULL AUTO_INCREMENT,
    episode_id INT NOT NULL,
    channel_id INT NOT NULL,

    PRIMARY KEY(program_channel_id),
    
    UNIQUE KEY uk_episode_channel (episode_id, channel_id),

    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);
