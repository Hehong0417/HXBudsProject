//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//


//#ifdef DEBUG
//// 本地
//#define API_HOST @"http://192.168.0.11:8090"
//// 本地图片
//#define API_IMAGE_HOST @"http://192.168.0.11:7080/"
//
//#define API_IMAGE_HOST @"http://192.168.0.89:8080/"
//#define API_IMAGE_HOST @"http://192.168.0.89:7080/"

#define APP_key @"59334e721bcd31"
#define APP_scode @"15ca7554e8cb486f3b8cbe1fa166c75b"// [NSString md5:[APP_key stringByAppendingString:@"trans"]]

//MD5加密（APP_key+”weicai”）
#define API_APP_BASE_URL @"maicai"
#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]
#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

// 接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

// 图片
#define kAPIImageFromUrl(url) [[NSString stringWithFormat:@"%@%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define video_testUrl @"http://yycloudvod2109130935.bs2dl.yy.com/djhmZjcyZTExZDRiZmY1Yzg0NzhlM2Q5MWVjZjRhYzY1MTUzNDQxMjM1Mg"



/**
 *  登录注册
 */
//2.1注册
#define API_REGISTER API_SUB_URL(@"user/register.do")
//2.2找回密码（重置）
#define API_GET_BACK_PWD API_SUB_URL(@"user/getBackPwd.do")
//2.3登录
#define API_LOGIN API_SUB_URL(@"user/login.do")
//2.4手机（账号）唯一性验证
#define API_CHECK_PHONE API_SUB_URL(@"user/checkPhone.do")
//2.5QQ绑定手机号
#define API_BIND_QQ API_SUB_URL(@"user/bindQQ.do")
//2.6微信绑定手机号
#define API_BIND_WEIXIN API_SUB_URL(@"user/bindWeixin.do")
//2.7获取短信验证码
#define API_VERIFY_CODE API_SUB_URL(@"user/verifyCode.do")
//2.9根据经纬度获取配送点列表
#define API_GET_SEND_POINT_BY_XY API_SUB_URL(@"user/getSendPointByXY.do")
/**
 *  首页
 */
//3.1获取城市列表
#define API_GET_CITY_LIST API_SUB_URL(@"user/getCityList.do")
//3.2根据城市获取区域列表
#define API_GET_AREA_LIST API_SUB_URL(@"user/getAreaList.do")
//3.3根据区域获取配送点列表
#define API_GET_SEND_POINT_LIST API_SUB_URL(@"user/getSendPointList.do")
//3.4获取首页信息
#define API_GET_HOME_INFO API_SUB_URL(@"home/getHomeInfo.do")
//3.5获取团购信息列表
#define API_GET_GROUP_LIST_API  API_SUB_URL(@"home/getGrouponList.do")
//3.3团购信息详情
#define API_GET_GROUP_DATAIL  API_SUB_URL(@"home/getGrouponDetail.do")
//3.7收藏/取消收藏团购(新加)
#define API_GROUP_COLLECT  API_SUB_URL(@"home/groupCollect.do")
//3.8加入团购（新加）
#define API_JOIN_GROUP API_SUB_URL(@"home/joinGroup.do")
//3.4厨艺节目列表
#define API_COOKING_SHOW_LIST API_SUB_URL(@"home/cookingShowList.do")
//3.5厨艺节目详情
#define API_COOKING_SHOW_INFO API_SUB_URL(@"home/cookingShowInfo.do")
//3.9个人厨艺节目收藏列表
#define API_GET_Video_COLLECT_LIST API_SUB_URL(@"home/getCollectList.do")
//3.10获取我的团购收藏列表
#define API_GET_GROUP_COLLECT_LIST API_SUB_URL(@"home/getGroupCollectList.do")
//3.11保存配送端ID
#define API_SAVE_SEND_POINTID API_SUB_URL(@"home/saveSendPointId.do")
//3.12商品&套餐&团购描述
#define API_GET_GOODS_DESCRIBE API_SUB_URL(@"home/getGoodsDescribe.do")
//3.13检查配送点Id
#define API_CHECK_SPOINT_ID API_SUB_URL(@"home/checkSpointId.do")


/**
 *  分类
 */
//4.1获取商品种类列表
#define API_GET_GOODS_TYPE_LIST API_SUB_URL(@"classify/getGoodsTypeList.do")
//4.2根据商品种类获取商品列表
#define API_GET_GOODS_LIST_BY_TYPE API_SUB_URL(@"classify/getGoodsListByType.do")
//4.3获取商品详情
#define API_GET_GOODS_INFO API_SUB_URL(@"classify/getGoodsInfo.do")
//4.4收藏商品
#define API_COLLECT_GOODS API_SUB_URL(@"classify/collectGoods.do")
//4.5取消收藏商品
#define API_CANCEL_COLLECT_GOODS API_SUB_URL(@"classify/cancelCollectGoods.do")
//4.8发起团购
#define API_CREATE_GROUP API_SUB_URL(@"classify/createGroup.do")
//4.9获取热门搜索列表
#define API_GET_HOT_SEARCH_LIST API_SUB_URL(@"classify/getHotSearchList.do")
//4.10搜索商品
#define API_SEARCH_GOODS API_SUB_URL(@"classify/searchGoods.do")
//4.11获取单个商品的套餐详情
#define API_GET_SUITS_INFO API_SUB_URL(@"classify/getSuitsInfo.do")
//4.12获取一种套餐详情（新加）
#define API_GET_SUITS_BYID API_SUB_URL(@"classify/getSuitsInfoById.do")
//4.13收藏套餐
#define API_COLLECT_SUIT API_SUB_URL(@"classify/collectSuit.do")

//五、购物车
//5.1获取我的购物车列表
#define API_GET_SHP_LIST API_SUB_URL(@"shopCart/getShoList.do")
//5.3一种商品加入购物车（新加）
#define API_ADD_SHO API_SUB_URL(@"shopCart/addSho.do")
//5.6编辑购物车所有记录（新加）
#define API_EDIT_SHO API_SUB_URL(@"shopCart/editSho.do")
//5.6进入结算页面(准备下单)
#define API_PREINDENT API_SUB_URL(@"shopCart/preIndent.do")
//5.7购物车下单
#define API_INDENT_GOODS_SHO API_SUB_URL(@"shopCart/indentGoodsSho.do")
//六 我的资料
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
//6.7获取我的优惠券列表
#define API_GET_MY_COUPON_LIST API_SUB_URL(@"userElse/getMyCouponList.do")
//6.8批量删除优惠券
#define API_DELETE_COUPON API_SUB_URL(@"userElse/deleteCoupon.do")
//6.8批量删除收藏
#define API_DELETE_COLLECT API_SUB_URL(@"userElse/deleteCollect.do")
//6.9获取我的普通订单列表
#define API_GET_INDENT_LIST API_SUB_URL(@"userElse/getIndentList.do")
//6.10获取我的单个普通订单信息
#define API_GET_INDENT API_SUB_URL(@"userElse/getIndent.do")
//6.11取消订单
#define API_CANCEL_INDENT API_SUB_URL(@"userElse/cancelIndent.do")
//6.12确认收货
#define API_UPDATE_INDENT_STATE API_SUB_URL(@"userElse/updateIndentState.do")

//6.13申请订单售后
#define API_APPLY_SALE_SERVICE API_SUB_URL(@"userElse/applySaleService.do")
//6.14删除订单
#define API_DELETE_INDENT API_SUB_URL(@"userElse/deleteIndent.do")
//6.15获取我的组团订单列表
#define API_GET_MY_GROUP_INDENT_LIST API_SUB_URL(@"userElse/getMyGroupIndentList.do")
//6.16获取我的组团订单详情
#define API_GET_MY_GROUP_INDENT API_SUB_URL(@"userElse/getMyGroupIndent.do")
//6.16获取我的组团订单详情
#define API_GET_MY_GROUP_INDENT API_SUB_URL(@"userElse/getMyGroupIndent.do")

//6.17取消组团订单
#define API_CANCEL_GROUP_INDENT API_SUB_URL(@"userElse/cancelGroupIndent.do")
//6.20删除组团订单
#define API_DELETE_GROUP_INDENT API_SUB_URL(@"userElse/deleteGroupIndent.do")
//6.21获取我的买菜日历列表
#define API_GET_MY_MAICAI_CALENDAR_LIST API_SUB_URL(@"userElse/getMaicaiCalendarList.do")
//6.23开启/关闭提醒
#define API_UPDATE_WARN_STATE API_SUB_URL(@"userElse/updateWarnState.do")
//6.25提交反馈意见
#define API_SEND_SUGGEST API_SUB_URL(@"userElse/sendSuggest.do")
//6.29获取订单退款信息列表（新加）
#define API_GET_REFUND API_SUB_URL(@"userElse/getRefund.do")
//6.30领取优惠券（新加）
#define API_TAKE_COUPON API_SUB_URL(@"userElse/takeCoupon.do")
//6.31使用优惠券（新加）
#define API_USE_COUPON API_SUB_URL(@"userElse/useCoupon.do")
//6.34增加提醒（新加）
#define API_ADD_WARM API_SUB_URL(@"userElse/addWarn.do")
//6.42删除提醒
#define API_DELETE_WARM API_SUB_URL(@"userElse/deleteWarn.do")
//6.35订单退款（新加）
#define API_REFUND API_SUB_URL(@"userElse/refund.do")
//6.38获得售后服务类别表（新加）
#define API_GET_SERVICE_TYPE API_SUB_URL(@"userElse/getServiceType.do")
//6.39获取可参团的订单列表（新加）
#define API_GET_GROUP_INDENT_LIST API_SUB_URL(@"userElse/getGroupIndentList.do")
//6.41获取所有可领用的优惠券列表（新加）
#define API_GET_COUPON_LIST API_SUB_URL(@"userElse/getCouponList.do")
//6.42删除我的优惠券（新加）
#define API_DELETE_COUPON API_SUB_URL(@"userElse/deleteCoupon.do")

//6.43 QQ或者微信绑定手机号
#define API_BINDING  API_SUB_URL(@"userElse/binding.do")

//6.44获取我的消息列表（新加）
#define API_GET_MY_MESSAGE_LIST API_SUB_URL(@"userElse/getMyMessageList.do")
//6.45删除我的消息（新加）
#define API_DELETE_MYMESSAGE_BY_ID API_SUB_URL(@"userElse/deleteMyMessageById.do")
//6.46获取我的取货点
#define API_GET_DELIVERYPOINT_LIST  API_SUB_URL(@"shopCart/getDeliveryPointList.do")
//6.48更新团购订单信息
#define API_UPDATE_GROUP_INDENT_INFO  API_SUB_URL(@"userElse/updateGroupIndentInfo.do")
//6.49更新普通订单信息
#define API_UPDATE_INDENT_INFO  API_SUB_URL(@"userElse/updateIndentInfo.do")
//6.51免责声明
#define API_GET_STATE_MENT  API_SUB_URL(@"userElse/getStatement.do")
//6.52团购说明
#define API_GET_EXPLAIN  API_SUB_URL(@"userElse/getExplain.do")
//6.53售后查看进度
#define API_VIEW_PROGRESS  API_SUB_URL(@"userElse/viewProgress.do")
//6.54使用说明
#define API_GET_INSTRUCTIONS  API_SUB_URL(@"userElse/instructions.do")

//七、支付
//7.1支付订单
#define API_GET_PAY_CHARGE  API_SUB_URL(@"alipay/getPayCharge.do")
//7.2支付组团订单
#define API_PAY_INDENT  API_SUB_URL(@"userElse/payIndent.do")
