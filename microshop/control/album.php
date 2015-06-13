<?php
/**
 * 默认展示页面
 *
 *
 *
 *By ShopNC开发修正
 */
defined('BYshopJL') or exit('Access Invalid!');
class albumControl extends MircroShopControl{

	public function __construct() {
		parent::__construct();
        Tpl::output('index_sign','album');
    }

	//首页
	public function indexOp(){
		Tpl::showpage('album');
	}
}
