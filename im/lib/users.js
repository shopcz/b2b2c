var user_list = new Array();//��Ա����Ϣ

var msg_list = new Array();//����δ����Ϣ�Ķ�ά����['u_id']['m_id']
var c = console.log;

exports.set_user = set_user;
exports.set_user_info = set_user_info;
exports.get_user = get_user;

exports.set_msg = set_msg;
exports.get_msg = get_msg;
exports.del_msg = del_msg;

function set_user(user){//���»�Ա��������Ϣ
	var user_info = new Object();
	var u_id = user['u_id'];
	user_info = get_user(u_id);
	if ( typeof user_info['u_id'] === "undefined" ) {
		user_info['u_id'] = u_id;
		user_info['u_name'] = user['u_name'];
		user_info['s_id'] = user['s_id'];
		if ( typeof msg_list[u_id] === "undefined" ) msg_list[u_id] = new Object();
	}
	user_list[u_id] = user_info;
}
function set_user_info(u_id,k,v){//���û�Ա��Ϣ
	if ( typeof user_list[u_id] === "object" ) user_list[u_id][k] = v;
}
function get_user(u_id){//��Ա��Ϣ
	var user_info = new Object();
	if ( typeof user_list[u_id] === "object" ) {
		user_info = user_list[u_id];
	}
	return user_info;
}

function set_socket(u_id,socket){//���ûỰ
	socket.join('user_'+u_id);
	socket.set('u_id', u_id);
}

function set_msg(u_id,msg){//�����Ϣ
	var m_id = msg['m_id'];
	if ( typeof msg_list[u_id] === "undefined" ) msg_list[u_id] = new Object();
	msg_list[u_id][m_id] = msg;
}
function get_msg(u_id){//��Ա����Ϣ
	return msg_list[u_id];
}
function del_msg(u_id,m_id){//ɾ����Ϣ
	delete msg_list[u_id][m_id];
}