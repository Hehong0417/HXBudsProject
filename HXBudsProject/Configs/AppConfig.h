
//API






//导航栏标题字体大小
#define JDNavigationFont [UIFont systemFontOfSize:20]
#define FontBigSize [UIFont systemFontOfSize:16]
#define FontNormalSize [UIFont systemFontOfSize:14]
#define FontSmallSize [UIFont systemFontOfSize:12]
//公用颜色
#define JDCommonColor [UIColor colorWithRed:0.478 green:0.478 blue:0.478 alpha:1]
#define APP_COMMON_COLOR RGB(72, 210, 213)

#define APP_green_COLOR RGB(190, 225, 255)

#define KVCBackGroundColor RGB(245, 245, 245)
//#define KVCBackGroundColor RGB(250,250, 250)

#define KPlaceHoldColor RGB(204, 204, 204)


#define GrayBackGroudColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define LineLightColor RGB(229, 229, 229)
#define LineDeepColor RGB(204, 204, 204)
#define FontLightGrayColor RGB(153, 153, 153)
#define FontGrayColor RGB(102, 102, 102)
#define TitleGrayColor [UIColor colorWithHexString:@"#333333"]
#define FontBlackColor RGB(51, 51, 51)
#define MotoButtonColor RGB(249, 102, 24)

//用户信息
#define USER_CURRENT_ADDRESS @"user_current_address"
#define uDefault_CURRENT_ADDRESS [uDefault objectForKey:USER_CURRENT_ADDRESS]

//API返回信息
#define API_RETURN_SUCCESS @(1)
#define API_RETURN_FAILURE @(0)
#define API_RETURN_BUSY    @(-1)
#define API_RETURN_EXPIRE  @(40000)

//
#define CAR_TYPE_LIST_FILE_PATH ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"carTypeList.dat"])

#define CAR_LENGTH_LIST_FILE_PATH ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"carLengthList.dat"])

//storyboard名称

#define SB_LOGIN @"Login"
#define SB_HOME_PAGE @"HomePage"
#define SB_SHOP_CAR @"ShoppingCar"
#define SB_GOODS_CLASSIFY @"GoodsClassify"
#define SB_PERSON_CENTER @"PersonCenter"
#define kUrlScheme      @"hjMcb" // 这个是你定义的 URL Scheme，支付宝、微信支付和测试模式需要。

//
#define kTel_Number @"10086"

//获取或上传位置间隔时间
#define REQUEST_TIME_INTERVAL   10.0f

//输入文字限制
static const NSUInteger kReasonNoteMaxLength = 300;
//
////边框间距
static const CGFloat kGroupTablePadding = 15;
static const CGFloat kNormalButtonMargin = 30;
#define kNormalButtonWidth (SCREEN_WIDTH-kNormalButtonMargin*2)
#define kNormalButtonHeight 35

#define HUD_COLOR RGBA(53, 53, 53, 0.6)
#define IMAGE_SHOW_TIME 0.6
#define VIEW_SHOW_TIME 0.4

#define API_PAGE_COUNT 15

//圆角大小
#define kSmallCornerRadius 5.0f

//城市选择器
#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define FourComponent 3
#define CITYADDRESS_KEY @"CITYADDRESS_KEY"

//图片大小
#define BigImage 3
#define MiddleImage 2
#define SmallImage 1

#define IMAGE_280 @"280x280"
#define IMAGE_430 @"430x430"


#define ROOM_ONLY_SINGLE 1
#define ROOM_ONLY_SUIT 2
#define ROOM_SUIT_WITH_SINGLE 3

////商品类型
#define PRODUCT_SINGLE @"1"

//Cache
#define CACHE_HOME_MENU @"CACHE_HOME_MENU"
#define CACHE_HOME_ADS @"CACHE_HOME_ADS"
#define CACHE_HOME_VIRTUAL @"CACHE_HOME_VIRTUAL"

//NOTIFICATION
//登录失效通知
#define kNotificationTokenExpire @"kNotificationTokenExpire"

//扫码登录
#define NOTI_GUEST_FROM_QR @"NOTI_GUEST_FROM_QR"
#define APP_ACCOUNT_NAME @"APP_ACCOUNT_NAME"
#define APP_ACCOUNT_PWD @"APP_ACCOUNT_PWD"

//AliPay
#define kNotificationDidPayOrder @"NotificationDidPayOrder"
#define kNotificationGo2OrderPage @"kNotificationGo2OrderPage"

//改变首页定位地点
#define kNotificationChangeHomePageLocationPlace @"kNotificationChangeHomePageLocationPlace"

//改变结算取货点
#define kNotificationChangeSettleDeliveryPlace @"kNotificationChangeSettleDeliveryPlace"

//支付成功
#define kNotificationPaySuccess @"kNotificationPaySuccess"


typedef NS_ENUM(NSUInteger, DynamicType) {
    teacherDynamicType,//名师
    himDynamicType,//用户
    mineDynamicType,//我
};


//主页类型
typedef NS_ENUM(NSUInteger, DetailType) {
    teacherDetailType,//名师主页
    organizationType,//机构主页
};





//Block
//
typedef void(^voidBlock)();
typedef void(^idBlock)(id obj);
typedef void(^stringBlock)(NSString *result);
typedef void(^stringBlock2)(NSString *result,NSString *description);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayAndDescription)(NSArray *results,NSString *description);
typedef void(^arrayBlock)(NSArray *results);
typedef void(^successBlock)(id resultObj);
