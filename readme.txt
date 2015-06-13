目前存在问题
1.Im系统的web_chat控制器。.user.js未知
2.im系统的店铺平台咨询store.js未知
3.淘宝导入有误[还无法确认是否可正常上传]
undefined is function charCount
 先载入charCount 
 <script type="text/javascript" src="http://nc.com/data/resource/js/jquery.charCount.js"></script>
已解决问题
1.内部部分图片链接失效
2.wap控制器不存在shopnc\tpl 引用位置
3.淘宝导入未定义charCount错误
4.不支持最新淘宝助理导入
5.消费者保障服务
6.qq登陆 api.php文件里应该引入shopjl.php
utils.php中去掉注释file_get_contents
----------------------------------------------------------------------
存在问题：
商品列表无法查询自营店商品
=============================================================================从csv中截取字段对比默认设置淘宝字段
Array ( [goods_name] => 宝贝名称 [cid] => 宝贝类目 [seller_cids] => 店铺目录 [goods_form] => 新旧程度 [goods_store_price] => 宝贝价格 [spec_goods_storage] => 宝贝数量 [goods_indate] => 有效期 [goods_transfee_charge] => 运费承担 [py_price] => 平邮 [es_price] => EMS [kd_price] => 快递 [spec] => 销售属性别名 [goods_commend] => 橱窗推荐 [goods_body] => 宝贝描述 [goods_image] => 新图片 ) 
Array ( [0] => is_lighting_consigment [1] => is_xinpin [2] => foodparame [3] => features [4] => buyareatype [5] => global_stock_type [6] => global_stock_country [7] => sub_stock_type [8] => item_size [9] => item_weight [10] => sell_promise [11] => custom_design_flag [12] => wireless_desc [13] => barcode [14] => sku_barcode [15] => newprepay [16] => subtitle [17] => cpv_memo [18] => input_custom_cpv [19] => qualification [20] => add_qualification [21] => o2o_bind_service )

=================================================================================

关于货到付款

1，页面js验证是否为货到付款区域
请求地址：index.php?act=buy&op=change_addr&&freight_hash=XLvdVw1lXb_hIXDZn4pLVeSGXAGaNnB_2YmkNI52XinRxV3IKsozu3eEFTwJiOlPmw8JuOhCGQYE1m22nrciKM6IRcoxCmpUFoe4YTFePWovGSnqP61hRcL&city_id=36&area_id=37
-------------------------------------------------------------------------
依据buy控制器中的change_addr方法来判断是否允许货到付款，返回一个json数据

change_addr方法中调用 
buy.logic.php中的chageadd方法去判断是否允许

1、新增DPO操作驱动  2015-04-12

2、更新淘宝导入功能，支持最新的淘宝助理数据导入。uploads表增加store_id字段 2015-04-20 

==========================================================================================
taobao_import.php 里面完成步骤
一、写入gooods表，写入goods_common表，写入upload表
二、写入album_pic 更新upload表
三、更新goods_images表 ，删除upload表数据。 
四、后台启用缓存服务器管理
五、chat即时聊天系统完善

