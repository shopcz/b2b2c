var http = require('http');
var url = require('url');
var db = require('./lib/db');
var lib_user = require('./lib/users');
var _config = require('./config');
var hostname = _config.hostname;
var port = _config.port;
var c = console.log;
var connected_users = new Array();
var server = http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Access Invalid!\n');
});
server.listen(port);

var io = require('socket.io').listen(server);

io.set('log level', 0); 
io.set('origins', '*:*'); 
io.set('resource', '/resource'); 
io.set('transports', ['websocket', 'xhr-polling', 'jsonp-polling', 'htmlfile', 'flashsocket']);

io.set('authorization', function (handshakeData, cb) {//��֤����
	var domain = hostname;
	var origin = handshakeData.headers.origin || handshakeData.headers.referer;
	var parts = url.parse(''+origin);
	var re = new RegExp(domain+"$","g");
	var arr = re.exec(parts.hostname);
	if ( domain === "" ) {
		cb(null, true);
  } else if ( arr !== null ) {
  	cb(null, true);
  } else {
  	var dt = new Date();
		console.log(dateToString(dt)+' '+parts.hostname+' handshake unauthorized');
	  cb(null, false);
  }
});
io.sockets.on('connection', function (socket) {
  socket.on('update_user', function (user) {//���ӳɹ�����ͻ��˷�δ����Ϣ
  	var u_id = user['u_id'];
  	update_user(user, function () {
	    socket.set('u_id', u_id);
	    socket.join('user_'+u_id);
	    var msg_list = {};
	    msg_list = lib_user.get_msg(u_id);
	  	socket.emit('get_msg', msg_list);
	  	lib_user.set_user_info(u_id,'connected',1);
	  	lib_user.set_user_info(u_id,'s_id',user['s_id']);
	  	lib_user.set_user_info(u_id,'s_name',user['s_name']);
	  	lib_user.set_user_info(u_id,'avatar',user['avatar']);
	  	connected_users[u_id] = lib_user.get_user(u_id);
  	});
  });
  socket.on('send_msg', function (msg) {//������Ϣ����ͻ��˷�֪ͨ
  	var t_id = msg['t_id'];
  	var n = io.sockets.clients('user_'+t_id).length;
		socket.get('u_id', function (err, u_id) {
  		msg['user'] = lib_user.get_user(u_id);
	  	if ( n > 0) {//��Ա����ʱ��֪ͨ
	  		var m_id = msg['m_id'];
	  		var msg_list = {};
	  		msg['online'] = 1;
	  		msg_list[m_id] = msg;
	  		io.sockets.in('user_'+t_id).emit('get_msg', msg_list);
	  	}
	  	lib_user.set_msg(t_id,msg);
		});
  });
  socket.on('get_state', function (u_state) {//��ѯ����״̬�����ؿͻ���
  	var list = {};
  	var user_list = {};
  	for (var k in u_state){
  		var user_info = {};
  		user_info = lib_user.get_user(k);
  		user_info['online'] = 0;
	  	var n = io.sockets.clients('user_'+k).length;
	  	if ( n > 0) {//��Ա����
	  		u_state[k] = 1;
	  		user_info['online'] = 1;
	  	}
	  	if ( user_info['u_id'] > 0) user_list[k] = user_info;
  	}
  	list['u_state'] = u_state;
  	list['user'] = user_list;
  	socket.emit('get_state', list);
  });
  socket.on('del_msg', function (msg) {//����δ����Ϣ
  	var max_id = msg['max_id'];//������Ϣ���
  	var f_id = msg['f_id'];//��Ϣ������
    socket.get('u_id', function (err, u_id) {
    	var list = lib_user.get_msg(u_id);//δ����Ϣ�б�
	  	if (typeof list[max_id] === "object") {//ɾ��δ����Ϣ
		  	for (var k in list){
		  		var m_id = list[k]['m_id'];
		  		var f = list[k]['f_id'];
		  		if ( max_id > m_id && f_id == f) {
		  			lib_user.del_msg(u_id,m_id);
		  		}
		  	}
		  	var n = io.sockets.clients('user_'+u_id).length;
		  	if (n > 1) {//������Ա����������������ʱ��֪ͨ
		  		io.sockets.in('user_'+u_id).emit('del_msg', msg);
		  	}
	  	}
	  	lib_user.del_msg(u_id,max_id);//ɾ����Ϣ��ֹ�ظ���֪ͨ
	  	db.del_msg(' t_id = '+u_id+' AND f_id = '+f_id+' AND m_id < '+max_id);
	  	var v = {};
	  	v['r_state'] = 1;//��Ϣ״̬:1Ϊ�Ѷ�,2Ϊδ��
	  	db.update_msg(' t_id = '+u_id+' AND f_id = '+f_id+' AND m_id = '+max_id,v);
    });
  });
	
  socket.on('disconnect', function () {
    socket.get('u_id', function (err, u_id) {
    	var dt = new Date();
    	var update_time = dt.getTime();
      lib_user.set_user_info(u_id,'disconnect_time',update_time);
      lib_user.set_user_info(u_id,'connected',0);
      delete connected_users[u_id];
    });
  });
});

function update_user(user, cb){//���»�Ա��������Ϣ
	var u_id = user['u_id'];
	var user_info = {};
	var dt = new Date();
	var update_time = dt.getTime();
	user_info = lib_user.get_user(u_id);
	if ( typeof user_info['u_id'] === "undefined" ) {
		lib_user.set_user(user);
		lib_user.set_user_info(u_id,'update_time',update_time);//�����������ʱ��
		var db_query = ' t_id = '+u_id+' AND r_state = 2';
		db.get_msg_list(db_query,function (list) {//��ʼ��δ����Ϣ
      for (var k in list){
      	list[k]['add_time'] = dateToString(list[k]['add_time']*1000);
      	lib_user.set_msg(u_id,list[k]);
      }
      cb();
    });
	} else {
		lib_user.set_user_info(u_id,'update_time',update_time);//�����������ʱ��
		cb();
	}
}

function dateToString(date) {
  var dt = new Date(date);
  var year   = dt.getFullYear();
  var month  = zeroPad(dt.getMonth() + 1);
  var day    = zeroPad(dt.getDate());
  var hour   = zeroPad(dt.getHours());
  var minute = zeroPad(dt.getMinutes());
  var second = zeroPad(dt.getSeconds());

  return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
}

function zeroPad(number) {
  return (number < 10) ? '0' + number : number;
}