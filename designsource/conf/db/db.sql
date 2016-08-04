/*
MySQL Backup
Source Server Version: 5.6.11
Source Database: designsource
Date: 2016/5/9 15:01:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `admin_admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin_admin`;
CREATE TABLE `admin_admin` (
  `id` varchar(32) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_bulletin`
-- ----------------------------
DROP TABLE IF EXISTS `admin_bulletin`;
CREATE TABLE `admin_bulletin` (
  `id` varchar(32) NOT NULL,
  `message` varchar(10000) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_dictionaries`
-- ----------------------------
DROP TABLE IF EXISTS `admin_dictionaries`;
CREATE TABLE `admin_dictionaries` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `lable` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `sort` varchar(10) DEFAULT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`lable`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典表';

-- ----------------------------
--  Table structure for `admin_help`
-- ----------------------------
DROP TABLE IF EXISTS `admin_help`;
CREATE TABLE `admin_help` (
  `id` varchar(255) NOT NULL,
  `email1` varchar(255) DEFAULT NULL,
  `email2` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `weixin` varchar(255) DEFAULT NULL,
  `weibo` varchar(255) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `parent_ids` varchar(255) DEFAULT NULL,
  `sort` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `is_show` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_role_admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_admin`;
CREATE TABLE `admin_role_admin` (
  `id` varchar(32) NOT NULL,
  `admin_id` varchar(32) DEFAULT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL,
  `menu_id` varchar(32) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_sentence`
-- ----------------------------
DROP TABLE IF EXISTS `admin_sentence`;
CREATE TABLE `admin_sentence` (
  `id` varchar(32) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `words` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_authentication`
-- ----------------------------
DROP TABLE IF EXISTS `tx_authentication`;
CREATE TABLE `tx_authentication` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(255) NOT NULL DEFAULT '' COMMENT '用户id',
  `auth_img_url` varchar(255) NOT NULL COMMENT '认证图片地址',
  `status` int(2) DEFAULT NULL COMMENT '未认证1，认证通过2，认证驳回3',
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_autocomplete`
-- ----------------------------
DROP TABLE IF EXISTS `tx_autocomplete`;
CREATE TABLE `tx_autocomplete` (
  `id` varchar(32) NOT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  `like` varchar(500) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_classification`
-- ----------------------------
DROP TABLE IF EXISTS `tx_classification`;
CREATE TABLE `tx_classification` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `parent_ids` varchar(255) DEFAULT NULL,
  `sort` int(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_publish_goods_info`
-- ----------------------------
DROP TABLE IF EXISTS `tx_publish_goods_info`;
CREATE TABLE `tx_publish_goods_info` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `show_img_url` varchar(255) DEFAULT NULL COMMENT '展示图片url',
  `classification_id` varchar(255) DEFAULT NULL COMMENT '分类id',
  `classification_name` varchar(255) DEFAULT NULL COMMENT '冗余字段，方便搜索',
  `price` double DEFAULT NULL COMMENT '参考价格',
  `user_id` varchar(32) DEFAULT NULL COMMENT '所属用户',
  `descriptions` varchar(10000) DEFAULT NULL,
  `status` int(10) DEFAULT NULL COMMENT '信息状态 1正常，2不正常',
  `collection_total` bigint(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_slider_view`
-- ----------------------------
DROP TABLE IF EXISTS `tx_slider_view`;
CREATE TABLE `tx_slider_view` (
  `id` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `descriptions` varchar(255) DEFAULT NULL,
  `button_value` varchar(255) DEFAULT NULL,
  `button_href` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_user`
-- ----------------------------
DROP TABLE IF EXISTS `tx_user`;
CREATE TABLE `tx_user` (
  `id` varchar(32) NOT NULL,
  `loginname` varchar(255) DEFAULT NULL COMMENT '登录名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像的url',
  `card_id` varchar(32) DEFAULT NULL COMMENT '学号',
  `username` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别（男1，女2）',
  `qq` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `email` varchar(255) DEFAULT NULL,
  `email_checked` tinyint(255) DEFAULT NULL COMMENT '邮箱是否验证',
  `status` int(255) DEFAULT NULL COMMENT '用户状态（未认证1，待认证2，认证通过3，认证驳回4，黑名单5）',
  `remarks` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tx_user_collection`
-- ----------------------------
DROP TABLE IF EXISTS `tx_user_collection`;
CREATE TABLE `tx_user_collection` (
  `user_id` varchar(32) NOT NULL,
  `goods_id` varchar(32) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `admin_admin` VALUES ('00000','root','d48f8e534d537635a3ac63f4e385e80915c55f5b24120f14c27f0a22','Apache Tomcat','1','17080038082','681a1f818ed7445e852c89a9feb34371',NULL,NULL,'2000-01-07 15:47:35'), ('00001','admin','ba50e4197de1c859916cc960e1b4614e6e8624f8430c99739b1fccfe','Administrators','1','','00000',NULL,NULL,'2001-01-07 15:47:35');
INSERT INTO `admin_bulletin` VALUES ('object','<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=\"Arial Black\" color=\"#b56308\">淘学网后台</font></h4>','2016-04-01 00:00:00');
INSERT INTO `admin_dictionaries` VALUES ('1','性别','dict_sex','sex','性别','0','object','00000','2016-03-03 13:54:03',NULL), ('2','男','dict_sex_man','sex','性别：男','0','1','00000','2016-03-03 13:55:03',NULL), ('3','女','dict_sex_women','sex','性别：女','0','1','00000','2016-03-03 13:56:47',NULL), ('4','用户状态','dict_user_type','user_type','用户状态','0','object','00000','2016-03-10 13:52:48',NULL), ('5','未认证','dict_user_type_na','user_type','未认证','0','4','00000','2016-03-10 13:54:25',NULL), ('6','已认证','dict_user_type_ya','user_type','已认证','0','4','00000','2016-03-10 13:55:23',NULL), ('7','黑名单','dict_user_type_ba','user_type','黑名单','0','4','00000','2016-03-10 13:56:10',NULL), ('object','数据字典','dict_object','dict_type_object','数据字典总节点','0','0','00000','2016-03-03 13:45:20','--');
INSERT INTO `admin_help` VALUES ('object','i_fans@outlook.com','if.cn@icloud.com','316217330','zf__931210','http://weibo.com/isOneWords',NULL);
INSERT INTO `admin_menu` VALUES ('002040b3004e4432aaf478be095f673a','分类管理','object','0,object,','30','','1',NULL,'00000','2016-01-13 17:20:39'), ('1ddad87e34da414bbca1d2653e21bde4','发布管理','object','0,object,','20','','1',NULL,'00000','2016-01-13 17:18:52'), ('2e0e4071f8264bafb8f99657deab6114','友言评论管理','cccb30b3f9e4439c9a13081fb573cc6c','0,object,cccb30b3f9e4439c9a13081fb573cc6c,','49','http://www.uyan.cc/sites','1',NULL,'00001','2016-03-23 10:47:32'), ('2f43fc9a125746ff90b823fa5d97eacf','字段设置','systemmanage','0,object,systemmanage,','54','/designsource/admin/system/sentenceRecord','1',NULL,'00000','2016-02-02 13:43:13'), ('3f498269edab4e8f8b1a1ae68f0d2855','公告设置','systemmanage','0,object,systemmanage,','53','/designsource/admin/system/bulletinRecord','1',NULL,'00000','2016-02-02 13:42:44'), ('65d184a27f1a4175a8fb7d94b914486b','会员管理','object','0,object,','10','','1',NULL,'00000','2016-01-13 17:17:45'), ('6d88b30911de437da6e7ac3d97cf09fb','分类信息','002040b3004e4432aaf478be095f673a','0,object,002040b3004e4432aaf478be095f673a,','31','/designsource/admin/classification/record','1',NULL,'00000','2016-01-13 17:21:37'), ('744406801c3a4dd3a63c3dead95df0da','黑名单','65d184a27f1a4175a8fb7d94b914486b','0,object,65d184a27f1a4175a8fb7d94b914486b,','13','/designsource/admin/black/record','1',NULL,'00000','2016-03-13 11:26:14'), ('7df465ae139f4f2086e2f294c3c99cde','垃圾信息','1ddad87e34da414bbca1d2653e21bde4','0,object,1ddad87e34da414bbca1d2653e21bde4,','22','/designsource/admin/rubbishGoods/record','1',NULL,'00000','2016-02-03 10:35:55'), ('8861621f46724148949447ee5bac8094','会员认证','65d184a27f1a4175a8fb7d94b914486b','0,object,65d184a27f1a4175a8fb7d94b914486b,','11','/designsource/admin/auth/record','1',NULL,'00000','2016-03-11 09:49:58'), ('8ad20289370a4a1c96126b7678b0a0a2','数据字典','systemmanage','0,object,systemmanage,','52','/designsource/admin/system/dict/record','0',NULL,'00000','2016-03-03 10:16:00'), ('bda185d876b14ef3b0953d852012d89b','前台管理','object','0,object,','40','','1',NULL,'00000','2016-01-13 17:22:02'), ('cccb30b3f9e4439c9a13081fb573cc6c','评论管理','object','0,object,','48','','1',NULL,'00001','2016-03-23 10:46:58'), ('e475b4ab87ad4b3784cd6ca2f85ad147','会员信息','65d184a27f1a4175a8fb7d94b914486b','0,object,65d184a27f1a4175a8fb7d94b914486b,','12','/designsource/admin/user/record','1',NULL,'00000','2016-01-13 17:18:24'), ('f937b7fbcfdb443d89637f5f64188e3e','首页轮播','bda185d876b14ef3b0953d852012d89b','0,object,bda185d876b14ef3b0953d852012d89b,','41','/designsource/admin/slider/record','1',NULL,'00000','2016-01-13 17:22:17'), ('ffd54c484bc1453ba6039b040a50ac9c','已发布信息','1ddad87e34da414bbca1d2653e21bde4','0,object,1ddad87e34da414bbca1d2653e21bde4,','21','/designsource/admin/goods/record','1',NULL,'00000','2016-01-13 17:20:13'), ('menumanage','菜单管理','shiromanage',NULL,'61','/designsource/admin/shiro/menu/record','1',NULL,NULL,NULL), ('object','♞ 主菜单 ','0','0,','0','','1',NULL,NULL,NULL), ('rolemanage','角色管理','shiromanage','0,object,shiromanage','62','/designsource/admin/shiro/role/record','1',NULL,'00000','2016-01-09 21:02:56'), ('shiromanage','权限管理','object','0,object,','60','','1',NULL,NULL,NULL), ('systemmanage','系统管理','object','0,object,','50','','1',NULL,NULL,NULL), ('systemruninfo','系统运行信息','systemmanage','0,object,systemmanage','55','/designsource/druid/index.html','1',NULL,'00000','2016-01-08 17:22:18'), ('usermanage','用户管理','systemmanage','0,object,systemmanage','51','/designsource/admin/system/admin/record','1',NULL,NULL,NULL);
INSERT INTO `admin_role` VALUES ('00000','开发者','Developer',NULL,NULL), ('681a1f818ed7445e852c89a9feb34371','nohave','','00000','2016-03-02 16:13:06'), ('70f82489b1d44eb1904399cc78e294ff','管理员','Admin','00000','2016-01-14 13:15:45'), ('f5096fb4168a4b7d9138dbed239b4619','系统运维','System Log','00000','2016-01-09 21:24:45');
INSERT INTO `admin_role_admin` VALUES ('kaifazhe-menu','00000','00000','开发者的角色');
INSERT INTO `admin_role_menu` VALUES ('07d02f4be1f04579ae49d33ce0e06582','70f82489b1d44eb1904399cc78e294ff','002040b3004e4432aaf478be095f673a',NULL), ('0fa31aa7322844b09e22011efc1a2fa3','70f82489b1d44eb1904399cc78e294ff','65d184a27f1a4175a8fb7d94b914486b',NULL), ('15ae70b9979c444299151e4e5fe96705','f5096fb4168a4b7d9138dbed239b4619','object',NULL), ('168a9e232b3643d49cde5bcd5a34cdf7','681a1f818ed7445e852c89a9feb34371','65d184a27f1a4175a8fb7d94b914486b',NULL), ('1762b9195aec4c158c9a346f4835e1f0','681a1f818ed7445e852c89a9feb34371','e475b4ab87ad4b3784cd6ca2f85ad147',NULL), ('26442d9f424346c7b88598546e9cf3c6','00000','cccb30b3f9e4439c9a13081fb573cc6c',NULL), ('26532343acfd4f8492909c108a6c5285','f5096fb4168a4b7d9138dbed239b4619','3f498269edab4e8f8b1a1ae68f0d2855',NULL), ('289775f1081940c7a0f1910377aee281','f5096fb4168a4b7d9138dbed239b4619','e475b4ab87ad4b3784cd6ca2f85ad147',NULL), ('298c24dbc1664cae910ed9fb546cdcb4','681a1f818ed7445e852c89a9feb34371','8861621f46724148949447ee5bac8094',NULL), ('2b3f7cef28ef49c9ac509fb5a0e5be88','00000','rolemanage',NULL), ('4189650e9a0b47d4ba83ca103abb912b','00000','systemruninfo',NULL), ('41a4c23d785543819f468827efcc8112','00000','65d184a27f1a4175a8fb7d94b914486b',NULL), ('47b4e27c54824c0db589ea8f9d7b4a87','681a1f818ed7445e852c89a9feb34371','7df465ae139f4f2086e2f294c3c99cde',NULL), ('4a0698c32ea34c62bd7fd41f6e8dd187','681a1f818ed7445e852c89a9feb34371','object',NULL), ('4a22a6cb11894c8096afa74bb73eee06','00000','8ad20289370a4a1c96126b7678b0a0a2',NULL), ('4c8b4d904f4749d08db3872f0a288ba1','70f82489b1d44eb1904399cc78e294ff','ffd54c484bc1453ba6039b040a50ac9c',NULL), ('4db357bbd248459b8bf138c0bfe64b0f','00000','1ddad87e34da414bbca1d2653e21bde4',NULL), ('520ffdfc4e0145c3a0a92605ac0c9ee4','70f82489b1d44eb1904399cc78e294ff','1ddad87e34da414bbca1d2653e21bde4',NULL), ('594adf273b724960b9945e9982c43734','681a1f818ed7445e852c89a9feb34371','744406801c3a4dd3a63c3dead95df0da',NULL), ('5992c76d39844cac975b4fb9358a232e','f5096fb4168a4b7d9138dbed239b4619','systemruninfo',NULL), ('5a41b58ef9244ee18be7873115adcebb','f5096fb4168a4b7d9138dbed239b4619','2f43fc9a125746ff90b823fa5d97eacf',NULL), ('5d73392b9e364624a18ac0f9e0d65aa5','00000','systemmanage',NULL), ('6a30efdadb7941a6bd3a6b552d0b21e9','00000','ffd54c484bc1453ba6039b040a50ac9c',NULL), ('6a95d27f74254305ab613575149c9d84','70f82489b1d44eb1904399cc78e294ff','usermanage',NULL), ('704a798175aa4bc9aea1cd134a41b404','00000','2e0e4071f8264bafb8f99657deab6114',NULL), ('8168cc8e3e26480bba2e849c1340897e','70f82489b1d44eb1904399cc78e294ff','f937b7fbcfdb443d89637f5f64188e3e',NULL), ('84ea390b8ca44c6388e7645708210a4b','00000','7df465ae139f4f2086e2f294c3c99cde',NULL), ('851cccc9c73c441d9b185cc7031b51f3','00000','002040b3004e4432aaf478be095f673a',NULL), ('86eb19832dc341aab3f45f4db85443ed','00000','bda185d876b14ef3b0953d852012d89b',NULL), ('91f0246b1ff4495d8afc839a130500ff','70f82489b1d44eb1904399cc78e294ff','6d88b30911de437da6e7ac3d97cf09fb',NULL), ('96da514784624208b369e4f522ee4a2e','70f82489b1d44eb1904399cc78e294ff','e475b4ab87ad4b3784cd6ca2f85ad147',NULL), ('a63968dd73774cd3a172303012257b73','f5096fb4168a4b7d9138dbed239b4619','65d184a27f1a4175a8fb7d94b914486b',NULL), ('a7c4072833804400a68424c72b737b44','00000','menumanage',NULL), ('a91dc54217a04e389508d950b3041438','00000','f937b7fbcfdb443d89637f5f64188e3e',NULL), ('aa4b323aa6ec4853949fffb476b28d92','70f82489b1d44eb1904399cc78e294ff','object',NULL), ('aee25a36c9bb40ed86b8b6fd97c2eef4','70f82489b1d44eb1904399cc78e294ff','bda185d876b14ef3b0953d852012d89b',NULL), ('b71f5546fc1848fd9ec1689b405fb5d0','00000','6d88b30911de437da6e7ac3d97cf09fb',NULL), ('bccfa1d2c7f4472a927decf5b83b214f','681a1f818ed7445e852c89a9feb34371','ffd54c484bc1453ba6039b040a50ac9c',NULL), ('d33b64b148e348cf9b405eae47b77530','00000','744406801c3a4dd3a63c3dead95df0da',NULL), ('d6fdfa3b992f4ccd8109b4a0e602dba4','00000','shiromanage',NULL), ('d7aad1c294bd4f59895d065ceeee3951','00000','8861621f46724148949447ee5bac8094',NULL), ('dc952f5a25b44ac48136727030f2334a','70f82489b1d44eb1904399cc78e294ff','systemruninfo',NULL), ('df283bae4b064bc4991dbb34f56ce703','00000','usermanage',NULL), ('dfb4e1b7284340c8a51d1d0aaabc2890','70f82489b1d44eb1904399cc78e294ff','systemmanage',NULL), ('e482d23b6991437287585da787d5dd08','00000','2f43fc9a125746ff90b823fa5d97eacf',NULL), ('ea568248b2464c7c84dacddda697391f','f5096fb4168a4b7d9138dbed239b4619','systemmanage',NULL), ('f34927e9bbb442fbbddb72e45929b438','681a1f818ed7445e852c89a9feb34371','1ddad87e34da414bbca1d2653e21bde4',NULL), ('f643933676fd40ce92a8af545b001c11','00000','object',NULL), ('f68ba74cc8a64d059a47cd09d88bdf3e','00000','3f498269edab4e8f8b1a1ae68f0d2855',NULL), ('f82e942cfefd4b0d80e8174a066d5cfd','00000','e475b4ab87ad4b3784cd6ca2f85ad147',NULL);
INSERT INTO `admin_sentence` VALUES ('object','一碗鸡汤','梦想还是要有的，万一实现了呢？','马云');
INSERT INTO `tx_authentication` VALUES ('4953861ff06b447682f5c695fae92a80','e4e443207c164dc9881c244981386f20','e4e443207c164dc9881c244981386f20.png','2','2016-04-24 19:41:19');
INSERT INTO `tx_autocomplete` VALUES ('0','手机','iPhone,苹果,三星,小米,魅族,华为,国产手机','1'), ('1','电脑','笔记本,台式电脑,戴尔,华硕,宏基,三星,苹果','2'), ('2','学习资料','英语四级,英语八级,计算机等级考试,高数,Java,JavaScript,c#,.net,c,c++','3');
INSERT INTO `tx_classification` VALUES ('021451fff38d43c1936ce6066f157c0f','三星','b07ac90d937a40c28183e064cca0bb10','0,0bca56c7fe9e45d5a3283fadb0b3e0f5,b07ac90d937a40c28183e064cca0bb10,','3120','','00001','2016-03-18 16:23:00',NULL), ('08dd504500e0452b85dcac23bfe20b40','日用品','80a332b7441740da922449515a443ed4','0,80a332b7441740da922449515a443ed4,','100','','00001','2016-03-18 16:20:41',NULL), ('0bca56c7fe9e45d5a3283fadb0b3e0f5','数码','0','0,','2000','goodsList','00001','2016-03-18 16:20:03',NULL), ('0d13f4230d7e47548ef2316845bfaba4','书籍','b95e032e3baf4196ae322767bf7941d8','0,b95e032e3baf4196ae322767bf7941d8,','1200','','00001','2016-03-18 16:21:38',NULL), ('1315a1eec78a450fb18f1c999a8d1fe9','魅族','b07ac90d937a40c28183e064cca0bb10','0,0bca56c7fe9e45d5a3283fadb0b3e0f5,b07ac90d937a40c28183e064cca0bb10,','3130','','00001','2016-03-21 12:57:52',NULL), ('33e3331ae84b49dfb410cab719de0228','苹果','b07ac90d937a40c28183e064cca0bb10','0,0bca56c7fe9e45d5a3283fadb0b3e0f5,b07ac90d937a40c28183e064cca0bb10,','3110','','00001','2016-03-18 16:22:41',NULL), ('80a332b7441740da922449515a443ed4','生活','0','0,','0','goodsList','00001','2016-03-18 16:19:37',NULL), ('84b87d63426a4474af429dba04da6f90','考试','b95e032e3baf4196ae322767bf7941d8','0,b95e032e3baf4196ae322767bf7941d8,','1100','','00001','2016-03-18 16:21:18',NULL), ('b07ac90d937a40c28183e064cca0bb10','手机','0bca56c7fe9e45d5a3283fadb0b3e0f5','0,0bca56c7fe9e45d5a3283fadb0b3e0f5,','3100','','00001','2016-03-18 16:21:51',NULL), ('b95e032e3baf4196ae322767bf7941d8','学习','0','0,','1000','goodsList','00001','2016-03-18 16:19:51',NULL), ('bdaf125369e84772aad523565e62ff3b','精品物件','80a332b7441740da922449515a443ed4','0,80a332b7441740da922449515a443ed4,','200','','00001','2016-03-18 16:21:04',NULL), ('e01c8baf5db242b89d59067dc8f3ed1f','电脑','0bca56c7fe9e45d5a3283fadb0b3e0f5','0,0bca56c7fe9e45d5a3283fadb0b3e0f5,','3200','','00001','2016-03-18 16:22:15',NULL);
INSERT INTO `tx_publish_goods_info` VALUES ('0e9866a5c15c461b8f495e5f27726635','脸盆','拿去洗脚','0e9866a5c15c461b8f495e5f27726635.png','08dd504500e0452b85dcac23bfe20b40','日用品','5','e4e443207c164dc9881c244981386f20','<p>脸盆一对</p>','1','1',NULL,NULL,'2016-04-23 00:51:55'), ('1149c18fecdb47f8af9a0559f41ac12d','洗发水','用飘柔 更自信','1149c18fecdb47f8af9a0559f41ac12d.png','08dd504500e0452b85dcac23bfe20b40','日用品','5','38236e46be734a678e5f2cd40fd3c0d2','<p>勤洗头&nbsp;</p>','1','0',NULL,NULL,'2016-04-30 18:26:50'), ('24d57b8635ef4d559d610508e450383f','iPhone 6s','国行16G 6S 诚信出售','24d57b8635ef4d559d610508e450383f.png','33e3331ae84b49dfb410cab719de0228','苹果','5000','e4e443207c164dc9881c244981386f20','<p><br></p><p>&nbsp; &nbsp; <font color=\"#6ba54a\"><b>唯一不同是处处不同！</b></font><br></p>','1','2',NULL,NULL,'2016-04-06 16:00:53'), ('4ca72dd2841a4400b306a265e618b972','高数笔记','高数笔记总结，留给学弟，千万别挂科','4ca72dd2841a4400b306a265e618b972.png','0d13f4230d7e47548ef2316845bfaba4','书籍','10','e4e443207c164dc9881c244981386f20','<p>知识是无价的，高数笔记总结，留给学弟，千万别挂科<br></p>','1','1',NULL,NULL,'2016-04-18 19:46:01'), ('89d80df9214a474b8ff1b72b8b1dbb00','四级试卷','四级没过的来看看','89d80df9214a474b8ff1b72b8b1dbb00.png','84b87d63426a4474af429dba04da6f90','考试','5','e4e443207c164dc9881c244981386f20','<p><span style=\"background-color: rgb(255, 255, 0);\"><font color=\"#104a5a\">八级不是梦！</font></span></p>','1','0',NULL,NULL,'2016-04-27 21:35:11'), ('9a38865fb67d49899d4ad5c519effac8','杜月笙','杜月笙 传记','9a38865fb67d49899d4ad5c519effac8.png','0d13f4230d7e47548ef2316845bfaba4','书籍','5','8da23a3115854e08861de7c4bca547d2','厚黑教主，上海滩大哥，杜月笙传奇传记','1','0',NULL,NULL,'2016-04-27 21:41:42'), ('b83997d40b92466bb9041319db91e342','戴尔笔记本','好东西当然留给学弟学妹','b83997d40b92466bb9041319db91e342.png','e01c8baf5db242b89d59067dc8f3ed1f','电脑','2000','e4e443207c164dc9881c244981386f20','<h2 style=\"font-size: 16px; padding-top: 5px; padding-bottom: 5px; font-weight: 600; font-family: Arial, Helvetica, sans-serif; font-style: normal; font-variant: normal;\"><span style=\"background-color: rgb(0, 0, 0);\"><font color=\"#ffe7ce\">Inspiron 7000系列（7447）</font></span></h2><p class=\"oc\" style=\"list-style: none; line-height: 18px; font-size: 12px; font-family: Arial; font-style: normal; font-variant: normal; font-weight: normal;\"><span style=\"background-color: rgb(0, 0, 0);\"><font color=\"#ffe7ce\">Ins14PD-4548B&nbsp;<span style=\"padding-left: 10px;\">基础黑</span></font></span></p><ul style=\"padding-top: 5px; padding-bottom: 5px; line-height: 18px; font-family: Arial, Helvetica, sans-serif; font-size: 12px;\"><li style=\"list-style: none; font-family: Arial;\"><span style=\"background-color: rgb(0, 0, 0);\"><font color=\"#ffe7ce\">• 第四代智能英特尔<sup style=\"line-height: 13px; font-size: 13px;\">®</sup>&nbsp;酷睿™ i5-4210H 处理器</font></span></li><li style=\"list-style: none; font-family: Arial;\"><span style=\"background-color: rgb(0, 0, 0);\"><font color=\"#ffe7ce\">• Windows 10 家庭版</font></span></li><li style=\"list-style: none; font-family: Arial;\"><span style=\"background-color: rgb(0, 0, 0);\"><font color=\"#ffe7ce\">• 4GB内存 / 500GB硬盘 / 4GB显卡</font></span></li></ul>','1','2',NULL,NULL,'2016-04-27 14:25:02'), ('f5229583c90140e287523b8c127c256d','暖壶','暖壶一对，配了学姐四年','f5229583c90140e287523b8c127c256d.png','08dd504500e0452b85dcac23bfe20b40','日用品','5','8da23a3115854e08861de7c4bca547d2','<p>不贵 便宜卖</p>','1','2',NULL,NULL,'2016-04-18 19:41:26'), ('fc309e3b850a4f89abb171d5ded0cbb2','烟灰缸','水晶烟灰缸','fc309e3b850a4f89abb171d5ded0cbb2.png','bdaf125369e84772aad523565e62ff3b','精品物件','10','e4e443207c164dc9881c244981386f20','我爷爷抽烟，我爸也抽烟，到我这里不能断了香火','1','0',NULL,NULL,'2016-04-27 21:31:08'), ('ff4854e741914fa9936d758f08095b89','小音响','便宜甩小音箱','ff4854e741914fa9936d758f08095b89.png','0bca56c7fe9e45d5a3283fadb0b3e0f5','数码','10','e4e443207c164dc9881c244981386f20','好音效，好成色','1','0',NULL,NULL,'2016-04-27 13:06:17');
INSERT INTO `tx_slider_view` VALUES ('a','淘学网 上线啦!','塔里木大学自己的跳蚤市场，马上毕业了，好多东西舍不得扔，怎么办？你是一个购物狂，好多东西买回来用不上，怎么办？来淘学网，发布你不想要的东西，等土豪来找你!','come on','/goodsList?sort=default',NULL,NULL,NULL), ('b','毕业季 留下点什么','青春 继续，传承 就是这么简单！','shop now','/goodsList?sort=default',NULL,NULL,NULL);
INSERT INTO `tx_user` VALUES ('38236e46be734a678e5f2cd40fd3c0d2','zhang','28f92bf61b96fbbd0271ccd99fe1b870680b18c622a167a4bfa30e3e','default_avatar.png',NULL,'iFan',NULL,NULL,'807095171','17080038082',NULL,'0','1',' 123',NULL,'2016-04-30 18:19:52'), ('8da23a3115854e08861de7c4bca547d2','gaotengyu','46c53450d0a05c7a7f95f0746ca93f62a5a9419bf9d0af010df29ea6','8da23a3115854e08861de7c4bca547d2.png',NULL,'高腾玉',NULL,NULL,'291043301','15559466867','316217330@qq.com','1','1','我是小高 ',NULL,'2016-04-18 19:38:55'), ('c7d2238f24364065b58e11af6765babf','liujun','5f6aa0d732fe27a270db9c16fdb2cb26f3fb2e74f8d9be560da7d788','default_avatar.png',NULL,'刘俊',NULL,NULL,'316217330','12312341234',NULL,'0','1',' 123',NULL,'2016-04-27 14:35:52'), ('c83ec005ea814da0bfbc20b8ca6825f4','forgetpwd','1cf4f5ea961ad55a500c7acbd28da91d8cc34e437902bf54ec2d7d16','default_avatar.png',NULL,'forgetpwd',NULL,NULL,'316217330','forgetpwd','316217330@qq.com','1','1',' forgetpwd',NULL,'2016-04-15 12:23:07'), ('e4e443207c164dc9881c244981386f20','zhangfan','1b52170b12c588ad752103da43e1bf4e7241a335f6eb3f2eb3ba2363','e4e443207c164dc9881c244981386f20.png','5011212608','张帆','张帆','1','316217330','17080038082','316217330@qq.com','1','3','no ',NULL,'2016-04-06 13:53:29');
INSERT INTO `tx_user_collection` VALUES ('8da23a3115854e08861de7c4bca547d2','0e9866a5c15c461b8f495e5f27726635','2016-04-27 14:34:35'), ('8da23a3115854e08861de7c4bca547d2','24d57b8635ef4d559d610508e450383f','2016-04-27 14:33:56'), ('8da23a3115854e08861de7c4bca547d2','4ca72dd2841a4400b306a265e618b972','2016-04-27 14:34:25'), ('8da23a3115854e08861de7c4bca547d2','b83997d40b92466bb9041319db91e342','2016-04-27 14:33:45'), ('c7d2238f24364065b58e11af6765babf','24d57b8635ef4d559d610508e450383f','2016-04-27 14:36:02'), ('c7d2238f24364065b58e11af6765babf','b83997d40b92466bb9041319db91e342','2016-04-27 14:35:58'), ('c7d2238f24364065b58e11af6765babf','f5229583c90140e287523b8c127c256d','2016-04-27 14:38:19'), ('e4e443207c164dc9881c244981386f20','f5229583c90140e287523b8c127c256d','2016-04-27 14:35:04');
