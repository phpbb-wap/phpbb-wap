CREATE TABLE phpbb_auth_access (
   group_id mediumint(8) DEFAULT '0' NOT NULL,
   forum_id smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   auth_view tinyint(1) DEFAULT '0' NOT NULL,
   auth_read tinyint(1) DEFAULT '0' NOT NULL,
   auth_post tinyint(1) DEFAULT '0' NOT NULL,
   auth_reply tinyint(1) DEFAULT '0' NOT NULL,
   auth_edit tinyint(1) DEFAULT '0' NOT NULL,
   auth_delete tinyint(1) DEFAULT '0' NOT NULL,
   auth_sticky tinyint(1) DEFAULT '0' NOT NULL,
   auth_announce tinyint(1) DEFAULT '0' NOT NULL,
   auth_marrow tinyint(1) DEFAULT '0' NOT NULL,
   auth_vote tinyint(1) DEFAULT '0' NOT NULL,
   auth_pollcreate tinyint(1) DEFAULT '0' NOT NULL,
   auth_attachments tinyint(1) DEFAULT '0' NOT NULL,
   auth_mod tinyint(1) DEFAULT '0' NOT NULL,
   auth_download TINYINT(1) DEFAULT '0' NOT NULL,
   KEY group_id (group_id),
   KEY forum_id (forum_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_user_group (
   group_id mediumint(8) DEFAULT '0' NOT NULL,
   user_id mediumint(8) DEFAULT '0' NOT NULL,
   user_pending tinyint(1),
   KEY group_id (group_id),
   KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_groups (
   group_id mediumint(8) NOT NULL auto_increment,
   group_type tinyint(4) DEFAULT '1' NOT NULL,
   group_name varchar(40) DEFAULT '' NOT NULL,
   group_description varchar(255) NOT NULL,
   group_moderator mediumint(8) DEFAULT '0' NOT NULL,
   group_single_user tinyint(1) DEFAULT '1' NOT NULL,
   guestbook_enable TINYINT(1) DEFAULT '1' NOT NULL,
   group_logo varchar(100) DEFAULT '' NOT NULL,
   PRIMARY KEY (group_id),
   KEY group_single_user (group_single_user)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_groups_guestbook (
   gb_id int(10) NOT NULL auto_increment,
   group_id int(10) NOT NULL default '0',
   poster_id int(10) NOT NULL default '0',
   bbcode varchar(64) NOT NULL default '',
   gb_time int(10) NOT NULL default '0',
   message text NOT NULL,
   PRIMARY KEY  (gb_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_banlist (
   ban_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   ban_userid mediumint(8) NOT NULL,
   ban_ip char(8) NOT NULL,
   ban_email varchar(255),
   PRIMARY KEY (ban_id),
   KEY ban_ip_user_id (ban_ip, ban_userid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_categories (
   cat_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   cat_title varchar(100),
   cat_icon varchar(100),
   cat_order mediumint(8) UNSIGNED NOT NULL,
   PRIMARY KEY (cat_id),
   KEY cat_order (cat_order)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_config (
    config_name varchar(255) NOT NULL,
    config_value varchar(255) NOT NULL,
    PRIMARY KEY (config_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_confirm (
  confirm_id char(32) DEFAULT '' NOT NULL,
  session_id char(32) DEFAULT '' NOT NULL,
  code char(6) DEFAULT '' NOT NULL, 
  PRIMARY KEY (session_id, confirm_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_disallow (
   disallow_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   disallow_username varchar(25) DEFAULT '' NOT NULL,
   PRIMARY KEY (disallow_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_forum_prune (
   prune_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   forum_id smallint(5) UNSIGNED NOT NULL,
   prune_days smallint(5) UNSIGNED NOT NULL,
   prune_freq smallint(5) UNSIGNED NOT NULL,
   PRIMARY KEY(prune_id),
   KEY forum_id (forum_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_forums (
   forum_id smallint(5) UNSIGNED NOT NULL,
   cat_id mediumint(8) UNSIGNED NOT NULL,
   forum_name varchar(150),
   forum_desc text,
   forum_icon varchar(100),
   forum_status tinyint(4) DEFAULT '0' NOT NULL,
   forum_order mediumint(8) UNSIGNED DEFAULT '1' NOT NULL,
   forum_posts mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   forum_postcount TINYINT(1) DEFAULT '1' NOT NULL,
   forum_topics mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   forum_last_post_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   prune_next int(11),
   prune_enable tinyint(1) DEFAULT '0' NOT NULL,
   auth_view tinyint(2) DEFAULT '0' NOT NULL,
   auth_read tinyint(2) DEFAULT '0' NOT NULL,
   auth_post tinyint(2) DEFAULT '0' NOT NULL,
   auth_reply tinyint(2) DEFAULT '0' NOT NULL,
   auth_edit tinyint(2) DEFAULT '0' NOT NULL,
   auth_delete tinyint(2) DEFAULT '0' NOT NULL,
   auth_sticky tinyint(2) DEFAULT '0' NOT NULL,
   auth_announce tinyint(2) DEFAULT '0' NOT NULL,
   auth_marrow TINYINT( 2 ) DEFAULT '0' NOT NULL,
   auth_vote tinyint(2) DEFAULT '0' NOT NULL,
   auth_pollcreate tinyint(2) DEFAULT '0' NOT NULL,
   auth_attachments tinyint(2) DEFAULT '0' NOT NULL,
   auth_download TINYINT(2) DEFAULT '0' NOT NULL,
   forum_money int(12) default '0',
   PRIMARY KEY (forum_id),
   KEY forums_order (forum_order),
   KEY cat_id (cat_id),
   KEY forum_last_post_id (forum_last_post_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_posts (
   post_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   topic_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   forum_id smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   poster_id mediumint(8) DEFAULT '0' NOT NULL,
   post_time int(11) DEFAULT '0' NOT NULL,
   poster_ip char(8) NOT NULL,
   post_username varchar(25),
   enable_bbcode tinyint(1) DEFAULT '1' NOT NULL,
   enable_html tinyint(1) DEFAULT '0' NOT NULL,
   enable_smilies tinyint(1) DEFAULT '1' NOT NULL,
   enable_sig tinyint(1) DEFAULT '1' NOT NULL,
   post_edit_time int(11),
   post_edit_count smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   post_reviews smallint(8) unsigned NOT NULL default 0,
   post_locked tinyint(1) unsigned NOT NULL default 0,
   post_attachment TINYINT(1) DEFAULT '0' NOT NULL,
   PRIMARY KEY (post_id),
   KEY forum_id (forum_id),
   KEY topic_id (topic_id),
   KEY poster_id (poster_id),
   KEY post_time (post_time)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_post_reports (
  report_id mediumint(8) NOT NULL auto_increment,
  post_id mediumint(8) NOT NULL default '0',
  reporter_id mediumint(8) NOT NULL default '0',
  report_status tinyint(1) NOT NULL default '0',
  report_time int(11) NOT NULL default '0',
  report_comments text,
  last_action_user_id mediumint(8) default '0',
  last_action_time int(11) NOT NULL default '0',
  last_action_comments text,
  PRIMARY KEY (report_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_posts_text (
   post_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   bbcode_uid char(10) DEFAULT '' NOT NULL,
   post_subject char(60),
   post_text text,
   PRIMARY KEY (post_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_privmsgs (
   privmsgs_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   privmsgs_type tinyint(4) DEFAULT '0' NOT NULL,
   privmsgs_subject varchar(255) DEFAULT '0' NOT NULL,
   privmsgs_from_userid mediumint(8) DEFAULT '0' NOT NULL,
   privmsgs_to_userid mediumint(8) DEFAULT '0' NOT NULL,
   privmsgs_date int(11) DEFAULT '0' NOT NULL,
   privmsgs_ip char(8) NOT NULL,
   PRIMARY KEY (privmsgs_id),
   KEY privmsgs_from_userid (privmsgs_from_userid),
   KEY privmsgs_to_userid (privmsgs_to_userid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_privmsgs_text (
   privmsgs_text_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   privmsgs_text text,
   PRIMARY KEY (privmsgs_text_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_ranks (
   rank_id smallint(5) UNSIGNED NOT NULL auto_increment,
   rank_title varchar(50) NOT NULL,
   rank_min mediumint(8) DEFAULT '0' NOT NULL,
   rank_special tinyint(1) DEFAULT '0',
   rank_image varchar(255),
   PRIMARY KEY (rank_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_search_results (
  search_id int(11) UNSIGNED NOT NULL default '0',
  session_id char(32) NOT NULL default '',
  search_time int(11) DEFAULT '0' NOT NULL,
  search_array text NOT NULL,
  PRIMARY KEY  (search_id),
  KEY session_id (session_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_search_wordlist (
   word_text varchar(50) binary NOT NULL default '',
   word_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   word_common tinyint(1) unsigned NOT NULL default '0',
   PRIMARY KEY (word_text),
   KEY word_id (word_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_search_wordmatch (
   post_id mediumint(8) UNSIGNED NOT NULL default '0',
   word_id mediumint(8) UNSIGNED NOT NULL default '0',
   title_match tinyint(1) NOT NULL default '0',
   KEY post_id (post_id),
   KEY word_id (word_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_sessions (
   session_id char(32) DEFAULT '' NOT NULL,
   session_user_id mediumint(8) DEFAULT '0' NOT NULL,
   session_start int(11) DEFAULT '0' NOT NULL,
   session_time int(11) DEFAULT '0' NOT NULL,
   session_ip char(8) DEFAULT '0' NOT NULL,
   session_page int(11) DEFAULT '0' NOT NULL,
   session_logged_in tinyint(1) DEFAULT '0' NOT NULL,
   session_admin tinyint(2) DEFAULT '0' NOT NULL,
   PRIMARY KEY (session_id),
   KEY session_user_id (session_user_id),
   KEY session_id_ip_user_id (session_id, session_ip, session_user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_sessions_keys (
  key_id varchar(32) DEFAULT '0' NOT NULL,
  user_id mediumint(8) DEFAULT '0' NOT NULL,
  last_ip varchar(8) DEFAULT '0' NOT NULL,
  last_login int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (key_id, user_id),
  KEY last_login (last_login)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_smilies (
   smilies_id smallint(5) UNSIGNED NOT NULL auto_increment,
   code varchar(50),
   smile_url varchar(100),
   emoticon varchar(75),
   PRIMARY KEY (smilies_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_topics (
   topic_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   forum_id smallint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_title char(60) NOT NULL,
   topic_poster mediumint(8) DEFAULT '0' NOT NULL,
   topic_time int(11) DEFAULT '0' NOT NULL,
   topic_views mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_replies mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_status tinyint(3) DEFAULT '0' NOT NULL,
   topic_vote tinyint(1) DEFAULT '0' NOT NULL,
   topic_type tinyint(3) DEFAULT '0' NOT NULL,
   topic_first_post_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_last_post_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_moved_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   topic_attachment TINYINT(1) DEFAULT '0' NOT NULL,
   topic_closed mediumint(8) not null DEFAULT '0',
   topic_color varchar(6),
   topic_marrow tinyint(1) DEFAULT '0',
   topic_class mediumint(8) DEFAULT '0',
   PRIMARY KEY (topic_id),
   KEY forum_id (forum_id),
   KEY topic_moved_id (topic_moved_id),
   KEY topic_status (topic_status),
   KEY topic_type (topic_type)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_topics_watch (
  topic_id mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  user_id mediumint(8) NOT NULL DEFAULT '0',
  notify_status tinyint(1) NOT NULL default '0',
  KEY topic_id (topic_id),
  KEY user_id (user_id),
  KEY notify_status (notify_status)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_users (
   user_id mediumint(8) NOT NULL,
   user_active tinyint(1) DEFAULT '1',
   username varchar(25) NOT NULL,
   user_password varchar(32) NOT NULL,
   user_session_time int(11) DEFAULT '0' NOT NULL,
   user_session_page smallint(5) DEFAULT '0' NOT NULL,
   user_lastvisit int(11) DEFAULT '0' NOT NULL,
   user_regdate int(11) DEFAULT '0' NOT NULL,
   user_level tinyint(4) DEFAULT '0',
   user_posts mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
   user_timezone decimal(5,2) DEFAULT '0' NOT NULL,
   user_dateformat varchar(14) DEFAULT 'Y m d H:i' NOT NULL,
   user_new_privmsg smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   user_unread_privmsg smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   user_last_privmsg int(11) DEFAULT '0' NOT NULL,
   user_login_tries smallint(5) UNSIGNED DEFAULT '0' NOT NULL,
   user_last_login_try int(11) DEFAULT '0' NOT NULL,
   user_emailtime int(11),
   user_viewemail tinyint(1),
   user_attachsig tinyint(1),
   user_allowhtml tinyint(1) DEFAULT '1',
   user_allowbbcode tinyint(1) DEFAULT '1',
   user_allowsmile tinyint(1) DEFAULT '1',
   user_allowavatar tinyint(1) DEFAULT '1' NOT NULL,
   user_allow_pm tinyint(1) DEFAULT '1' NOT NULL,
   user_allow_viewonline tinyint(1) DEFAULT '1' NOT NULL,
   user_notify_to_email tinyint(1) DEFAULT '1' NOT NULL,
   user_notify_to_pm tinyint(1) DEFAULT '1' NOT NULL,
   user_notify_pm tinyint(1) DEFAULT '0' NOT NULL,
   user_popup_pm tinyint(1) DEFAULT '0' NOT NULL,
   user_rank int(11) DEFAULT '0',
   user_avatar varchar(100),
   user_avatar_type tinyint(4) DEFAULT '0' NOT NULL,
   user_email varchar(255),
   user_qq varchar(15),
   user_number varchar(15),
   user_website varchar(100),
   user_from varchar(100),
   user_sig text,
   user_sig_bbcode_uid char(10),
   user_aim varchar(255),
   user_yim varchar(255),
   user_msnm varchar(255),
   user_occ varchar(100),
   user_interests varchar(255),
   user_actkey varchar(32),
   user_newpasswd varchar(32),
   user_warnings tinyint(4) unsigned NOT NULL DEFAULT 0,
   user_topics_per_page TINYINT(2) DEFAULT '15' NOT NULL,
   user_posts_per_page TINYINT(2) DEFAULT '15' NOT NULL,
   user_birthday INT DEFAULT '999999' NOT NULL,
   user_next_birthday_greeting INT DEFAULT '0' NOT NULL,
   user_gender TINYINT not null DEFAULT '0',
   user_on_off tinyint(4) NOT NULL default '1',
   user_attach_mod tinyint(4) NOT NULL default '1',
   user_nic_color varchar(100) NOT NULL default '',
   user_quick_answer TINYINT not null DEFAULT '0',
   user_index_spisok TINYINT not null DEFAULT '0',
   user_zvanie varchar(50) default '',
   user_purse varchar(50) default '',
   user_points int(100) NOT NULL default '0',
   user_post_leng SMALLINT NOT NULL default '0',
   time_last_click int(12) default '0',
   user_posl_red TINYINT not null DEFAULT '1',
   user_java_otv TINYINT not null DEFAULT '1',
   user_bb_panel TINYINT not null DEFAULT '1',
   user_report_optout TINYINT(1) DEFAULT '0' NOT NULL,
   user_message_quote TINYINT(1) DEFAULT '1' NOT NULL,
   user_view_latest_post TINYINT(1) DEFAULT '0' NOT NULL,
   user_style mediumint(8) DEFAULT '1',
   user_can_gb TINYINT(1) NOT NULL DEFAULT '1',
   PRIMARY KEY (user_id),
   KEY user_session_time (user_session_time)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_vote_desc (
  vote_id mediumint(8) UNSIGNED NOT NULL auto_increment,
  topic_id mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  vote_text text NOT NULL,
  vote_start int(11) NOT NULL DEFAULT '0',
  vote_length int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY  (vote_id),
  KEY topic_id (topic_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_vote_results (
  vote_id mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  vote_option_id tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  vote_option_text varchar(255) NOT NULL,
  vote_result int(11) NOT NULL DEFAULT '0',
  KEY vote_option_id (vote_option_id),
  KEY vote_id (vote_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_vote_voters (
  vote_id mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  vote_user_id mediumint(8) NOT NULL DEFAULT '0',
  vote_user_ip char(8) NOT NULL,
  KEY vote_id (vote_id),
  KEY vote_user_id (vote_user_id),
  KEY vote_user_ip (vote_user_ip)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_words (
   word_id mediumint(8) UNSIGNED NOT NULL auto_increment,
   word char(100) NOT NULL,
   replacement char(100) NOT NULL,
   PRIMARY KEY (word_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_forbidden_extensions (
  ext_id mediumint(8) UNSIGNED NOT NULL auto_increment, 
  extension varchar(100) NOT NULL, 
  PRIMARY KEY (ext_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_extension_groups (
  group_id mediumint(8) NOT NULL auto_increment,
  group_name char(20) NOT NULL,
  cat_id tinyint(2) DEFAULT '0' NOT NULL, 
  allow_group tinyint(1) DEFAULT '0' NOT NULL,
  download_mode tinyint(1) UNSIGNED DEFAULT '1' NOT NULL,
  upload_icon varchar(100) DEFAULT '',
  max_filesize int(20) DEFAULT '0' NOT NULL,
  forum_permissions varchar(255) default '' NOT NULL,
  PRIMARY KEY group_id (group_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_extensions (
  ext_id mediumint(8) UNSIGNED NOT NULL auto_increment,
  group_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
  extension varchar(100) NOT NULL,
  comment varchar(100),
  PRIMARY KEY ext_id (ext_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_attachments_desc (
  attach_id mediumint(8) UNSIGNED NOT NULL auto_increment,
  physical_filename varchar(255) NOT NULL,
  real_filename varchar(255) NOT NULL,
  download_count mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
  comment varchar(255),
  extension varchar(100),
  mimetype varchar(100),
  filesize int(20) NOT NULL,
  filetime int(11) DEFAULT '0' NOT NULL,
  thumbnail tinyint(1) DEFAULT '0' NOT NULL,
  PRIMARY KEY (attach_id),
  KEY filetime (filetime),
  KEY physical_filename (physical_filename(10)),
  KEY filesize (filesize)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_attachments (
  attach_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL, 
  post_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL, 
  privmsgs_id mediumint(8) UNSIGNED DEFAULT '0' NOT NULL,
  user_id_1 mediumint(8) NOT NULL,
  user_id_2 mediumint(8) NOT NULL,
  KEY attach_id_post_id (attach_id, post_id),
  KEY attach_id_privmsgs_id (attach_id, privmsgs_id),
  KEY post_id (post_id),
  KEY privmsgs_id (privmsgs_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8; 

CREATE TABLE phpbb_quota_limits (
  quota_limit_id mediumint(8) unsigned NOT NULL auto_increment,
  quota_desc varchar(20) NOT NULL default '',
  quota_limit bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (quota_limit_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_attach_quota (
  user_id mediumint(8) unsigned NOT NULL default '0',
  group_id mediumint(8) unsigned NOT NULL default '0',
  quota_type smallint(2) NOT NULL default '0',
  quota_limit_id mediumint(8) unsigned NOT NULL default '0',
  KEY quota_type (quota_type)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_rules (
   rule_id int(11) NOT NULL,
   rule_cat_id int(11) NOT NULL,
   rule_name varchar(200) NOT NULL,
   rule_subj text NOT NULL,
   rule_moder tinyint(4) NOT NULL,
   PRIMARY KEY (rule_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_rules_cat (
   cat_r_id int(11) NOT NULL,
   cat_r_name varchar(200) NOT NULL,
   PRIMARY KEY (cat_r_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_mods (
  mod_id mediumint(8) NOT NULL auto_increment,
  mod_name varchar(12) NOT NULL,
  mod_dir varchar(25) NOT NULL,
  mod_desc text NOT NULL,
  mod_author varchar(25) NOT NULL,
  mod_support varchar(255) NOT NULL,
  mod_version varchar(12) NOT NULL,
  mod_show int(1) NOT NULL DEFAULT '0',
  mod_power int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY(mod_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_class (
  class_id mediumint(8) NOT NULL AUTO_INCREMENT,
  class_name varchar(25) NOT NULL,
  class_forum mediumint(8) NOT NULL,
  PRIMARY KEY (class_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_pages (
  page_id mediumint(8) unsigned NOT NULL auto_increment,
  page_ago mediumint(8) NOT NULL default '0',
  page_title varchar(255) NOT NULL default '',
  PRIMARY KEY (page_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_modules (
  module_id mediumint(8) unsigned NOT NULL auto_increment,
  module_title varchar(255) NOT NULL default '',
  module_text text NOT NULL,
  module_param varchar(255) NOT NULL default '',
  module_hide tinyint(1) unsigned NOT NULL default '0',
  module_br tinyint(1) unsigned NOT NULL default '0',
  module_type tinyint(3) NOT NULL,
  module_sort mediumint(8) unsigned NOT NULL default '0',
  module_page mediumint(8) unsigned NOT NULL,
  module_needle mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY (module_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_forum_module (
  module_id mediumint(8) NOT NULL auto_increment,
  module_forum mediumint(8) NOT NULL,
  module_top text NOT NULL,
  module_bottom text NOT NULL,
  PRIMARY KEY (module_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_links (
  link_id mediumint(8) unsigned NOT NULL auto_increment,
  link_class_id mediumint(8) unsigned NOT NULL,
  link_title varchar(25) NOT NULL,
  link_name varchar(4) NOT NULL default '',
  link_url varchar(255) NOT NULL,
  link_desc text,
  link_join_time int(11) unsigned NOT NULL default '0',
  link_last_visit int(11) unsigned NOT NULL default '0',
  link_in int(10) unsigned NOT NULL default '0',
  link_out int(10) unsigned NOT NULL default '0',
  link_show tinyint(1) unsigned NOT NULL default '0',
  link_admin_user mediumint(8) NOT NULL default '0',
  PRIMARY KEY (link_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_linkclass (
  linkclass_id mediumint(8) unsigned NOT NULL auto_increment,
  linkclass_name varchar(255) NOT NULL,
  linkclass_sort int(8) unsigned NOT NULL default '0',
  linkclass_desc text,
  PRIMARY KEY (linkclass_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_guestbook (
  gb_id mediumint(8) unsigned NOT NULL auto_increment,
  gb_time int(11) unsigned NOT NULL default '0',
  gb_ip char(8) NOT NULL default '',
  gb_username varchar(255) NOT NULL default '',
  gb_password varchar(32) NOT NULL default '',
  gb_title varchar(255) NOT NULL default '',
  gb_text text NOT NULL,
  gb_reply text NOT NULL,
  PRIMARY KEY (gb_id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_friends (
  friend_id mediumint(8) unsigned NOT NULL auto_increment,
  user_id mediumint(8) NOT NULL,
  remark varchar(25) NOT NULL,
  ucp_id mediumint(8) NOT NULL,
  PRIMARY KEY (friend_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_album (
  pic_id int(11) unsigned NOT NULL auto_increment,
  pic_filename varchar(255) NOT NULL,
  pic_thumbnail varchar(255) default NULL,
  pic_title varchar(255) NOT NULL,
  pic_desc text,
  pic_user_id mediumint(8) NOT NULL,
  pic_username varchar(32) default NULL,
  pic_user_ip char(8) NOT NULL default '0',
  pic_time int(11) unsigned NOT NULL,
  pic_cat_id mediumint(8) unsigned NOT NULL default '1',
  pic_view_count int(11) unsigned NOT NULL default '0',
  pic_lock tinyint(3) NOT NULL default '0',
  pic_approval tinyint(3) NOT NULL default '1',
  PRIMARY KEY (pic_id),
  KEY pic_cat_id (pic_cat_id),
  KEY pic_user_id (pic_user_id),
  KEY pic_time (pic_time)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_album_cat (
  cat_id mediumint(8) unsigned NOT NULL auto_increment,
  cat_title varchar(255) NOT NULL,
  cat_desc text,
  cat_order mediumint(8) NOT NULL,
  cat_view_level tinyint(3) NOT NULL default '-1',
  cat_upload_level tinyint(3) NOT NULL default '0',
  cat_rate_level tinyint(3) NOT NULL default '0',
  cat_comment_level tinyint(3) NOT NULL default '0',
  cat_edit_level tinyint(3) NOT NULL default '0',
  cat_delete_level tinyint(3) NOT NULL default '2',
  cat_view_groups varchar(255) default NULL,
  cat_upload_groups varchar(255) default NULL,
  cat_rate_groups varchar(255) default NULL,
  cat_comment_groups varchar(255) default NULL,
  cat_edit_groups varchar(255) default NULL,
  cat_delete_groups varchar(255) default NULL,
  cat_moderator_groups varchar(255) default NULL,
  cat_approval tinyint(3) NOT NULL default '0',
  PRIMARY KEY (cat_id),
  KEY cat_order (cat_order)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_album_comment (
  comment_id int(11) unsigned NOT NULL auto_increment,
  comment_pic_id int(11) unsigned NOT NULL,
  comment_user_id mediumint(8) NOT NULL,
  comment_username varchar(32) default NULL,
  comment_user_ip char(8) NOT NULL,
  comment_time int(11) unsigned NOT NULL,
  comment_text text,
  comment_edit_time int(11) unsigned default NULL,
  comment_edit_count smallint(5) unsigned NOT NULL default '0',
  comment_edit_user_id mediumint(8) default NULL,
  PRIMARY KEY (comment_id),
  KEY comment_pic_id (comment_pic_id),
  KEY comment_user_id (comment_user_id),
  KEY comment_user_ip (comment_user_ip),
  KEY comment_time (comment_time)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE phpbb_album_rate (
  rate_pic_id int(11) unsigned NOT NULL,
  rate_user_id mediumint(8) NOT NULL,
  rate_user_ip char(8) NOT NULL,
  rate_point tinyint(3) unsigned NOT NULL,
  KEY rate_pic_id (rate_pic_id),
  KEY rate_user_id (rate_user_id),
  KEY rate_user_ip (rate_user_ip),
  KEY rate_point (rate_point)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE phpbb_album_config (
  config_name varchar(255) NOT NULL,
  config_value varchar(255) NOT NULL,
  PRIMARY KEY (config_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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