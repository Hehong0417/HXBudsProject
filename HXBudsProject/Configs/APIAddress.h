//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//


//#ifdef DEBUG
//// 本地
#define API_HOST @"http://192.168.0.109:8080"
// 本地图片
#define API_IMAGE_HOST @"http://192.168.0.109:8080/html/goaling/images/upload/task"
//
//#define API_IMAGE_HOST @"http://192.168.0.89:8080/"
//#define API_IMAGE_HOST @"http://192.168.0.89:7080/"

#define APP_key @"59334e721bcd31"
#define APP_scode @"15ca7554e8cb486f3b8cbe1fa166c75b"// [NSString md5:[APP_key stringByAppendingString:@"trans"]]

//MD5加密（APP_key+”weicai”）
#define API_APP_BASE_URL @"goaling"
#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]

#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

//接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

//图片
#define kAPIImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define video_testUrl @"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"


/**
 *  登录注册
 */

//1.4手机（账号）唯一性验证
#define API_CHECK_PHONE API_SUB_URL(@"users/getAcc")//*
//1.1注册
#define API_REGISTER API_SUB_URL(@"users/add")//*
//1.3登录
#define API_LOGIN API_SUB_URL(@"users/login")//*
//1.3判断是否已登录
#define API_IS_LOGIN API_SUB_URL(@"users/isLogin")

//1.获取验证码
#define API_GET_VERIFY_CODE API_SUB_URL(@"users/sms")//*



//1.2找回密码（重置）
#define API_GET_BACK_PWD API_SUB_URL(@"user/getBackPwd.do")


//1.5QQ绑定手机号
#define API_BIND_QQ API_SUB_URL(@"user/bindQQ.do")
//1.6微信绑定手机号
#define API_BIND_WEIXIN API_SUB_URL(@"user/bindWeixin.do")
//1.7获取短信验证码
#define API_VERIFY_CODE API_SUB_URL(@"user/verifyCode.do")
//1.9根据经纬度获取配送点列表
#define API_GET_SEND_POINT_BY_XY API_SUB_URL(@"user/getSendPointByXY.do")
/**
 *  首页
 */
//2.1获取轮播图
#define API_GET_LIST_anon  API_SUB_URL(@"advertisement/list_anon")//*
//2.2老师列表
#define API_GET_TEACHER_LIST  API_SUB_URL(@"theteacher/list_anon")//*

//2.2 专题视频、个人主页（视频）
#define API_GET_CURRICULUM  API_SUB_URL(@"curriculum/list_anon")//*

//2.3 文章、个人主页（文章）、我的文章
#define API_GET_ARTICLE  API_SUB_URL(@"article/list_anon")//*


//5.1 获取教师详情
#define API_GET_TEACHER_DDETAIL API_SUB_URL(@"theteacher/detail_anon")//*

//5.2 关注
#define API_GET_FOLLOW_TEACHER API_SUB_URL(@"followteacher/add")


/**
 *  文章
 */
//2.3 文章详情
#define API_GET_ARTICLE_DETAIL  API_SUB_URL(@"article/detail_anon")

#define API_GET_UPLOAD_IMAGE  API_SUB_URL(@"article/media_upload")



/**
 *  发布文章
 */



/**
 *  视频
 */

//5.3 教程视频详情简介
#define API_GET_CURRICULUM_DETAIL  API_SUB_URL(@"curriculum/detail_anon")//*
//5.4 教程视频详情目录
#define API_GET_VIDEO_LIST  API_SUB_URL(@"videos/list_anon")//*
//5.5 教程视频评论列表
#define API_GET_REVIEW_LIST  API_SUB_URL(@"curriculumreview/list_anon")
//5.6 添加教程评论
#define API_GET_REVIEW_ADD  API_SUB_URL(@"curriculumreview/add")//*
//5.7 加入学习
#define API_GET_SUBSCRIBE_ADD  API_SUB_URL(@"subscribe/add")
//5.8 评论点赞
#define API_GET_SPOTFABULOUS  API_SUB_URL(@"curriculumreview/spotFabulous")

/**
 *  我的
 */
//6.1获取我的资料信息
#define API_GET_USER_SIMPLE_INFO API_SUB_URL(@"userElse/getUserSimpleInfo.do")
//6.2 修改头像
#define API_UPDATE_ICO API_SUB_URL(@"userElse/updateIco.do")
//6.3修改昵称
#define API_UPDATE_USER_NAME API_SUB_URL(@"userElse/updateUserName.do")
//6.4 获取积分明细列表
#define API_GET_SCORE_LIST API_SUB_URL(@"userElse/getScoreList.do")
//6.5 修改密码
#define API_UPDATE_PWD API_SUB_URL(@"userElse/updatePwd.do")
//6.6获取我的收藏列表
#define API_GET_COLLECT_LIST API_SUB_URL(@"userElse/getCollectList.do")
//6.25提交反馈意见
#define API_SEND_SUGGEST API_SUB_URL(@"userElse/sendSuggest.do")
//6.43 QQ或者微信绑定手机号
#define API_BINDING  API_SUB_URL(@"userElse/binding.do")
//6.44获取我的消息列表（新加）
#define API_GET_MY_MESSAGE_LIST API_SUB_URL(@"userElse/getMyMessageList.do")
//6.45删除我的消息（新加）
#define API_DELETE_MYMESSAGE_BY_ID API_SUB_URL(@"userElse/deleteMyMessageById.do")
//6.51免责声明
#define API_GET_STATE_MENT  API_SUB_URL(@"userElse/getStatement.do")
//6.54使用说明
#define API_GET_INSTRUCTIONS  API_SUB_URL(@"userElse/instructions.do")

//七、支付
//7.1支付订单
#define API_GET_PAY_CHARGE  API_SUB_URL(@"alipay/getPayCharge.do")
//7.2支付组团订单
#define API_PAY_INDENT  API_SUB_URL(@"userElse/payIndent.do")
