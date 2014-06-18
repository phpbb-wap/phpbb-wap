<?php
/**
* @package phpBB-WAP
* @copyright (c) phpBB Group
* @Оптимизация под WAP: Гутник Игорь ( чел ).
* @简体中文：中文phpBB-WAP团队
* @license http://opensource.org/licenses/gpl-license.php
**/

/**
* 这是一款自由软件, 您可以在 Free Software Foundation 发布的
* GNU General Public License 的条款下重新发布或修改; 您可以
* 选择目前 version 2 这个版本（亦可以选择任何更新的版本，由
* 你喜欢）作为新的牌照.
**/
	
if ( !defined('IN_PHPBB') )
{
	die('Hacking attempt');
}

define("BBCODE_UID_LEN", 10);//bbcode_uid长度
$bbcode_tpl = null;

/*
* 加载模版模版内的BBCode
*/
function load_bbcode_template()
{
	global $template;
	
	$tpl_filename = $template->make_filename('bbcode.tpl');
	
	$tpl = fread(fopen($tpl_filename, 'r'), filesize($tpl_filename));
	$tpl = str_replace('\\', '\\\\', $tpl);
	$tpl  = str_replace('\'', '\\\'', $tpl);
	$tpl  = str_replace("\n", '', $tpl);
	$tpl = preg_replace('#<!-- BEGIN (.*?) -->(.*?)<!-- END (.*?) -->#', "\n" . '$bbcode_tpls[\'\\1\'] = \'\\2\';', $tpl);

	$bbcode_tpls = array();
	
	eval($tpl);
	
	return $bbcode_tpls;
}

/*
* 对模版里面的替换字符进行替换
*/
function prepare_bbcode_template($bbcode_tpl)
{
	
	$bbcode_tpl['olist_open'] 			= str_replace('{LIST_TYPE}', '\\1', $bbcode_tpl['olist_open']);
	$bbcode_tpl['color_open'] 			= str_replace('{COLOR}', '\\1', $bbcode_tpl['color_open']);
	$bbcode_tpl['size_open'] 			= str_replace('{SIZE}', '\\1', $bbcode_tpl['size_open']);
	$bbcode_tpl['quote_open'] 			= str_replace('{L_QUOTE}', '引用：', $bbcode_tpl['quote_open']);
	$bbcode_tpl['quote_username_open'] 	= str_replace('{L_QUOTE}', '引用：', $bbcode_tpl['quote_username_open']);
	$bbcode_tpl['quote_username_open'] 	= str_replace('{L_WROTE}', '写到：', $bbcode_tpl['quote_username_open']);
	$bbcode_tpl['quote_username_open'] 	= str_replace('{USERNAME}', '\\1', $bbcode_tpl['quote_username_open']);
	$bbcode_tpl['code_open'] 			= str_replace('{L_CODE}', '', $bbcode_tpl['code_open']);
	$bbcode_tpl['img'] 					= str_replace('{URL}', '\\1', $bbcode_tpl['img']);
	$bbcode_tpl['url1'] 				= str_replace('{URL}', '\\1', $bbcode_tpl['url']);
	$bbcode_tpl['url1'] 				= str_replace('{DESCRIPTION}', '\\1', $bbcode_tpl['url1']);
	$bbcode_tpl['url2'] 				= str_replace('{URL}', 'http://\\1', $bbcode_tpl['url']);
	$bbcode_tpl['url2'] 				= str_replace('{DESCRIPTION}', '\\1', $bbcode_tpl['url2']);
	$bbcode_tpl['url3'] 				= str_replace('{URL}', '\\1', $bbcode_tpl['url']);
	$bbcode_tpl['url3'] 				= str_replace('{DESCRIPTION}', '\\2', $bbcode_tpl['url3']);
	$bbcode_tpl['url4'] 				= str_replace('{URL}', 'http://\\1', $bbcode_tpl['url']);
	$bbcode_tpl['url4'] 				= str_replace('{DESCRIPTION}', '\\3', $bbcode_tpl['url4']);
	$bbcode_tpl['email'] 				= str_replace('{EMAIL}', '\\1', $bbcode_tpl['email']);
	$bbcode_tpl['flash_width'] 			= str_replace('{WIDTH}', '\\1', $bbcode_tpl['flash']);
	$bbcode_tpl['flash_height'] 		= str_replace('{HEIGHT}', '\\2', $bbcode_tpl['flash_width']);
	$bbcode_tpl['flash'] 				= str_replace('{URL}', '\\3', $bbcode_tpl['flash_height']);
	$bbcode_tpl['mp3'] 					= str_replace('{URL}', '\\1', $bbcode_tpl['mp3']);

	define("BBCODE_TPL_READY", true);

	// 这里得出的不是BBcode的效果，这是内部处理结果
	return $bbcode_tpl;
}

function bbencode_second_pass($text, $uid)
{
	global $bbcode_tpl, $userdata, $_SERVER;

	$text = preg_replace('#(script|about|applet|activex|chrome):#is', "\\1&#058;", $text);
	$text = " " . $text;

	if ( !(strpos($text, "[") && strpos($text, "]")) )
	{
		$text = substr($text, 1);
		return $text;
	}

	if (!defined("BBCODE_TPL_READY"))
	{
		$bbcode_tpl = load_bbcode_template();
		$bbcode_tpl = prepare_bbcode_template($bbcode_tpl);
	}

	$text = bbencode_second_pass_code($text, $uid, $bbcode_tpl);
	
	$text = str_replace("[quote:$uid]", $bbcode_tpl['quote_open'], $text);
	$text = str_replace("[/quote:$uid]", $bbcode_tpl['quote_close'], $text);
	$text = preg_replace("/\[quote:$uid=\"(.*?)\"\]/si", $bbcode_tpl['quote_username_open'], $text);
	
	$text = str_replace("[list:$uid]", $bbcode_tpl['ulist_open'], $text);
	$text = str_replace("[*:$uid]", $bbcode_tpl['listitem'], $text);
	$text = str_replace("[/list:u:$uid]", $bbcode_tpl['ulist_close'], $text);
	$text = str_replace("[/list:o:$uid]", $bbcode_tpl['olist_close'], $text);
	$text = preg_replace("/\[list=([a1]):$uid\]/si", $bbcode_tpl['olist_open'], $text);
	$text = preg_replace("/\[color=(\#[0-9A-F]{6}|[a-z]+):$uid\]/si", $bbcode_tpl['color_open'], $text);
	$text = str_replace('<span style="color: transparent">', '<span style="color: white">', $text);
	$text = str_replace("[/color:$uid]", $bbcode_tpl['color_close'], $text);
	$text = preg_replace("/\[size=([1-2]?[0-9]):$uid\]/si", $bbcode_tpl['size_open'], $text);
	$text = str_replace("[/size:$uid]", $bbcode_tpl['size_close'], $text);
	$text = str_replace("[b:$uid]", $bbcode_tpl['b_open'], $text);
	$text = str_replace("[/b:$uid]", $bbcode_tpl['b_close'], $text);
	$text = str_replace("[u:$uid]", $bbcode_tpl['u_open'], $text);
	$text = str_replace("[/u:$uid]", $bbcode_tpl['u_close'], $text);
	$text = str_replace("[i:$uid]", $bbcode_tpl['i_open'], $text);
	$text = str_replace("[/i:$uid]", $bbcode_tpl['i_close'], $text);

	$patterns = array();
	$replacements = array();

	$patterns[] = "#\[img:$uid\]([^?](?:[^\[]+|\[(?!url))*?)\[/img:$uid\]#i";
	$replacements[] = $bbcode_tpl['img'];

	$patterns[] = "#\[url\]([\w]+?://[^[:space:]]*?)\[/url\]#is";
	$replacements[] = $bbcode_tpl['url1'];
	$patterns[] = "#\[url\]((www|ftp)\.[^[:space:]]*?)\[/url\]#is";
	$replacements[] = $bbcode_tpl['url2'];
	$patterns[] = "#\[url=([\w]+?://[^[:space:]]*?)\]([^?\n\r\t].*?)\[/url\]#is";
	$replacements[] = $bbcode_tpl['url3'];
	$patterns[] = "#\[url=((www|ftp)\.[^[:space:]]*?)\]([^?\n\r\t].*?)\[/url\]#is";
	$replacements[] = $bbcode_tpl['url4'];
	
	$patterns[] = "#\[flash=([0-9]+),([0-9]+)\](.*?)\[/flash\]#is";
	$replacements[] = $bbcode_tpl['flash'];

	$patterns[] = "#\[mp3\](.*?)\[/mp3\]#is";
	$replacements[] = $bbcode_tpl['mp3'];
	
	$patterns[] = "#\[email\]([a-z0-9&\-_.]+?@[\w\-]+\.([\w\-\.]+\.)?[\w]+)\[/email\]#si";
	$replacements[] = $bbcode_tpl['email'];
	
	$text = preg_replace($patterns, $replacements, $text);
	
	$text = substr($text, 1);

	return $text;

}

/*
* 生成BBCode中使用的UID
*/
function make_bbcode_uid()
{
	$uid = dss_rand();
	$uid = substr($uid, 0, BBCODE_UID_LEN);

	return $uid;
}

function bbencode_first_pass($text, $uid)
{
	$text = " " . $text;
	$text = bbencode_first_pass_pda($text, $uid, '[code]', '[/code]', '', true, '');
	$text = bbencode_first_pass_pda($text, $uid, '[quote]', '[/quote]', '', false, '');
	$text = bbencode_first_pass_pda($text, $uid, '/\[quote=\\\\&quot;(.*?)\\\\&quot;\]/is', '[/quote]', '', false, '', "[quote:$uid=\\\"\\1\\\"]");

	$open_tag = array();
	$open_tag[0] = "[list]";

	$text = bbencode_first_pass_pda($text, $uid, $open_tag, "[/list]", "[/list:u]", false, 'replace_listitems');

	$open_tag[0] = "[list=1]";
	$open_tag[1] = "[list=a]";

	$text = bbencode_first_pass_pda($text, $uid, $open_tag, "[/list]", "[/list:o]",  false, 'replace_listitems');
	$text = preg_replace("#\[color=(\#[0-9A-F]{6}|[a-z\-]+)\](.*?)\[/color\]#si", "[color=\\1:$uid]\\2[/color:$uid]", $text);
	$text = preg_replace("#\[size=([1-2]?[0-9])\](.*?)\[/size\]#si", "[size=\\1:$uid]\\2[/size:$uid]", $text);
	$text = preg_replace("#\[b\](.*?)\[/b\]#si", "[b:$uid]\\1[/b:$uid]", $text);
	$text = preg_replace("#\[u\](.*?)\[/u\]#si", "[u:$uid]\\1[/u:$uid]", $text);
	$text = preg_replace("#\[i\](.*?)\[/i\]#si", "[i:$uid]\\1[/i:$uid]", $text);
	$text = preg_replace("#\[img\]((http|ftp|https|ftps)://)([^ \?&=\#\"\n\r\t<]*?(\.(jpg|jpeg|gif|png)))\[/img\]#sie", "'[img:$uid]\\1' . str_replace(' ', '%20', '\\3') . '[/img:$uid]'", $text);

	return substr($text, 1);;

}

function bbencode_first_pass_pda($text, $uid, $open_tag, $close_tag, $close_tag_new, $mark_lowest_level, $func, $open_regexp_replace = false)
{
	$open_tag_count = 0;

	if (!$close_tag_new || ($close_tag_new == ''))
	{
		$close_tag_new = $close_tag;
	}

	$close_tag_length = strlen($close_tag);
	$close_tag_new_length = strlen($close_tag_new);
	$uid_length = strlen($uid);

	$use_function_pointer = ($func && ($func != ''));

	$stack = array();

	if (is_array($open_tag))
	{
		if (0 == count($open_tag))
		{
			return $text;
		}
		$open_tag_count = count($open_tag);
	}
	else
	{
		$open_tag_temp = $open_tag;
		$open_tag = array();
		$open_tag[0] = $open_tag_temp;
		$open_tag_count = 1;
	}

	$open_is_regexp = false;

	if ($open_regexp_replace)
	{
		$open_is_regexp = true;
		if (!is_array($open_regexp_replace))
		{
			$open_regexp_temp = $open_regexp_replace;
			$open_regexp_replace = array();
			$open_regexp_replace[0] = $open_regexp_temp;
		}
	}

	if ($mark_lowest_level && $open_is_regexp)
	{
		trigger_error('Unsupported operation for bbcode_first_pass_pda().', E_USER_ERROR);
	}

	$curr_pos = 1;
	while ($curr_pos && ($curr_pos < strlen($text)))
	{
		$curr_pos = strpos($text, "[", $curr_pos);

		if ($curr_pos)
		{
			$found_start = false;
			$which_start_tag = "";
			$start_tag_index = -1;

			for ($i = 0; $i < $open_tag_count; $i++)
			{
				$possible_start = substr($text, $curr_pos, strpos($text, ']', $curr_pos + 1) - $curr_pos + 1);

				if( preg_match('#\[quote=\\\&quot;#si', $possible_start, $match) && !preg_match('#\[quote=\\\&quot;(.*?)\\\&quot;\]#si', $possible_start) )
				{
					if ($close_pos = strpos($text, '&quot;]', $curr_pos + 14))
					{
						if (strpos(substr($text, $curr_pos + 14, $close_pos - ($curr_pos + 14)), '[quote') === false)
						{
							$possible_start = substr($text, $curr_pos, $close_pos - $curr_pos + 7);
						}
					}
				}

				if ($open_is_regexp)
				{
					$match_result = array();
					if (preg_match($open_tag[$i], $possible_start, $match_result))
					{
						$found_start = true;
						$which_start_tag = $match_result[0];
						$start_tag_index = $i;
						break;
					}
				}
				else
				{
					if (0 == strcasecmp($open_tag[$i], $possible_start))
					{
						$found_start = true;
						$which_start_tag = $open_tag[$i];
						$start_tag_index = $i;
						break;
					}
				}
			}

			if ($found_start)
			{
				$match = array("pos" => $curr_pos, "tag" => $which_start_tag, "index" => $start_tag_index);
				array_push($stack, $match);
				$curr_pos += strlen($possible_start);
			}
			else
			{
				$possible_end = substr($text, $curr_pos, $close_tag_length);
				if (0 == strcasecmp($close_tag, $possible_end))
				{
					if (count($stack) > 0)
					{
						$curr_nesting_depth = count($stack);
						$match = array_pop($stack);
						$start_index = $match['pos'];
						$start_tag = $match['tag'];
						$start_length = strlen($start_tag);
						$start_tag_index = $match['index'];

						if ($open_is_regexp)
						{
							$start_tag = preg_replace($open_tag[$start_tag_index], $open_regexp_replace[$start_tag_index], $start_tag);
						}

						$before_start_tag = substr($text, 0, $start_index);
						$between_tags = substr($text, $start_index + $start_length, $curr_pos - $start_index - $start_length);

						if ($use_function_pointer)
						{
							$between_tags = $func($between_tags, $uid);
						}

						$after_end_tag = substr($text, $curr_pos + $close_tag_length);

						if ($mark_lowest_level && ($curr_nesting_depth == 1))
						{
							if ($open_tag[0] == '[code]')
							{
								$code_entities_match = array('#<#', '#>#', '#"#', '#:#', '#\[#', '#\]#', '#\(#', '#\)#', '#\{#', '#\}#');
								$code_entities_replace = array('&lt;', '&gt;', '&quot;', '&#58;', '&#91;', '&#93;', '&#40;', '&#41;', '&#123;', '&#125;');
								$between_tags = preg_replace($code_entities_match, $code_entities_replace, $between_tags);
							}
							$text = $before_start_tag . substr($start_tag, 0, $start_length - 1) . ":$curr_nesting_depth:$uid]";
							$text .= $between_tags . substr($close_tag_new, 0, $close_tag_new_length - 1) . ":$curr_nesting_depth:$uid]";
						}
						else
						{
							if ($open_tag[0] == '[code]')
							{
								$text = $before_start_tag . '&#91;code&#93;';
								$text .= $between_tags . '&#91;/code&#93;';
							}
							else
							{
								if ($open_is_regexp)
								{
									$text = $before_start_tag . $start_tag;
								}
								else
								{
									$text = $before_start_tag . substr($start_tag, 0, $start_length - 1) . ":$uid]";
								}
								$text .= $between_tags . substr($close_tag_new, 0, $close_tag_new_length - 1) . ":$uid]";
							}
						}

						$text .= $after_end_tag;

						if (count($stack) > 0)
						{
							$match = array_pop($stack);
							$curr_pos = $match['pos'];
						}
						else
						{
							$curr_pos = 1;
						}
					}
					else
					{
						++$curr_pos;
					}
				}
				else
				{
					++$curr_pos;
				}
			}
		}
	}

	return $text;

}
function bbencode_second_pass_code($text, $uid, $bbcode_tpl)
{

	$code_start_html = $bbcode_tpl['code_open'];
	$code_end_html =  $bbcode_tpl['code_close'];
	$match_count = preg_match_all("#\[code:1:$uid\](.*?)\[/code:1:$uid\]#si", $text, $matches);

	for ($i = 0; $i < $match_count; $i++)
	{
		$before_replace = $matches[1][$i];
		$after_replace = $matches[1][$i];
		$after_replace = str_replace("  ", "&nbsp; ", $after_replace);
		$after_replace = str_replace("  ", " &nbsp;", $after_replace);
		$after_replace = str_replace("\t", "&nbsp; &nbsp;", $after_replace);
		$after_replace = preg_replace("/^ {1}/m", '&nbsp;', $after_replace);

		$str_to_match = "[code:1:$uid]" . $before_replace . "[/code:1:$uid]";

		$replacement = $code_start_html;
		$replacement .= $after_replace;
		$replacement .= $code_end_html;

		$text = str_replace($str_to_match, $replacement, $text);
	}

	$text = str_replace("[code:$uid]", $code_start_html, $text);
	$text = str_replace("[/code:$uid]", $code_end_html, $text);

	return $text;

}

function make_clickable($text)
{
	$text = preg_replace('#(script|about|applet|activex|chrome):#is', "\\1&#058;", $text);

	$ret = ' ' . $text;
	$ret = preg_replace("#(^|[\n ])([\w]+?://[^[:space:]]*)#is", "\\1<a href=\"\\2\" target=\"_blank\">\\2</a>", $ret);
	$ret = preg_replace("#(^|[\n ])((www|ftp)\.[^[:space:]]*)#is", "\\1<a href=\"http://\\2\" target=\"_blank\">\\2</a>", $ret);
	$ret = preg_replace("#(^|[\n ])([a-z0-9&\-_.]+?)@([\w\-]+\.([\w\-\.]+\.)*[\w]+)#i", "\\1<a href=\"mailto:\\2@\\3\">\\2@\\3</a>", $ret);
	$ret = substr($ret, 1);

	return($ret);
}

function replace_listitems($text, $uid)
{
	$text = str_replace("[*]", "[*:$uid]", $text);

	return $text;
}

/*
* 对表情代码进行解析
*/
function smilies_pass($message)
{
	static $orig, $repl;
	global $board_config, $db;

	if (!isset($orig))
	{	
		$orig = $repl = array();

		$sql = 'SELECT * FROM ' . SMILIES_TABLE;
		if( !$result = $db->sql_query($sql) )
		{
			trigger_error('Couldn\'t obtain smilies data', E_USER_WARNING);
		}
		$smilies = $db->sql_fetchrowset($result);

		if (count($smilies))
		{
			usort($smilies, 'smiley_sort');
		}

		$count_smilies = count($smilies);

		for ($i = 0; $i < $count_smilies; $i++)
		{
			// 设置匹配表情的正则表达式($orig)与替换后的img标签($repl)
            //$orig[] = "/(?<=.\W|\W.|^\W)" . preg_quote($smilies[$i]['code'], "/") . "(?=.\W|\W.|\W$)/";
            $orig[] = "/(?=.*)" . preg_quote($smilies[$i]['code'], "/") . "(?=.*$)/";
			//$orig[] = $smilies[$i]['code'];
          	//  $orig[] = "/(?=.*?)" . preg_quote($smilies[$i]['code'], "/") . "(?=.*?$)/";
			$repl[] = '<img src="' . ROOT_PATH . $board_config['smilies_path'] . '/' . $smilies[$i]['smile_url'] . '" alt="' . $smilies[$i]['emoticon'] . '" border="0" />';
		}
	}

	if (count($orig))
	{
		$max_smiles = abs(intval($board_config['max_smiles_in_message']));
		$message = preg_replace($orig, $repl, ' ' . $message . ' ', $max_smiles);
		//$message = str_replace($orig, $repl, $message);
	}
	
	return $message;
}

function smiley_sort($a, $b)
{
	if ( strlen($a['code']) == strlen($b['code']) )
	{
		return 0;
	}

	return ( strlen($a['code']) > strlen($b['code']) ) ? -1 : 1;
}

?>