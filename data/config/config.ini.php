<?php
// defined('BYshopJL') or exit('Access Invalid!');

$config = array();
$config['shop_site_url'] 		= 'http://wx.ffblog.in/shop';
$config['cms_site_url'] 		= 'http://wx.ffblog.in/cms';
$config['microshop_site_url'] 	= 'http://wx.ffblog.in/microshop';
$config['circle_site_url'] 		= 'http://wx.ffblog.in/circle';
$config['admin_site_url'] 		= 'http://wx.ffblog.in/admin';
$config['mobile_site_url'] 		= 'http://wx.ffblog.in/mobile';
$config['wap_site_url'] 		= 'http://wx.ffblog.in/wap';
$config['chat_site_url'] 		= 'http://wx.ffblog.in/chat';
$config['node_site_url'] 		= 'http://127.0.0.1:8090';
$config['upload_site_url']		= 'http://wx.ffblog.in/data/upload';
$config['resource_site_url']	= 'http://wx.ffblog.in/data/resource';
$config['version'] 		= '201411158256';
$config['setup_date'] 	= '2015-04-17 12:13:26';
$config['gip'] 			= 0;
$config['dbdriver'] 	= 'pdo_mysql';
$config['tablepre']		= 'shopnc_';
$config['db']['1']['dbhost']       = 'localhost';
$config['db']['1']['dbport']       = '3306';
$config['db']['1']['dbuser']       = 'root';
$config['db']['1']['dbpwd']        = 'root';
$config['db']['1']['dbname']       = 'shopnc';
$config['db']['1']['dbcharset']    = 'UTF-8';
$config['db']['slave']                  = $config['db']['master'];
$config['session_expire'] 	= 3600;
$config['lang_type'] 		= 'zh_cn';
$config['cookie_pre'] 		= '214A_';
$config['thumb']['cut_type'] = 'gd';
$config['thumb']['impath'] = '';
$config['cache']['type'] 			= 'file';

// $config['eaccelerator']['prefix']      	= 'nc_';
// $config['eaccelerator'][1]['port']     	= 11211;
// $config['eaccelerator'][1]['host']     	= '127.0.0.1';
// $config['eaccelerator'][1]['pconnect'] 	= 0;
// $config['session_type'] = 'redis';
// $config['session_save_path'] = 'tcp://127.0.0.1:6379';
// $config['redis']['prefix']      	= 'nc_';
// $config['redis']['master']['port']     	= 6379;
// $config['redis']['master']['host']     	= '127.0.0.1';
// $config['redis']['master']['pconnect'] 	= 0;
// $config['redis']['slave']      	    = array();
// $config['fullindexer']['open']      = true;
// $config['fullindexer']['appname']   = 'shopnc';

// $config['memcache']['prefix']      	= 'nc_';
// $config['memcache'][1]['port']     	= 11211;
// $config['memcache'][1]['host']     	= '127.0.0.1';
// $config['memcache'][1]['pconnect'] 	= 0;

$config['debug'] 			= false;
$config['default_store_id'] = '1';
$config['url_model'] = false;
$config['subdomain_suffix'] = '';

$config['node_chat'] = true;
//流量记录表数量，为1~10之间的数字，默认为3，数字设置完成后请不要轻易修改，否则可能造成流量统计功能数据错误
$config['flowstat_tablenum'] = 3;
$config['sms']['gwUrl'] = 'http://sdkhttp.eucp.b2m.cn/sdk/SDKService';
$config['sms']['serialNumber'] = '';
$config['sms']['password'] = '';
$config['sms']['sessionKey'] = '';
$config['queue']['open'] = false;
$config['queue']['host'] = '127.0.0.1';
$config['queue']['port'] = 6379;
$config['cache_open'] = false;
$config['delivery_site_url']    = 'http://wx.ffblog.in/delivery';
return $config;