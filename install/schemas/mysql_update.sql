
CREATE TABLE phpbb_profile_guestbook (
  gb_id mediumint(8) NOT NULL AUTO_INCREMENT,
  user_id mediumint(8) NOT NULL DEFAULT '0',
  poster_id mediumint(8) NOT NULL,
  gb_time int(11) NOT NULL DEFAULT '0',
  master_look tinyint(1) NOT NULL DEFAULT '0',
  message text NOT NULL,
  PRIMARY KEY (gb_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_articles (
  article_id mediumint(8) NOT NULL AUTO_INCREMENT,
  article_class mediumint(8) NOT NULL,
  article_title varchar(255) NOT NULL,
  article_poster mediumint(8) NOT NULL,
  article_time int(11) NOT NULL DEFAULT '0',
  article_views int(11) NOT NULL DEFAULT '0',
  article_approval tinyint(1) NOT NULL DEFAULT '0',
  article_text text NOT NULL,
  PRIMARY KEY (article_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_articles_class (
  ac_id mediumint(8) NOT NULL AUTO_INCREMENT,
  ac_name varchar(255) NOT NULL,
  ac_sort smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (ac_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_topic_collect (
  tc_id mediumint(8) NOT NULL AUTO_INCREMENT,
  tc_topic mediumint(8) NOT NULL,
  tc_user mediumint(8) NOT NULL,
  tc_title varchar(255) NOT NULL,
  PRIMARY KEY (tc_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_ucp_main (
  um_id mediumint(8) NOT NULL AUTO_INCREMENT,
  um_user mediumint(8) NOT NULL,
  um_name varchar(255) NOT NULL,
  um_header text NOT NULL,
  um_body text NOT NULL,
  PRIMARY KEY (um_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_styles (
  style_id mediumint(8) NOT NULL AUTO_INCREMENT,
  style_name varchar(255) NOT NULL,
  style_path varchar(255) NOT NULL,
  style_version varchar(255) NOT NULL,
  style_copyright varchar(255) NOT NULL,
  PRIMARY KEY (style_id),
  UNIQUE KEY style_path (style_path)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_download (
  download_user mediumint(8) NOT NULL,
  download_attach mediumint(8) NOT NULL,
  download_time int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO phpbb_styles (style_id, style_name, style_path, style_version, style_copyright) VALUES (1, 'Gray', 'Gray', '6.0.271', 'phpBB-WAP');

ALTER TABLE phpbb_users ADD user_can_gb TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE phpbb_users CHANGE user_java_otv user_java_otv TINYINT( 4 ) NOT NULL DEFAULT '1';
ALTER TABLE phpbb_users CHANGE user_bb_panel user_bb_panel TINYINT( 4 ) NOT NULL DEFAULT '1';
INSERT INTO phpbb_config (config_name, config_value) VALUES ('allow_guests_gb', '0');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('gb_posts', '10');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('gb_quick', '1');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('download_mode', '0');

UPDATE phpbb_config SET config_value = '271' WHERE config_name = 'version';
UPDATE phpbb_users SET user_style = 1;