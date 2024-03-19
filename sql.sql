CREATE DATABASE IF NOT EXISTS youtube_data; -- Create the database if it doesn't exist
USE youtube_data; -- Use the youtube_data database
-- Create the database if it doesn't exist

-- Table: channel
-- This table stores information about YouTube channels
CREATE TABLE IF NOT EXISTS channels (
    channel_id VARCHAR(255) PRIMARY KEY, -- Unique identifier for the channel
    channel_name VARCHAR(255), -- Name of the channel
    channel_type VARCHAR(255), -- Type of the channel (e.g., music, gaming)
    channel_views INT, -- Total number of views for the channel
    channel_description TEXT, -- Description of the channel
    channel_status VARCHAR(255) -- Status of the channel (e.g., active, inactive)
);

-- Check if data has been inserted into the Channel table
SELECT * FROM channels;

-- Table: playlists
-- This table stores information about playlists associated with YouTube channels
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id VARCHAR(255) PRIMARY KEY, -- Unique identifier for the playlist
    channel_id VARCHAR(255), -- Foreign key referencing the channel table
    playlist_name VARCHAR(255), -- Name of the playlist
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id) -- Define foreign key constraint
);

-- Check if data has been inserted into the Playlist table
SELECT * FROM playlists;

-- Table: Comment
-- This table stores information about comments on YouTube videos
CREATE TABLE IF NOT EXISTS comments (
    comment_id VARCHAR(255) PRIMARY KEY, -- Unique identifier for the comment
    video_id VARCHAR(255), -- Foreign key referencing the video table
    comment_text TEXT, -- Text of the comment
    comment_author VARCHAR(255), -- Name of the comment author
    comment_date DATETIME, -- Date and time when the comment was published
    FOREIGN KEY (video_id) REFERENCES videos(video_id) -- Define foreign key constraint
);

-- Check if data has been inserted into the Comment table
SELECT * FROM comments;

-- Table: Video
-- This table stores information about YouTube videos
CREATE TABLE IF NOT EXISTS videos (
    video_id VARCHAR(255) PRIMARY KEY, -- Unique identifier for the video
    playlist_id VARCHAR(255), -- Foreign key referencing the playlist table
    video_name VARCHAR(255), -- Name of the video
    video_description TEXT, -- Description of the video
    published_date DATETIME, -- Date and time when the video was published
    view_count INT, -- Total number of views for the video
    like_count INT, -- Total number of likes for the video
    dislike_count INT, -- Total number of dislikes for the video
    favorite_count INT, -- Total number of times the video has been marked as a favorite
    comment_count INT, -- Total number of comments on the video
    duration INT, -- Duration of the video in seconds
    thumbnail VARCHAR(255), -- URL of the thumbnail for the video
    caption_status VARCHAR(255), -- Status of the video caption
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) -- Define foreign key constraint
);

-- Check if data has been inserted into the Video table
SELECT * FROM videos;

-- Describe the Channel table to view its structure
DESCRIBE channels;

-- Describe the Playlist table to view its structure
DESCRIBE playlists;

-- Describe the Comment table to view its structure
DESCRIBE comments;

-- Describe the Video table to view its structure
DESCRIBE videos;

-- Select the video name and channel name from the videos and channels tables
SELECT videos.video_name, channels.channel_name

-- Join the videos table with the playlists table based on the playlist_id column
-- This will match videos with their corresponding playlists
SELECT videos.video_name, channels.channel_name
FROM videos
INNER JOIN playlists ON videos.playlist_id = playlists.playlist_id
INNER JOIN channels ON playlists.channel_id = channels.channel_id;

ALTER TABLE videos
ADD channel_id VARCHAR(255); -- Define channel_id column with VARCHAR data type

SELECT videos.video_name, MAX(channels.channel_name) AS channel_name
FROM videos
INNER JOIN playlists ON videos.playlist_id = playlists.playlist_id
INNER JOIN channels ON playlists.channel_id = channels.channel_id
GROUP BY videos.video_name;

DESCRIBE videos;
DESCRIBE videos_channels;

SELECT videos.video_name, MAX(channels.channel_name) AS channel_name
FROM videos
INNER JOIN playlists ON videos.playlist_id = playlists.playlist_id
INNER JOIN channels ON playlists.channel_id = channels.channel_id
GROUP BY videos.video_name;

