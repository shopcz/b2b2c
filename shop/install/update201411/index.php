<?php
/**
 *
 * ShopNC system
 *
 *
 */
// 设置最大执行时间
set_time_limit(0);
define('BYshopJL',true);
error_reporting(E_ERROR | E_WARNING | E_PARSE);
@ini_set ('memory_limit', '512M');
@set_magic_quotes_runtime(0);
$config_file = '../../../data/config/config.ini.php';
$setting_file = '../../../data/cache/setting.php';
$config = require($config_file);
$setting = require($setting_file);

$site_url = $config['admin_site_url'];
$version = $config['version'];
$dbcharset = $config['db']['master']['dbcharset'];
$dbserver = $config['db']['master']['dbhost'];
$dbserver_port = $config['db']['master']['dbport'];
$dbname = $config['db']['master']['dbname'];
$db_pre = $config['tablepre'];
$dbuser = $config['db']['master']['dbuser'];
$dbpasswd = $config['db']['master']['dbpwd'];
define('DBCHARSET',$dbcharset);
define('SiteUrl',$site_url);
if ($version != '201410078256'){
	@header("Content-type: text/html; charset=UTF-8");
	echo "已经升级完成或版本错误，本程序只适用于版本号为“201410078256”的系统。";
	exit;
}

$db = new dbstuff();
$dbcharset = 'utf8';
$dbserver = $dbserver.":".$dbserver_port;
$db->connect($dbserver, $dbuser, $dbpasswd, $dbname, $dbcharset);
$tablepre = $db_pre;
$current = $_GET['act'];

//新增表和字段
function update_db() {
	$sqlfile = 'utf8.sql';
	global $tablepre, $db,$config;
	$sql = file_get_contents($sqlfile);
	$sql = str_replace("\r\n", "\n", $sql);
	runquery($sql);
	$db->query('update '.$tablepre.'goods set is_own_shop = 1 where store_id = '.$config['default_store_id']);
	$db->query('update '.$tablepre.'goods_common set is_own_shop = 1 where store_id = '.$config['default_store_id']);
	$db->query('update '.$tablepre.'store set is_own_shop = 1 where store_id = '.$config['default_store_id']);
	$db->query('update '.$tablepre.'store set bind_all_gc = 1 where store_id = '.$config['default_store_id']);
}

//执行sql
function runquery($sql) {
	global $tablepre, $db;

	if(!isset($sql) || empty($sql)) return;

	$sql = str_replace("\r", "\n", str_replace('shopnc_', $tablepre, $sql));
	$ret = array();
	$num = 0;
	foreach(explode(";\n", trim($sql)) as $query) {
		$ret[$num] = '';
		$queries = explode("\n", trim($query));
		foreach($queries as $query) {
			$ret[$num] .= (isset($query[0]) && $query[0] == '#') || (isset($query[1]) && isset($query[1]) && $query[0].$query[1] == '--') ? '' : $query;
		}
		$num++;
	}
	unset($sql);

	foreach($ret as $key => $query) {
		$query = trim($query);
		if($query) {
			if(substr($query, 0, 12) == 'CREATE TABLE') {
				$line = explode('`',$query);
				$data_name = $line[1];
				showjsmessage('数据表'.' '.$data_name.' ... '.'建立成功',$key);
				$db->query($query);
			} elseif(substr($query, 0, 11) == 'ALTER TABLE') {
				$db->query($query);
			} else {
				$db->query($query);
			}
		}
	}
}
//JS信息
function showjsmessage($message,$n=1) {
	echo 'setTimeout("showmessage(\''.addslashes($message).' \')",'.($n*150).');';
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ShopNC【B2B2C】 - 升级程序</title>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="install.css" rel="stylesheet" type="text/css">
<meta content="ShopNC" name="Copyright" />
</head>
	<div class="header">
      <div class="layout">
        <div class="title">
          <h5>网店交流提供更新程序</h5>
          <h2>升级程序</h2>
        </div>
        <div class="version">版本: 2014.11</div>
      </div>
	</div>
	<table class="menu" align="center">
			<tr class="menu_tr">
				<td align="center" <?php if($current == '') echo 'class="current"'; ?>>升级说明</td>
				<td align="center" <?php if($current == '1') echo 'class="current"'; ?>>新增表和字段</td>
				<td align="center" <?php if($current == '3') echo 'class="current"'; ?>>升级完成</td>
			</tr>
	</table>
				<div class="main">
				<div class="text-box" id="text-box">
				<?php if ($current == ''){ ?>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本升级包仅针对原有系统版本号为“201410078256”到系统版本号为“201411158256”的升级，如果更改了表名将无法使用,不包含在原有系统上进行二次开发的用户升级功能。请在升级前提前做好备份工作，对于在原有系统进行过二次开发的客户，在升级中请注意对修改过文件的备份及调整。否则直接升级可能会导致系统不能正常运行或页面出现不正常等情况。<span style="color: #FF0000;">如因升级造成您原有二次开发功能的错误或丢失，官方不予承担任何责任及损失，请您慎重操作。
				</span><br /><br />
				建议在升级过程中暂时关闭网站。进行下面操作前请确认已经完成备份，程序将自动修改数据库，点击按钮开始执行。<br />
				设置data\cache和data\upload下的所有目录及文件为可写。<br />
				<span style="color: #FF0000;">重要说明：</span><br />
			  <div>
			  	1、&nbsp;&nbsp;由于即时通讯（IM）连接规则发生变化，如果已经启用，要先升级服务器端程序，否则会出现错误。<br />
			  	2、&nbsp;&nbsp;原店铺中的线下团功能将停用（所有线下团活动及订单都会被删除）。<br />
			  	3、&nbsp;&nbsp;原后台手机端中的首页设置功能将停用（所有首页设置数据都会被删除，首页要重新编辑）。<br />
			  	4、&nbsp;&nbsp;计划任务要重新配置（具体内容可参考PDF安装手册）。<br />
			  	5、&nbsp;&nbsp;PHP扩展要重新配置（新程序要用新的“shopnc.so”文件才能运行）。<br />
			  	6、&nbsp;&nbsp;如果启用了队列和全文搜索功能，可参考PDF安装手册修改。<br />
			  	7、&nbsp;&nbsp;自提点的入口地址需要手动修改，data/config/config.ini.php文件中的$config['delivery_site_url']变量（提示“升级完成”后根据实际环境修改）。<br />

			  	<br /><br />
			  </div>
				<div class="btnbox marginbot">
					<form method="get" action="index.php">
					<input type="hidden" name="act" value="1">
					<input type="hidden" name="go" value="3">
					<input type="submit" value="确认升级" style="padding: 2px">
					</form>
				</div>
			  <?php } elseif($current == '1') { ?>
			  <div class="btnbox"><textarea name="notice" class="shop-tex"  readonly="readonly" id="notice"></textarea></div>
					<script type="text/javascript">
					function showmessage(message) {
						document.getElementById('notice').value += message + "\r\n";
					}
					<?php update_db();?>
					</script>
			  <?php } else {
			    $config_contents = @file_get_contents($config_file);
			  	@file_put_contents('../../../data/config/config.ini-201410bak.php', $config_contents);//备份原配置文件

			  	$config_contents = str_replace('return $config;','', $config_contents);
			  	$config_contents = str_replace('201410078256','201411158256', $config_contents);
			  	$config_contents .= "\r\n";
			  	$config_contents .= "\$config['cache_open'] = false;";
			  	$config_contents .= "\r\n";
			  	$config_contents .= "\$config['delivery_site_url']    = '===url===/delivery';";
			  	;
			  	$config_contents .= "\r\n";
			  	$config_contents .= 'return $config;';

			  	@file_put_contents($config_file, $config_contents);
			  	@unlink($setting_file);
			  	?>
			  升级完成，进入<a href="<?php echo SiteUrl;?>" target="_blank">系统后台</a>更新缓存后即可使用。
			  <?php } ?>
				</div>
				</div>
<div class="footer">
  <h5>Powered by <font class="blue">Shop</font><font class="orange">JL</font></h5>
  <h6>版权所有 2007-2014 &copy; <a href="http://www.shopnc.net" target="_blank">网店交流技术交流中心</a></h6>
  <h6>软件注册登记编号：软著登字第0650314号</h6>
</div>
<script type="text/javascript">
<?php if ($_GET['go'] == '3'){ ?>
	window.setTimeout("javascript:location.href='index.php?act=3'", 2900);
<?php } ?>
</script>
</body>
</html>
<?php
//---------------------数据库操作类
class dbstuff {
	var $querynum = 0;
	var $link;
	var $histories;
	var $time;
	var $tablepre;

	function connect($dbhost, $dbuser, $dbpw, $dbname = '', $dbcharset, $pconnect = 0, $tablepre='', $time = 0) {
		$this->time = $time;
		$this->tablepre = $tablepre;
		if($pconnect) {
			if(!$this->link = mysql_pconnect($dbhost, $dbuser, $dbpw)) {
				$this->halt('Can not connect to MySQL server');
			}
		} else {
			if(!$this->link = mysql_connect($dbhost, $dbuser, $dbpw, 1)) {
				$this->halt('Can not connect to MySQL server');
			}
		}

		if($this->version() > '4.1') {
			if($dbcharset) {
				mysql_query("SET character_set_connection=".$dbcharset.", character_set_results=".$dbcharset.", character_set_client=binary", $this->link);
			}

			if($this->version() > '5.0.1') {
				mysql_query("SET sql_mode=''", $this->link);
			}
		}

		if($dbname) {
			mysql_select_db($dbname, $this->link);
		}

	}

	function fetch_array($query, $result_type = MYSQL_ASSOC) {
		return mysql_fetch_array($query, $result_type);
	}

	function result_first($sql, &$data) {
		$query = $this->query($sql);
		$data = $this->result($query, 0);
	}

	function fetch_first($sql, &$arr) {
		$query = $this->query($sql);
		$arr = $this->fetch_array($query);
	}

	function fetch_all($sql, &$arr) {
		$query = $this->query($sql);
		while($data = $this->fetch_array($query)) {
			$arr[] = $data;
		}
	}

	function query($sql, $type = '', $cachetime = FALSE) {
		$func = $type == 'UNBUFFERED' && @function_exists('mysql_unbuffered_query') ? 'mysql_unbuffered_query' : 'mysql_query';
		if(!($query = $func($sql, $this->link)) && $type != 'SILENT') {
			$this->halt('MySQL Query Error', $sql);
		}
		$this->querynum++;
		$this->histories[] = $sql;
		return $query;
	}

	function affected_rows() {
		return mysql_affected_rows($this->link);
	}

	function error() {
		return (($this->link) ? mysql_error($this->link) : mysql_error());
	}

	function errno() {
		return intval(($this->link) ? mysql_errno($this->link) : mysql_errno());
	}

	function result($query, $row) {
		$query = @mysql_result($query, $row);
		return $query;
	}

	function num_rows($query) {
		$query = mysql_num_rows($query);
		return $query;
	}

	function num_fields($query) {
		return mysql_num_fields($query);
	}

	function free_result($query) {
		return mysql_free_result($query);
	}

	function insert_id() {
		return ($id = mysql_insert_id($this->link)) >= 0 ? $id : $this->result($this->query("SELECT last_insert_id()"), 0);
	}

	function fetch_row($query) {
		$query = mysql_fetch_row($query);
		return $query;
	}

	function fetch_fields($query) {
		return mysql_fetch_field($query);
	}

	function version() {
		return mysql_get_server_info($this->link);
	}

	function close() {
		return mysql_close($this->link);
	}

	function halt($message = '', $sql = '') {
		//		echo mysql_error();echo "<br />";
	}
}
//----------------------数据库操作类 end
?>
