Ŀǰ��������
1.Imϵͳ��web_chat��������.user.jsδ֪
2.imϵͳ�ĵ���ƽ̨��ѯstore.jsδ֪
3.�Ա���������[���޷�ȷ���Ƿ�������ϴ�]
undefined is function charCount
 ������charCount 
 <script type="text/javascript" src="http://nc.com/data/resource/js/jquery.charCount.js"></script>
�ѽ������
1.�ڲ�����ͼƬ����ʧЧ
2.wap������������shopnc\tpl ����λ��
3.�Ա�����δ����charCount����
4.��֧�������Ա�������
5.�����߱��Ϸ���
6.qq��½ api.php�ļ���Ӧ������shopjl.php
utils.php��ȥ��ע��file_get_contents
----------------------------------------------------------------------
�������⣺
��Ʒ�б��޷���ѯ��Ӫ����Ʒ
=============================================================================��csv�н�ȡ�ֶζԱ�Ĭ�������Ա��ֶ�
Array ( [goods_name] => �������� [cid] => ������Ŀ [seller_cids] => ����Ŀ¼ [goods_form] => �¾ɳ̶� [goods_store_price] => �����۸� [spec_goods_storage] => �������� [goods_indate] => ��Ч�� [goods_transfee_charge] => �˷ѳе� [py_price] => ƽ�� [es_price] => EMS [kd_price] => ��� [spec] => �������Ա��� [goods_commend] => �����Ƽ� [goods_body] => �������� [goods_image] => ��ͼƬ ) 
Array ( [0] => is_lighting_consigment [1] => is_xinpin [2] => foodparame [3] => features [4] => buyareatype [5] => global_stock_type [6] => global_stock_country [7] => sub_stock_type [8] => item_size [9] => item_weight [10] => sell_promise [11] => custom_design_flag [12] => wireless_desc [13] => barcode [14] => sku_barcode [15] => newprepay [16] => subtitle [17] => cpv_memo [18] => input_custom_cpv [19] => qualification [20] => add_qualification [21] => o2o_bind_service )

=================================================================================

���ڻ�������

1��ҳ��js��֤�Ƿ�Ϊ������������
�����ַ��index.php?act=buy&op=change_addr&&freight_hash=XLvdVw1lXb_hIXDZn4pLVeSGXAGaNnB_2YmkNI52XinRxV3IKsozu3eEFTwJiOlPmw8JuOhCGQYE1m22nrciKM6IRcoxCmpUFoe4YTFePWovGSnqP61hRcL&city_id=36&area_id=37
-------------------------------------------------------------------------
����buy�������е�change_addr�������ж��Ƿ���������������һ��json����

change_addr�����е��� 
buy.logic.php�е�chageadd����ȥ�ж��Ƿ�����

1������DPO��������  2015-04-12

2�������Ա����빦�ܣ�֧�����µ��Ա��������ݵ��롣uploads������store_id�ֶ� 2015-04-20 

==========================================================================================
taobao_import.php ������ɲ���
һ��д��gooods��д��goods_common��д��upload��
����д��album_pic ����upload��
��������goods_images�� ��ɾ��upload�����ݡ� 
�ġ���̨���û������������
�塢chat��ʱ����ϵͳ����

