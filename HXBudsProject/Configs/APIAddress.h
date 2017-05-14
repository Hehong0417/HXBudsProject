//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//


//#ifdef DEBUG
//// 本地
#define API_HOST @"http://192.168.0.128:8080"
// 本地图片
#define API_IMAGE_HOST @"http://192.168.0.128:8080/html/goaling/images/upload/task"
//老师头像图片
#define API_Teacher_IMAGE_HOST @"http://192.168.0.128:8080/html/goaling/images/theteacher"
//用户头像图片
#define API_User_IMAGE_HOST @"http://192.168.0.128:8080"

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
//老师头像
#define kAPITeacherImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_Teacher_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//用户头像
#define kAPIUserImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_User_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]



#define video_testUrl @"http://1253712797.vod2.myqcloud.com/e8f61ed3vodtransgzp1253712797/863fe8399031868222929787287/f0.f20.mp4"

#import "HJUser.h"

//
#define article_detail_url  @"http://192.168.0.110/my/menya/Mengya/"


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
//1.3微信登录
#define API_WX_LOGIN API_SUB_URL(@"users/wxlogin")
//1.获取验证码
#define API_GET_VERIFY_CODE API_SUB_URL(@"users/sms")//*
//1.2忘记密码
#define API_GET_FORGET_PWD API_SUB_URL(@"users/forgetPwd")
//1.2修改密码
#define API_GET_EDIT_PWD API_SUB_URL(@"users/editPwd")




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
#define API_GET_FOLLOW_TEACHER API_SUB_URL(@"followteacher/add")//*

//机构列表
#define API_mechanism_list API_SUB_URL(@"mechanism/list_anon")
//机构详情
#define API_mechanism_detail API_SUB_URL(@"mechanism/detail_anon")
//师资团队
#define API_teacherteam_list API_SUB_URL(@"teacherteam/list_anon")
//关注机构
#define API_followmechanism_add API_SUB_URL(@"followmechanism/add")


/**
 *  文章
 */
//2.3 文章详情
#define API_GET_ARTICLE_DETAIL  API_SUB_URL(@"article/detail_anon")
//2.3 上传图片
#define API_GET_UPLOAD_IMAGE  API_SUB_URL(@"article/media_upload")
//2.4文章类型列表
#define API_GET_ARTICLE_TYPE  API_SUB_URL(@"articletype/list_anon")

//2.4收藏文章
#define API_collectionarticle API_SUB_URL(@"collectionarticle/add")

//2.4.添加文章评论
#define API_articlereview_add API_SUB_URL(@"articlereview/add")





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
#define API_GET_REVIEW_LIST  API_SUB_URL(@"curriculumreview/list_anon")//*
//5.6 添加教程评论
#define API_GET_REVIEW_ADD  API_SUB_URL(@"curriculumreview/add")//*
//5.7 加入学习
#define API_GET_SUBSCRIBE_ADD  API_SUB_URL(@"subscribe/add")//*
//5.7 是否加入学习
#define API_collectioncurriculum_isAdd  API_SUB_URL(@"collectioncurriculum/isAdd")//*
//5.8 评论点赞
#define API_GET_SPOTFABULOUS  API_SUB_URL(@"curriculumreview/spotFabulous")


//5.8 课程模糊查询
//API_GET_CURRICULUM接口（curr_title，teachingtype_id）

//5.8 课程类型
#define API_GET_teachingtype API_SUB_URL(@"teachingtype/list_anon")



/**
 *  我的
 */
//6.1获取我的资料信息
#define API_GET_USER_INFO API_SUB_URL(@"userdetails/initEdit")
//6.1修改我的资料信息
#define API_GET_USER_SIMPLE_INFO API_SUB_URL(@"userdetails/edit")
//6.1用户头像上传
#define API_media_upload API_SUB_URL(@"userdetails/media_upload")
//2.4交易记录
#define API_GET_TRANSACTION  API_SUB_URL(@"consumption/list_anon")
//2.4关注的老师列表
#define API_GET_followTheteacher  API_SUB_URL(@"myinformation/followTheteacher")
//2.4关注的用户列表
#define API_GET_followUsers  API_SUB_URL(@"myinformation/followUsers")
//2.4浏览文章记录
#define API_GET_browseArticle  API_SUB_URL(@"myinformation/browseArticle")
//2.4浏览教程记录
#define API_GET_browseCourse API_SUB_URL(@"myinformation/browseCourse")
//2.4我的资产
#define API_GET_myAsset API_SUB_URL(@"myinformation/myAsset")

//2.4申请提现
#define API_GET_withdrawals API_SUB_URL(@"withdrawals/add")



//2.4系统通知
#define API_systemnotification API_SUB_URL(@"systemnotification/list_anon")
//2.4意见反馈
#define API_feedback API_SUB_URL(@"feedback/add")


//七、支付
//2.4.赞赏
#define API_appreciation_add API_SUB_URL(@"appreciation/add")
//2.4.购买课程
#define API_purchaseCourse_add API_SUB_URL(@"purchasecourse/add")
//7.1微信支付
#define API_GET_PAY_CHARGE  API_SUB_URL(@"app/wxtopay/wxtopay_anon")

