CREATE TABLE `shopjl_delivery_order` (
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `addtime` int(11) default '0' COMMENT '订单生成时间',
  `order_sn` bigint(20) default NULL COMMENT '订单号',
  `dlyp_id` int(11) default NULL COMMENT '自提点ID',
  `shipping_code` varchar(50) default NULL COMMENT '物流单号',
  `express_code` varchar(30) default NULL COMMENT '快递公司编码',
  `express_name` varchar(30) default NULL COMMENT '快递公司名称',
  `reciver_name` varchar(20) default NULL COMMENT '收货人',
  `reciver_telphone` varchar(20) default NULL COMMENT '电话',
  `reciver_mobphone` varchar(11) default NULL COMMENT '手机',
  `dlyo_state` tinyint(3) unsigned NOT NULL default '10' COMMENT '订单状态 10(默认)未到站，20已到站，30已提取',
  `dlyo_pickup_code` varchar(4) default NULL COMMENT '提货码',
  PRIMARY KEY  (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单自提点表';

CREATE TABLE `shopjl_delivery_point` (
  `dlyp_id` int(10) unsigned NOT NULL auto_increment COMMENT '提货站id',
  `dlyp_name` varchar(50) NOT NULL COMMENT '提货站登录名',
  `dlyp_passwd` varchar(32) NOT NULL COMMENT '提货站登录密码',
  `dlyp_truename` varchar(20) NOT NULL COMMENT '真实姓名',
  `dlyp_mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `dlyp_telephony` varchar(20) NOT NULL COMMENT '座机号码',
  `dlyp_address_name` varchar(20) NOT NULL COMMENT '服务站名称',
  `dlyp_area_2` int(10) unsigned NOT NULL COMMENT '二级地区id',
  `dlyp_area_3` int(10) unsigned NOT NULL COMMENT '三级地区id',
  `dlyp_area_info` varchar(255) NOT NULL COMMENT '地区内容',
  `dlyp_address` varchar(255) NOT NULL COMMENT '详细地址',
  `dlyp_idcard` varchar(18) NOT NULL COMMENT '身份证号码',
  `dlyp_idcard_image` varchar(255) NOT NULL COMMENT '身份证照片',
  `dlyp_addtime` int(10) unsigned NOT NULL COMMENT '添加时间',
  `dlyp_state` tinyint(3) unsigned NOT NULL COMMENT '提货站状态 0关闭，1开启，10等待审核, 20审核失败',
  `dlyp_fail_reason` varchar(255) default NULL COMMENT '失败原因',
  PRIMARY KEY  (`dlyp_id`),
  UNIQUE KEY `dlyp_name` (`dlyp_name`),
  UNIQUE KEY `dlyp_idcard` (`dlyp_idcard`),
  UNIQUE KEY `dlyp_mobile` (`dlyp_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提货站表';

CREATE TABLE `shopjl_exppoints_log` (
  `exp_id` int(11) NOT NULL auto_increment COMMENT '经验值日志编号',
  `exp_memberid` int(11) NOT NULL COMMENT '会员编号',
  `exp_membername` varchar(100) NOT NULL COMMENT '会员名称',
  `exp_points` int(11) NOT NULL default '0' COMMENT '经验值负数表示扣除',
  `exp_addtime` int(11) NOT NULL COMMENT '添加时间',
  `exp_desc` varchar(100) NOT NULL COMMENT '操作描述',
  `exp_stage` varchar(50) NOT NULL COMMENT '操作阶段',
  PRIMARY KEY  (`exp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='经验值日志表';

CREATE TABLE `shopjl_goods_combo` (
  `combo_id` int(10) unsigned NOT NULL auto_increment COMMENT '推荐组合id ',
  `goods_id` int(10) unsigned NOT NULL COMMENT '主商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '主商品公共id',
  `combo_goodsid` int(10) unsigned NOT NULL COMMENT '推荐组合商品id',
  PRIMARY KEY  (`combo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品推荐组合表';

CREATE TABLE `shopjl_goods_fcode` (
  `fc_id` int(10) unsigned NOT NULL auto_increment COMMENT 'F码id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '商品公共id',
  `fc_code` varchar(20) NOT NULL COMMENT 'F码',
  `fc_state` tinyint(3) unsigned NOT NULL default '0' COMMENT '状态 0未使用，1已使用',
  PRIMARY KEY  (`fc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品F码';

CREATE TABLE `shopjl_goods_gift` (
  `gift_id` int(10) unsigned NOT NULL auto_increment COMMENT '赠品id ',
  `goods_id` int(10) unsigned NOT NULL COMMENT '主商品id',
  `goods_commonid` int(10) unsigned NOT NULL COMMENT '主商品公共id',
  `gift_goodsid` int(10) unsigned NOT NULL COMMENT '赠品商品id ',
  `gift_goodsname` varchar(50) NOT NULL COMMENT '主商品名称',
  `gift_goodsimage` varchar(100) NOT NULL COMMENT '主商品图片',
  `gift_amount` tinyint(3) unsigned NOT NULL COMMENT '赠品数量',
  PRIMARY KEY  (`gift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品赠品表';

CREATE TABLE `shopjl_mb_payment` (
  `payment_id` tinyint(1) unsigned NOT NULL COMMENT '支付索引id',
  `payment_code` char(10) NOT NULL COMMENT '支付代码名称',
  `payment_name` char(10) NOT NULL COMMENT '支付名称',
  `payment_config` varchar(255) default NULL COMMENT '支付接口配置信息',
  `payment_state` enum('0','1') NOT NULL default '0' COMMENT '接口状态0禁用1启用',
  PRIMARY KEY  (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机支付方式表';

CREATE TABLE `shopjl_mb_special` (
  `special_id` int(10) unsigned NOT NULL auto_increment COMMENT '专题编号',
  `special_desc` varchar(20) NOT NULL COMMENT '专题描述',
  PRIMARY KEY  (`special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专题表';

CREATE TABLE `shopjl_mb_special_item` (
  `item_id` int(10) unsigned NOT NULL auto_increment COMMENT '专题项目编号',
  `special_id` int(10) unsigned NOT NULL COMMENT '专题编号',
  `item_type` varchar(50) NOT NULL COMMENT '项目类型',
  `item_data` varchar(2000) NOT NULL COMMENT '项目内容',
  `item_usable` tinyint(3) unsigned NOT NULL default '0' COMMENT '项目是否可用 0-不可用 1-可用',
  `item_sort` tinyint(3) unsigned NOT NULL default '0' COMMENT '项目排序',
  PRIMARY KEY  (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机专题项目表';

CREATE TABLE `shopjl_rcb_log` (
  `id` int(11) NOT NULL auto_increment COMMENT '自增编号',
  `member_id` int(11) NOT NULL COMMENT '会员编号',
  `member_name` varchar(50) NOT NULL COMMENT '会员名称',
  `type` varchar(15) NOT NULL default '' COMMENT 'order_pay下单使用 order_freeze下单冻结 order_cancel取消订单解冻 order_comb_pay下单扣除被冻结 recharge平台充值卡充值 refund确认退款 vr_refund虚拟兑码退款',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `available_amount` decimal(10,2) NOT NULL default '0.00' COMMENT '可用充值卡余额变更 0表示未变更',
  `freeze_amount` decimal(10,2) NOT NULL default '0.00' COMMENT '冻结充值卡余额变更 0表示未变更',
  `description` varchar(150) default NULL COMMENT '描述',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值卡余额变更日志表';

CREATE TABLE `shopjl_rechargecard` (
  `id` int(11) NOT NULL auto_increment COMMENT '自增ID',
  `sn` varchar(50) NOT NULL COMMENT '卡号',
  `denomination` decimal(10,2) NOT NULL COMMENT '面额',
  `batchflag` varchar(20) NOT NULL COMMENT '批次标识',
  `admin_name` varchar(50) default NULL COMMENT '创建者名称',
  `tscreated` int(10) unsigned NOT NULL COMMENT '创建时间',
  `tsused` int(10) unsigned NOT NULL default '0' COMMENT '使用时间',
  `state` tinyint(3) unsigned NOT NULL default '0' COMMENT '状态 0可用 1已用 2已删',
  `member_id` int(11) NOT NULL default '0' COMMENT '使用者会员ID',
  `member_name` varchar(50) default NULL COMMENT '使用者会员名称',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台充值卡';

CREATE TABLE `shopjl_store_waybill` (
  `store_waybill_id` int(10) unsigned NOT NULL auto_increment COMMENT '店铺运单模板编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `express_id` int(10) unsigned NOT NULL COMMENT '物流公司编号',
  `waybill_id` int(10) unsigned NOT NULL COMMENT '运单模板编号',
  `waybill_name` varchar(50) NOT NULL COMMENT '运单模板名称',
  `store_waybill_data` varchar(2000) default NULL COMMENT '店铺自定义设置',
  `is_default` tinyint(3) unsigned NOT NULL default '0' COMMENT '是否默认模板',
  `store_waybill_left` int(11) NOT NULL default '0' COMMENT '店铺运单左偏移',
  `store_waybill_top` int(11) NOT NULL default '0' COMMENT '店铺运单上偏移',
  PRIMARY KEY  (`store_waybill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺运单模板表';

CREATE TABLE `shopjl_vr_groupbuy_area` (
  `area_id` int(11) NOT NULL auto_increment COMMENT '区域id',
  `area_name` varchar(100) NOT NULL COMMENT '域区名称',
  `parent_area_id` int(11) NOT NULL COMMENT '域区id',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  `first_letter` char(1) NOT NULL COMMENT '首字母',
  `area_number` varchar(10) default NULL COMMENT '区号',
  `post` varchar(10) default NULL COMMENT '邮编',
  `hot_city` tinyint(3) unsigned NOT NULL default '0' COMMENT '0.否 1.是',
  `number` int(11) NOT NULL default '0' COMMENT '数量',
  PRIMARY KEY  (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟团购区域表';

CREATE TABLE `shopjl_vr_groupbuy_class` (
  `class_id` int(11) NOT NULL auto_increment COMMENT '分类id',
  `class_name` varchar(100) NOT NULL COMMENT '分类名称',
  `parent_class_id` int(11) NOT NULL COMMENT '父类class_id',
  `class_sort` tinyint(3) unsigned default NULL COMMENT '分类排序',
  PRIMARY KEY  (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟团购分类表';

CREATE TABLE `shopjl_vr_order` (
  `order_id` int(11) NOT NULL auto_increment COMMENT '虚拟订单索引id',
  `order_sn` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `store_id` int(11) unsigned NOT NULL COMMENT '卖家店铺id',
  `store_name` varchar(50) NOT NULL COMMENT '卖家店铺名称',
  `buyer_id` int(11) unsigned NOT NULL COMMENT '买家id',
  `buyer_name` varchar(50) NOT NULL COMMENT '买家登录名',
  `buyer_phone` varchar(11) NOT NULL COMMENT '买家手机',
  `add_time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `payment_code` char(10) NOT NULL default '' COMMENT '支付方式名称代码',
  `payment_time` int(10) unsigned default '0' COMMENT '支付(付款)时间',
  `trade_no` varchar(35) default NULL COMMENT '第三方平台交易号',
  `close_time` int(10) unsigned default '0' COMMENT '关闭时间',
  `close_reason` varchar(50) default NULL COMMENT '关闭原因',
  `finnshed_time` int(11) default NULL COMMENT '完成时间',
  `order_amount` decimal(10,2) unsigned NOT NULL default '0.00' COMMENT '订单总价格(支付金额)',
  `refund_amount` decimal(10,2) default '0.00' COMMENT '退款金额',
  `rcb_amount` decimal(10,2) unsigned NOT NULL default '0.00' COMMENT '充值卡支付金额',
  `pd_amount` decimal(10,2) unsigned NOT NULL default '0.00' COMMENT '预存款支付金额',
  `order_state` tinyint(4) NOT NULL default '0' COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;40:已完成;',
  `refund_state` tinyint(1) unsigned default '0' COMMENT '退款状态:0是无退款,1是部分退款,2是全部退款',
  `buyer_msg` varchar(150) default NULL COMMENT '买家留言',
  `delete_state` tinyint(4) NOT NULL default '0' COMMENT '删除状态0未删除1放入回收站2彻底删除',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `goods_num` smallint(5) unsigned NOT NULL default '1' COMMENT '商品数量',
  `goods_image` varchar(100) default NULL COMMENT '商品图片',
  `commis_rate` smallint(5) unsigned NOT NULL default '0' COMMENT '佣金比例',
  `gc_id` mediumint(9) default '0' COMMENT '商品最底级分类ID',
  `vr_indate` int(11) default NULL COMMENT '有效期',
  `vr_send_times` tinyint(4) NOT NULL default '0' COMMENT '兑换码发送次数',
  `vr_invalid_refund` tinyint(4) NOT NULL default '1' COMMENT '允许过期退款1是0否',
  `order_promotion_type` tinyint(3) unsigned NOT NULL default '0' COMMENT '订单参加的促销类型 0无促销1团购',
  `promotions_id` mediumint(9) default '0' COMMENT '促销ID，与order_promotion_type配合使用',
  `order_from` tinyint(4) NOT NULL default '1' COMMENT '1WEB2mobile',
  `evaluation_state` tinyint(4) NOT NULL default '0' COMMENT '评价状态0默认1已评价2禁止评价',
  `evaluation_time` int(11) NOT NULL default '0' COMMENT '评价时间',
  `use_state` tinyint(4) default '0' COMMENT '使用状态0默认，未使用1已使用，有一个被使用即为1',
  PRIMARY KEY  (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单表';

CREATE TABLE `shopjl_vr_order_bill` (
  `ob_no` int(11) NOT NULL COMMENT '结算单编号(年月店铺ID)',
  `ob_start_date` int(11) NOT NULL COMMENT '开始日期',
  `ob_end_date` int(11) NOT NULL COMMENT '结束日期',
  `ob_order_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '订单金额',
  `ob_commis_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '佣金金额',
  `ob_result_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '应结金额',
  `ob_create_date` int(11) default '0' COMMENT '生成结算单日期',
  `os_month` mediumint(6) unsigned NOT NULL COMMENT '结算单年月份',
  `ob_state` enum('1','2','3','4') default '1' COMMENT '1默认2店家已确认3平台已审核4结算完成',
  `ob_pay_date` int(11) default '0' COMMENT '付款日期',
  `ob_pay_content` varchar(200) default '' COMMENT '支付备注',
  `ob_store_id` int(11) NOT NULL COMMENT '店铺ID',
  `ob_store_name` varchar(50) default NULL COMMENT '店铺名',
  PRIMARY KEY  (`ob_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单结算表';

CREATE TABLE `shopjl_vr_order_code` (
  `rec_id` int(11) NOT NULL auto_increment COMMENT '兑换码表索引id',
  `order_id` int(11) NOT NULL COMMENT '虚拟订单id',
  `store_id` int(10) unsigned NOT NULL default '0' COMMENT '店铺ID',
  `buyer_id` int(10) unsigned NOT NULL default '0' COMMENT '买家ID',
  `vr_code` varchar(18) NOT NULL COMMENT '兑换码',
  `vr_state` tinyint(4) NOT NULL default '0' COMMENT '使用状态 0:(默认)未使用1:已使用2:已过期',
  `vr_usetime` int(11) default NULL COMMENT '使用时间',
  `pay_price` decimal(10,2) NOT NULL default '0.00' COMMENT '实际支付金额(结算)',
  `vr_indate` int(11) default NULL COMMENT '过期时间',
  `commis_rate` smallint(6) NOT NULL default '0' COMMENT '佣金比例',
  `refund_lock` tinyint(1) unsigned default '0' COMMENT '退款锁定状态:0为正常,1为锁定,2为同意,默认为0',
  `vr_invalid_refund` tinyint(4) NOT NULL default '1' COMMENT '允许过期退款1是0否',
  PRIMARY KEY  (`rec_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换码表';

CREATE TABLE `shopjl_vr_order_statis` (
  `os_month` mediumint(9) unsigned NOT NULL default '0' COMMENT '统计编号(年月)',
  `os_year` smallint(6) default '0' COMMENT '年',
  `os_start_date` int(11) NOT NULL COMMENT '开始日期',
  `os_end_date` int(11) NOT NULL COMMENT '结束日期',
  `os_order_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '订单金额',
  `os_commis_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '佣金金额',
  `os_result_totals` decimal(10,2) NOT NULL default '0.00' COMMENT '本期应结',
  `os_create_date` int(11) default NULL COMMENT '创建记录日期',
  PRIMARY KEY  (`os_month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟订单月销量统计表';

CREATE TABLE `shopjl_vr_refund` (
  `refund_id` int(10) unsigned NOT NULL auto_increment COMMENT '记录ID',
  `order_id` int(10) unsigned NOT NULL COMMENT '虚拟订单ID',
  `order_sn` varchar(50) NOT NULL COMMENT '虚拟订单编号',
  `refund_sn` varchar(50) NOT NULL COMMENT '申请编号',
  `store_id` int(10) unsigned NOT NULL COMMENT '店铺ID',
  `store_name` varchar(20) NOT NULL COMMENT '店铺名称',
  `buyer_id` int(10) unsigned NOT NULL COMMENT '买家ID',
  `buyer_name` varchar(50) NOT NULL COMMENT '买家会员名',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品ID',
  `goods_num` int(10) unsigned default '1' COMMENT '退款商品数量',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_image` varchar(100) default NULL COMMENT '商品图片',
  `code_sn` varchar(300) NOT NULL COMMENT '兑换码编号',
  `refund_amount` decimal(10,2) default '0.00' COMMENT '退款金额',
  `admin_state` tinyint(1) unsigned default '1' COMMENT '退款状态:1为待审核,2为同意,3为不同意,默认为1',
  `add_time` int(10) unsigned NOT NULL COMMENT '添加时间',
  `admin_time` int(10) unsigned default '0' COMMENT '管理员处理时间,默认为0',
  `buyer_message` varchar(300) default NULL COMMENT '申请原因',
  `admin_message` varchar(300) default NULL COMMENT '管理员备注',
  `commis_rate` smallint(6) default '0' COMMENT '佣金比例',
  PRIMARY KEY  (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='虚拟兑码退款表';

CREATE TABLE `shopjl_waybill` (
  `waybill_id` int(10) unsigned NOT NULL auto_increment COMMENT '编号',
  `waybill_name` varchar(50) NOT NULL,
  `waybill_image` varchar(50) NOT NULL,
  `waybill_width` int(10) unsigned NOT NULL COMMENT '宽度',
  `waybill_height` int(10) unsigned NOT NULL COMMENT '高度',
  `waybill_data` varchar(2000) default NULL COMMENT '打印位置数据',
  `waybill_usable` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否可用',
  `waybill_top` int(11) NOT NULL default '0' COMMENT '上偏移量',
  `waybill_left` int(11) NOT NULL default '0' COMMENT '左偏移量',
  `express_id` tinyint(1) unsigned NOT NULL COMMENT '快递公司编号',
  `express_name` varchar(50) NOT NULL COMMENT '快递公司名称',
  `store_id` int(11) unsigned NOT NULL default '0' COMMENT '店铺编号(0-代表系统模板)',
  PRIMARY KEY  (`waybill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快递单打印模板表';

ALTER TABLE `shopjl_address` ADD `dlyp_id` int(11) DEFAULT '0' NULL COMMENT '自提点ID' AFTER `is_default`;

ALTER TABLE `shopjl_area` ADD `area_region` varchar(3) DEFAULT NULL comment '大区名称';

ALTER TABLE `shopjl_arrival_notice` ADD `an_email` varchar(100) NOT NULL COMMENT '邮箱';
ALTER TABLE `shopjl_arrival_notice` ADD `an_mobile` varchar(11) NOT NULL COMMENT '手机号';
ALTER TABLE `shopjl_arrival_notice` ADD `an_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1到货通知，2预售';

ALTER TABLE `shopjl_brand` ADD `show_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '品牌展示类型 0表示图片 1表示文字 ' AFTER `class_id`;

ALTER TABLE `shopjl_express` ADD `e_zt_state` tinyint(4) DEFAULT '0' NULL COMMENT '是否支持服务站配送0否1是' AFTER `e_url`;

ALTER TABLE `shopjl_goods` ADD `is_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品 1是，0否';
ALTER TABLE `shopjl_goods` ADD `virtual_indate` int(10) unsigned NOT NULL COMMENT '虚拟商品有效期';
ALTER TABLE `shopjl_goods` ADD `virtual_limit` tinyint(3) unsigned NOT NULL COMMENT '虚拟商品购买上限';
ALTER TABLE `shopjl_goods` ADD `virtual_invalid_refund` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许过期退款， 1是，0否';
ALTER TABLE `shopjl_goods` ADD `is_fcode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为F码商品 1是，0否';
ALTER TABLE `shopjl_goods` ADD `is_appoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是预约商品 1是，0否';
ALTER TABLE `shopjl_goods` ADD `is_presell` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是预售商品 1是，0否';
ALTER TABLE `shopjl_goods` ADD `have_gift` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否拥有赠品';
ALTER TABLE `shopjl_goods` ADD `is_own_shop` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为平台自营' ;

ALTER TABLE `shopjl_goods_browse` ADD primary key (`goods_id`,`member_id`);

ALTER TABLE `shopjl_goods_class` ADD `gc_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布虚拟商品，1是，0否' AFTER `gc_sort` ;

ALTER TABLE `shopjl_goods_common` ADD `mobile_body` TEXT NOT NULL COMMENT '手机端商品描述' AFTER `goods_body` ;
ALTER TABLE `shopjl_goods_common` ADD `is_virtual` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为虚拟商品 1是，0否';
ALTER TABLE `shopjl_goods_common` ADD `virtual_indate` int(10) unsigned NULL COMMENT '虚拟商品有效期';
ALTER TABLE `shopjl_goods_common` ADD `virtual_limit` tinyint(3) unsigned NULL COMMENT '虚拟商品购买上限';
ALTER TABLE `shopjl_goods_common` ADD `virtual_invalid_refund` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许过期退款， 1是，0否' AFTER `virtual_limit` ;
ALTER TABLE `shopjl_goods_common` ADD `is_fcode` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为F码商品 1是，0否';
ALTER TABLE `shopjl_goods_common` ADD `is_appoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是预约商品 1是，0否';
ALTER TABLE `shopjl_goods_common` ADD `appoint_satedate` int(10) unsigned NOT NULL COMMENT '预约商品出售时间';
ALTER TABLE `shopjl_goods_common` ADD `is_presell` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是预售商品 1是，0否';
ALTER TABLE `shopjl_goods_common` ADD `presell_deliverdate` int(10) unsigned NOT NULL COMMENT '预售商品发货时间';
ALTER TABLE `shopjl_goods_common` ADD `is_own_shop` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为平台自营' ;

ALTER TABLE `shopjl_groupbuy` ADD `s_class_id` int(10) unsigned not null default 0 comment '团购2级分类id' after `class_id`;
ALTER TABLE `shopjl_groupbuy` ADD `is_vr` tinyint(3) unsigned not null default 0 comment '是否虚拟团购 1是0否';
ALTER TABLE `shopjl_groupbuy` ADD `vr_city_id` int(11) default null comment '虚拟团购城市id';
ALTER TABLE `shopjl_groupbuy` ADD `vr_area_id` int(11) default null comment '虚拟团购区域id';
ALTER TABLE `shopjl_groupbuy` ADD `vr_mall_id` int(11) default null comment '虚拟团购商区id';
ALTER TABLE `shopjl_groupbuy` ADD `vr_class_id` int(11) default null comment '虚拟团购大分类id';
ALTER TABLE `shopjl_groupbuy` ADD `vr_s_class_id` int(11) default null comment '虚拟团购小分类id';

ALTER TABLE `shopjl_lock` CHANGE `pid` `pid` bigint(20) unsigned NOT NULL COMMENT 'IP+TYPE';
ALTER TABLE `shopjl_lock` ADD PRIMARY KEY (`pid`);

ALTER TABLE `shopjl_mb_category` ADD PRIMARY KEY (`gc_id`);

ALTER TABLE `shopjl_member` ADD `freeze_rc_balance` decimal(10,2) unsigned not null default 0.00 comment '冻结充值卡余额' after `freeze_predeposit`;
ALTER TABLE `shopjl_member` ADD `available_rc_balance` decimal(10,2) unsigned not null default 0.00 comment '可用充值卡余额' after `freeze_predeposit`;
ALTER TABLE `shopjl_member` ADD `member_exppoints` int(11) NOT NULL DEFAULT '0' COMMENT '会员经验值' AFTER `member_quicklink`;

ALTER TABLE `shopjl_offpay_area` CHANGE `store_id` `store_id` int(8) unsigned NOT NULL COMMENT '商家ID';
ALTER TABLE `shopjl_offpay_area` ADD PRIMARY KEY (`store_id`);

ALTER TABLE `shopjl_order` ADD `rcb_amount` decimal(10,2) unsigned DEFAULT '0.00' NOT NULL COMMENT '充值卡支付金额' AFTER `order_amount`;
ALTER TABLE `shopjl_order` CHANGE `evaluation_state` `evaluation_state` tinyint(4) DEFAULT '0' NULL  COMMENT '评价状态 0未评价，1已评价，2已过期未评价';
ALTER TABLE `shopjl_order` CHANGE `order_from` `order_from` tinyint(4) DEFAULT '1' NOT NULL COMMENT '1WEB2mobile';
ALTER TABLE `shopjl_order` CHANGE `order_state` `order_state` tinyint(4) DEFAULT '10' NOT NULL COMMENT '订单状态：0(已取消)10(默认):未付款;20:已付款;30:已发货;40:已收货;';

ALTER TABLE `shopjl_order_common` ADD `reciver_city_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货人市级ID' AFTER `reciver_province_id`;
ALTER TABLE `shopjl_order_common` ADD `dlyo_pickup_code` varchar(4) NULL COMMENT '提货码';

ALTER TABLE `shopjl_points_goods` ADD `pgoods_limitmgrade` int(11) NOT NULL DEFAULT '0' COMMENT '限制参与兑换的会员级别' AFTER `pgoods_islimittime`;

ALTER TABLE `shopjl_points_order` CHANGE `point_orderstate` `point_orderstate` int(11) NOT NULL DEFAULT '20' COMMENT '订单状态：20(默认):已兑换并扣除积分;30:已发货;40:已收货;50已完成;2已取消';

ALTER TABLE `shopjl_stat_ordergoods` ADD `order_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总价格' AFTER `payment_code`;
ALTER TABLE `shopjl_stat_ordergoods` ADD `shipping_fee` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '运费' AFTER `order_amount`;
ALTER TABLE `shopjl_stat_ordergoods` ADD `evaluation_state` enum('0','1') DEFAULT '0' COMMENT '评价状态 0未评价，1已评价' AFTER `shipping_fee`;
ALTER TABLE `shopjl_stat_ordergoods` ADD `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额' AFTER `refund_state`;

ALTER TABLE `shopjl_store` ADD `is_own_shop` tinyint(3) unsigned NOT NULL DEFAULT '0' comment '是否自营店铺 1是 0否';
ALTER TABLE `shopjl_store` ADD `bind_all_gc` tinyint(3) unsigned NOT NULL DEFAULT '0' comment '自营店是否绑定全部分类 0否1是';
ALTER TABLE `shopjl_store` ADD `store_vrcode_prefix` char(3) NULL COMMENT '商家兑换码前缀';

ALTER TABLE `shopjl_store_bind_class` CHANGE `state` `state` tinyint(3) unsigned not null default '0' comment '状态0审核中1已审核 2平台自营店铺';

ALTER TABLE `shopjl_voucher_template` ADD `voucher_t_sc_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属店铺分类ID' AFTER `voucher_t_storename`;
ALTER TABLE `shopjl_voucher_template` ADD `voucher_t_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐 0不推荐 1推荐' AFTER `voucher_t_customimg`;

ALTER TABLE `shopjl_lock` DROP INDEX `ip`;

ALTER TABLE `shopjl_member` DROP `member_credit`;

ALTER TABLE `shopjl_order_statis` DROP INDEX `os_month`;

ALTER TABLE `shopjl_points_order` DROP `point_paymentid`;
ALTER TABLE `shopjl_points_order` DROP `point_paymentname`;
ALTER TABLE `shopjl_points_order` DROP `point_paymentcode`;
ALTER TABLE `shopjl_points_order` DROP `point_paymentdirect`;
ALTER TABLE `shopjl_points_order` DROP `point_outsn`;
ALTER TABLE `shopjl_points_order` DROP `point_paymenttime`;
ALTER TABLE `shopjl_points_order` DROP `point_paymessage`;
ALTER TABLE `shopjl_points_order` DROP `point_outpaymentcode`;
ALTER TABLE `shopjl_points_order` DROP `point_shippingcharge`;
ALTER TABLE `shopjl_points_order` DROP `point_shippingfee`;
ALTER TABLE `shopjl_points_order` DROP `point_orderamount`;

INSERT INTO `shopjl_adv_position` (`ap_id`, `ap_name`, `ap_intro`, `ap_class`, `ap_display`, `is_use`, `ap_width`, `ap_height`, `ap_price`, `adv_num`, `click_num`, `default_content`) VALUES(11, '首页焦点大图广告1', '位于首页焦点大图区', 0, 2, 1, 1920, 481, 100, 0, 0, '11.jpg');
INSERT INTO `shopjl_adv_position` (`ap_id`, `ap_name`, `ap_intro`, `ap_class`, `ap_display`, `is_use`, `ap_width`, `ap_height`, `ap_price`, `adv_num`, `click_num`, `default_content`) VALUES(12, '首页焦点大图广告2', '位于首页焦点大图区', 0, 2, 1, 1920, 481, 100, 0, 0, '12.jpg');
INSERT INTO `shopjl_adv_position` (`ap_id`, `ap_name`, `ap_intro`, `ap_class`, `ap_display`, `is_use`, `ap_width`, `ap_height`, `ap_price`, `adv_num`, `click_num`, `default_content`) VALUES(21, '首页焦点联动广告1', '位于首页焦点联动区', 0, 2, 1, 259, 180, 100, 0, 0, '21.jpg');
INSERT INTO `shopjl_adv_position` (`ap_id`, `ap_name`, `ap_intro`, `ap_class`, `ap_display`, `is_use`, `ap_width`, `ap_height`, `ap_price`, `adv_num`, `click_num`, `default_content`) VALUES(22, '首页焦点联动广告2', '位于首页焦点联动区', 0, 2, 1, 259, 180, 100, 0, 0, '22.jpg');
INSERT INTO `shopjl_adv_position` (`ap_id`, `ap_name`, `ap_intro`, `ap_class`, `ap_display`, `is_use`, `ap_width`, `ap_height`, `ap_price`, `adv_num`, `click_num`, `default_content`) VALUES(23, '首页焦点联动广告3', '位于首页焦点联动区', 0, 2, 1, 259, 180, 100, 0, 0, '23.jpg');

INSERT INTO `shopjl_mail_msg_temlates`(`name`,`title`,`code`,`content`) VALUES ( '<strong>[用户]</strong>虚拟兑换码通知','虚拟兑换码通知 - {$site_name}','send_vr_code','【{$site_name}】您的虚拟兑换码是：{$vr_code}。');
INSERT INTO `shopjl_mail_msg_temlates`(`name`,`title`,`code`,`content`) VALUES ( '<strong>[用户]</strong>自提通知','用户自提通知 - {$site_name}','send_pickup_code','【{$site_name}】您的订单已到达自提点，请上门取货！提货时请提供手机号/订单号/运单号及提货码：{$pickup_code}。');

INSERT INTO `shopjl_member_msg_tpl` (`mmt_code`, `mmt_name`, `mmt_message_switch`, `mmt_message_content`, `mmt_short_switch`, `mmt_short_content`, `mmt_mail_switch`, `mmt_mail_subject`, `mmt_mail_content`) VALUES('voucher_will_expire', '代金券即将到期提醒', 1, '您有一个代金券即将在{$indate}过期，请记得使用。<a href="{$voucher_url}" target="_blank">点击查看</a>', 0, '【{$site_name}】您有一个代金券即将在{$indate}过期，请记得使用。', 0, '{$site_name}提醒：您有一个代金券即将在{$indate}过期，请记得使用。', '<p>\r\n	{$site_name}提醒：\r\n</p>\r\n<p>\r\n	您有一个代金券即将在{$indate}过期，请记得使用。\r\n</p>\r\n<p>\r\n	<a href="{$voucher_url}" target="_blank">点击查看</a> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style="text-align:right;">\r\n	{$site_name}\r\n</p>\r\n<p style="text-align:right;">\r\n	{$mail_send_time}\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>');
INSERT INTO `shopjl_member_msg_tpl` (`mmt_code`, `mmt_name`, `mmt_message_switch`, `mmt_message_content`, `mmt_short_switch`, `mmt_short_content`, `mmt_mail_switch`, `mmt_mail_subject`, `mmt_mail_content`) VALUES('vr_code_will_expire', '兑换码即将到期提醒', 1, '您有一组兑换码即将在{$indate}过期，请记得使用。<a href="{$vr_order_url}" target="_blank">点击查看</a>', 0, '【{$site_name}】您有一组兑换码即将在{$indate}过期，请记得使用。', 0, '{$site_name}提醒：您有一组兑换码即将在{$indate}过期，请记得使用。', '<p>\r\n	{$site_name}提醒：\r\n</p>\r\n<p>\r\n	您有一组兑换码即将在{$indate}过期，请记得使用。\r\n</p>\r\n<p>\r\n	&lt;a href="{$vr_order_url}" target="_blank"&gt;点击查看&lt;/a&gt;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style="text-align:right;">\r\n	{$site_name}\r\n</p>\r\n<p style="text-align:right;">\r\n	{$mail_send_time}\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>');
INSERT INTO `shopjl_member_msg_tpl` (`mmt_code`, `mmt_name`, `mmt_message_switch`, `mmt_message_content`, `mmt_short_switch`, `mmt_short_content`, `mmt_mail_switch`, `mmt_mail_subject`, `mmt_mail_content`) VALUES('recharge_card_balance_change', '充值卡余额变动提醒', 1, '你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化 ：{$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。<a href="{$url}" target="_blank">点击查看充值卡余额</a>', 0, '【{$site_name}】你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化： {$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。', 0, '{$site_name}提醒：你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化： {$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。', '<p>\r\n    {$site_name}提醒：\r\n</p>\r\n<p>\r\n  你的账户于 {$time} 充值卡余额有变化，描述：{$description}，可用充值卡余额变化：{$available_amount}元，冻结充值卡余额变化：{$freeze_amount}元。\r\n</p>\r\n<p>\r\n  <a href="{$url}" target="_blank">点击查看余额</a> \r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p>\r\n   <br />\r\n</p>\r\n<p style="text-align:right;">\r\n {$site_name}\r\n</p>\r\n<p style="text-align:right;">\r\n   {$mail_send_time}\r\n</p>');

INSERT INTO  `shopjl_mb_payment` (`payment_id`, `payment_code`, `payment_name`, `payment_config`, `payment_state`) VALUES ('1', 'alipay', '支付宝', '', '0');
INSERT INTO  `shopjl_mb_payment` (`payment_id`, `payment_code`, `payment_name`, `payment_config`, `payment_state`) VALUES ('2', 'wxpay', '微信支付', '', '0');

INSERT INTO `shopjl_setting` (`name` ,`value`)VALUES ('delivery_isuse', '1');
INSERT INTO `shopjl_setting` (`name` ,`value`)VALUES ('member_grade', 'a:4:{i:0;a:3:{s:5:"level";i:0;s:10:"level_name";s:2:"V0";s:9:"exppoints";i:0;}i:1;a:3:{s:5:"level";i:1;s:10:"level_name";s:2:"V1";s:9:"exppoints";i:1000;}i:2;a:3:{s:5:"level";i:2;s:10:"level_name";s:2:"V2";s:9:"exppoints";i:10000;}i:3;a:3:{s:5:"level";i:3;s:10:"level_name";s:2:"V3";s:9:"exppoints";i:20000;}}');
INSERT INTO `shopjl_setting` (`name` ,`value`)VALUES ('exppoints_rule', 'a:4:{s:9:"exp_login";s:1:"5";s:12:"exp_comments";s:2:"10";s:13:"exp_orderrate";s:1:"1";s:12:"exp_ordermax";s:3:"500";}');

INSERT INTO `shopjl_vr_groupbuy_area` (select * from `shopjl_live_area`);
INSERT INTO `shopjl_vr_groupbuy_class` (select * from `shopjl_live_class`);

INSERT INTO `shopjl_waybill` (`waybill_name`, `waybill_image`, `waybill_width`, `waybill_height`, `waybill_data`, `waybill_usable`, `waybill_top`, `waybill_left`, `express_id`, `express_name`, `store_id`) VALUES('百世汇通', '04558238732336424.jpg', 229, 126, 'a:10:{s:10:"buyer_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"485";s:3:"top";s:2:"97";s:5:"width";s:2:"88";s:6:"height";s:2:"24";}s:10:"buyer_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"423";s:3:"top";s:3:"173";s:5:"width";s:3:"256";s:6:"height";s:2:"20";}s:13:"buyer_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"420";s:3:"top";s:3:"201";s:5:"width";s:3:"333";s:6:"height";s:2:"20";}s:12:"buyer_mobile";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"473";s:3:"top";s:3:"230";s:5:"width";s:3:"141";s:6:"height";s:2:"20";}s:11:"buyer_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"671";s:3:"top";s:3:"227";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:11:"seller_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"126";s:3:"top";s:2:"98";s:5:"width";s:3:"112";s:6:"height";s:2:"16";}s:11:"seller_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:2:"72";s:3:"top";s:3:"174";s:5:"width";s:3:"227";s:6:"height";s:2:"20";}s:14:"seller_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:2:"68";s:3:"top";s:3:"204";s:5:"width";s:3:"294";s:6:"height";s:2:"20";}s:12:"seller_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"120";s:3:"top";s:3:"231";s:5:"width";s:3:"124";s:6:"height";s:2:"20";}s:14:"seller_company";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"116";s:3:"top";s:3:"124";s:5:"width";s:3:"184";s:6:"height";s:2:"20";}}', 1, -3, -5, 16, '汇通快递', 0);
INSERT INTO `shopjl_waybill` (`waybill_name`, `waybill_image`, `waybill_width`, `waybill_height`, `waybill_data`, `waybill_usable`, `waybill_top`, `waybill_left`, `express_id`, `express_name`, `store_id`) VALUES('申通', '04559833067248352.jpg', 229, 127, 'a:10:{s:10:"buyer_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"497";s:3:"top";s:2:"99";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:10:"buyer_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"492";s:3:"top";s:3:"165";s:5:"width";s:3:"191";s:6:"height";s:2:"20";}s:13:"buyer_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"426";s:3:"top";s:3:"200";s:5:"width";s:3:"322";s:6:"height";s:2:"20";}s:12:"buyer_mobile";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"551";s:3:"top";s:3:"235";s:5:"width";s:3:"122";s:6:"height";s:2:"20";}s:11:"buyer_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"688";s:3:"top";s:3:"236";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:11:"seller_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"132";s:3:"top";s:3:"100";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:11:"seller_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"125";s:3:"top";s:3:"169";s:5:"width";s:3:"218";s:6:"height";s:2:"20";}s:14:"seller_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:2:"68";s:3:"top";s:3:"208";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:12:"seller_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"171";s:3:"top";s:3:"238";s:5:"width";s:3:"159";s:6:"height";s:2:"20";}s:14:"seller_company";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"140";s:3:"top";s:3:"136";s:5:"width";s:3:"217";s:6:"height";s:2:"20";}}', 1, -3, -5, 28, '申通快递', 0);
INSERT INTO `shopjl_waybill` (`waybill_name`, `waybill_image`, `waybill_width`, `waybill_height`, `waybill_data`, `waybill_usable`, `waybill_top`, `waybill_left`, `express_id`, `express_name`, `store_id`) VALUES('顺风', '04559894766651678.jpg', 216, 139, 'a:10:{s:10:"buyer_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"302";s:3:"top";s:3:"290";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:10:"buyer_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"101";s:3:"top";s:3:"317";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:13:"buyer_address";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:12:"buyer_mobile";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:11:"buyer_phone";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:11:"seller_name";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:11:"seller_area";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:14:"seller_address";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:12:"seller_phone";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}s:14:"seller_company";a:4:{s:4:"left";s:1:"0";s:3:"top";s:1:"0";s:5:"width";s:1:"0";s:6:"height";s:1:"0";}}', 1, -4, -5, 29, '顺丰快递', 0);
INSERT INTO `shopjl_waybill` (`waybill_name`, `waybill_image`, `waybill_width`, `waybill_height`, `waybill_data`, `waybill_usable`, `waybill_top`, `waybill_left`, `express_id`, `express_name`, `store_id`) VALUES('圆通速递', '04577145745163834.jpg', 229, 127, 'a:10:{s:10:"buyer_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"471";s:3:"top";s:3:"105";s:5:"width";s:3:"179";s:6:"height";s:2:"20";}s:10:"buyer_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"469";s:3:"top";s:3:"144";s:5:"width";s:3:"242";s:6:"height";s:2:"20";}s:13:"buyer_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"419";s:3:"top";s:3:"173";s:5:"width";s:3:"343";s:6:"height";s:2:"20";}s:12:"buyer_mobile";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"507";s:3:"top";s:3:"201";s:5:"width";s:2:"93";s:6:"height";s:2:"20";}s:11:"buyer_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"613";s:3:"top";s:3:"198";s:5:"width";s:3:"109";s:6:"height";s:2:"20";}s:11:"seller_name";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"116";s:3:"top";s:3:"104";s:5:"width";s:3:"100";s:6:"height";s:2:"20";}s:11:"seller_area";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"110";s:3:"top";s:3:"144";s:5:"width";s:3:"148";s:6:"height";s:2:"20";}s:14:"seller_address";a:5:{s:5:"check";s:2:"on";s:4:"left";s:2:"63";s:3:"top";s:3:"169";s:5:"width";s:3:"323";s:6:"height";s:2:"20";}s:12:"seller_phone";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"151";s:3:"top";s:3:"195";s:5:"width";s:3:"139";s:6:"height";s:2:"20";}s:14:"seller_company";a:5:{s:5:"check";s:2:"on";s:4:"left";s:3:"109";s:3:"top";s:3:"123";s:5:"width";s:3:"271";s:6:"height";s:2:"12";}}', 1, -3, -5, 40, '圆通快递', 0);

UPDATE `shopjl_order` SET `evaluation_state`=0 WHERE `evaluation_state`=1;
UPDATE `shopjl_order` SET `evaluation_state`=1 WHERE `evaluation_state`=2;

UPDATE `shopjl_order` SET `order_state`=0 WHERE `order_state`=1;
UPDATE `shopjl_order` SET `order_state`=10 WHERE `order_state`=2;
UPDATE `shopjl_order` SET `order_state`=20 WHERE `order_state`=3;
UPDATE `shopjl_order` SET `order_state`=30 WHERE `order_state`=4;
UPDATE `shopjl_order` SET `order_state`=40 WHERE `order_state`=5;

UPDATE `shopjl_payment` SET `payment_name` = '站内余额支付' where `payment_code` = 'predeposit';

UPDATE `shopjl_web` SET `style_name` = 'default' where `style_name` = 'gray' and `web_page` = 'index';

UPDATE `shopjl_adv_position` SET `ap_display` = '2', `ap_width` = '900', `ap_height` = '368' WHERE `ap_id` =35;
UPDATE `shopjl_adv_position` SET `ap_width` = '206', `ap_height` = '300' WHERE `ap_id` =37;

UPDATE `shopjl_area` SET `area_region` = '华北', `area_name` = '北京' where `area_id` = '1';
UPDATE `shopjl_area` SET `area_region` = '华北', `area_name` = '天津' where `area_id` = '2';
UPDATE `shopjl_area` SET `area_region` = '华北', `area_name` = '河北' where `area_id` = '3';
UPDATE `shopjl_area` SET `area_region` = '华北', `area_name` = '山西' where `area_id` = '4';
UPDATE `shopjl_area` SET `area_region` = '华北', `area_name` = '内蒙古' where `area_id` = '5';
UPDATE `shopjl_area` SET `area_region` = '东北', `area_name` = '辽宁' where `area_id` = '6';
UPDATE `shopjl_area` SET `area_region` = '东北', `area_name` = '吉林' where `area_id` = '7';
UPDATE `shopjl_area` SET `area_region` = '东北', `area_name` = '黑龙江' where `area_id` = '8';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '上海' where `area_id` = '9';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '江苏' where `area_id` = '10';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '浙江' where `area_id` = '11';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '安徽' where `area_id` = '12';
UPDATE `shopjl_area` SET `area_region` = '华南', `area_name` = '福建' where `area_id` = '13';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '江西' where `area_id` = '14';
UPDATE `shopjl_area` SET `area_region` = '华东', `area_name` = '山东' where `area_id` = '15';
UPDATE `shopjl_area` SET `area_region` = '华中', `area_name` = '河南' where `area_id` = '16';
UPDATE `shopjl_area` SET `area_region` = '华中', `area_name` = '湖北' where `area_id` = '17';
UPDATE `shopjl_area` SET `area_region` = '华中', `area_name` = '湖南' where `area_id` = '18';
UPDATE `shopjl_area` SET `area_region` = '华南', `area_name` = '广东' where `area_id` = '19';
UPDATE `shopjl_area` SET `area_region` = '华南', `area_name` = '广西' where `area_id` = '20';
UPDATE `shopjl_area` SET `area_region` = '华南', `area_name` = '海南' where `area_id` = '21';
UPDATE `shopjl_area` SET `area_region` = '西南', `area_name` = '重庆' where `area_id` = '22';
UPDATE `shopjl_area` SET `area_region` = '西南', `area_name` = '四川' where `area_id` = '23';
UPDATE `shopjl_area` SET `area_region` = '西南', `area_name` = '贵州' where `area_id` = '24';
UPDATE `shopjl_area` SET `area_region` = '西南', `area_name` = '云南' where `area_id` = '25';
UPDATE `shopjl_area` SET `area_region` = '西南', `area_name` = '西藏' where `area_id` = '26';
UPDATE `shopjl_area` SET `area_region` = '西北', `area_name` = '陕西' where `area_id` = '27';
UPDATE `shopjl_area` SET `area_region` = '西北', `area_name` = '甘肃' where `area_id` = '28';
UPDATE `shopjl_area` SET `area_region` = '西北', `area_name` = '青海' where `area_id` = '29';
UPDATE `shopjl_area` SET `area_region` = '西北', `area_name` = '宁夏' where `area_id` = '30';
UPDATE `shopjl_area` SET `area_region` = '西北', `area_name` = '新疆' where `area_id` = '31';
UPDATE `shopjl_area` SET `area_region` = '港澳台', `area_name` = '台湾' where `area_id` = '32';
UPDATE `shopjl_area` SET `area_region` = '港澳台', `area_name` = '香港' where `area_id` = '33';
UPDATE `shopjl_area` SET `area_region` = '港澳台', `area_name` = '澳门' where `area_id` = '34';
UPDATE `shopjl_area` SET `area_region` = '海外', `area_name` = '海外' where `area_id` = '35';

DROP TABLE `shopjl_adv_click`;

DROP TABLE `shopjl_live_area`;
DROP TABLE `shopjl_live_class`;
DROP TABLE `shopjl_live_groupbuy`;
DROP TABLE `shopjl_live_order`;
DROP TABLE `shopjl_live_order_pwd`;

DROP TABLE `shopjl_mb_ad`;
DROP TABLE `shopjl_mb_home`;