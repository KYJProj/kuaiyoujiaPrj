//
//  Const.h
//  KuaiYouJia
//
//  Created by TTc on 14-9-15.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

#ifndef KuaiYouJia_Const_h
#define KuaiYouJia_Const_h
/**
 *
 * @author liutian.
 *
 *  常量
 */

//消息体字段名
#define  FONT @"HelveticaNeue-UltraLight"


//请求网络是的消息头标识符
#define SYS_FLAG  @"$KYJ$"
const static UInt8 VERSION = 1;
const static short STATUSCODE = 0;
//请求本地数据的IP地址
#define HOST @"192.168.3.72"
//请求本地数据的端口号
const static  uint16_t PORT = 8802;


#define HTTP_PAY_SERVER @"http://192.168.3.72:8888/billPay/getSignInfo"
//发布房源的图片服务器
#define IMAGE_SERVER @"http://192.168.3.191"
#define IMAGE_UPLOAD @"http://192.168.3.191/tximages/renthouse/upload.ashx"
#define IMAGE_DELETE @"http://192.168.3.191/tximages/renthouse/delete.ashx"

//上传头像图片服务器
#define Photo_UPLOAD @"http://192.168.3.191/tximages/user/UploadCommon.ashx"
#define Photo_Save @"http://192.168.3.191/tximages/user/SaveCommon.ashx"
//快钱server
#define Kuai_SERVER @"mobile.99bill.com:443"


#define  PAGEAGE_ID     @"package_id"
#define  VERSION_CODE   @"version_code"
#define  VERSION_NAME   @"version_name"
#define  PLATFORM       @"platform"
#define  IMEI           @"imei"
//15s socket的各种超时时间，包括链接超时，读取数据超时等。
#define SOCKET_ALL_TIMEOUT  15
//定时更新时间
#define TIMER   (60)

/**
 * 下载新版ipa的常量定义
 */
const static  short  GET_UNDATAINFO_ERROR = 0; //获取信息失败
const static  short  DOWN_ERROR = -1;          //下载失败

/**
 * 访问网络的常量定义
 */
const static  short  ACCESS_NETWORK_FAIL = -1;    //连接网络失败
const static  short  GET_DATA_FAIL = 0;           //获取数据失败
const static  short  GET_DATA_SECCESS = 1;         //获取数据成功
const static  short  CONN_SERVER_FAIL = -2;        //连接服务器失败

typedef enum{
    SOCKET_HEAD         = 0, //tag socket header
    SOCKET_BODY         = 1, //tag socket body
    SOCKET_TOPIC_MSG    = 2, //tag sockt
    SOCKET_ERROR        = 3, //Socket  error
    SOCKET_DISCONNECT   = 4, //Socket disconnect
    SOCKET_ERROR_CLOSE  = 5  //Socket 关闭
}SOCKET_STATUS;


typedef enum{
    Refresh_Mode = 0,//更新
    More_Mode = 1,   //更多
    Other_Mode
}REQUEST_MODE;



/**
 * 命令字
 */
const static  short COMMAND_INVALID = -1; // 不可用的命令字

const static  short COMMAND_GET_SMS_CODE = 501; //  获取短信验证码
const static  short COMMAND_APPLY_EXTRACT_MONEY = 1002;// 申请提取现金
const static  short COMMAND_BALANCE_PAY = 1003;// 余额支付

const static  short COMMAND_GET_USER_INFO = 1503; // 获取个人信息
const static  short COMMAND_UPDATE_PERSONAL_INFO = 1504; // 修改个人信息
const static  short COMMAND_GET_USER_ACCOUNT_INFO = 1505;// 获取用户账户信息
const static  short COMMAND_GET_USER_KB_SERIAL_INFO = 1506; // 获取用户K币流水
const static  short COMMAND_GET_USER_ACCOUNT_SERIAL_INFO = 1507;// 获取用户账户流水
const static  short COMMAND_UPDATE_PHONE_NUM = 1508;// 修改手机号
const static  short COMMAND_USER_SELECT_ORDER = 1509;// 获取订单管理信息
const static  short COMMAND_ORDER_INFO = 1510;// 订单详情
const static  short COMMAND_HOUSE_RENTER_PAY = 1512;// 房客确认付款

const static  short COMMAND_USER_LOGIN = 2004; // 用户登录
const static  short COMMAND_USER_UPDATE_PASSWORD = 2005; // 用户修改密码
const static  short COMMAND_USER_REGISTER = 2006; // 用户注册
const static  short COMMAND_USER_RESET_PASSWORD = 2007; // 用户重置密码
const static  short COMMAND_CITY_CASCADE = 2008; // 县市区商圈级联查询
const static  short COMMAND_SUBWAY_LINE_STATION = 2009; // 地铁线、站查询
const static  short COMMAND_GET_USER_MESSAGE_LIST = 2010; // 获取用户站内消息列表
const static  short COMMAND_GET_USER_MESSAGE_DETAIL = 2011; // 获取用户站内消息详情
const static  short COMMAND_DELETE_USER_MESSAGE = 2012; // 删除用户站内消息


const static  short COMMAND_ADD_REPORT_INFO = 3006; // 添加举报信息
const static  short COMMAND_GET_HOUSE_BY_ID = 3007; // 通过房屋id获取房源列表
const static  short COMMAND_GET_HOUSE_LIST_BY_KEY_WORD = 3008;// 通过关键字获取房源列表
const static  short COMMAND_USER_GET_LOOK_HOUSE_LIST = 3009; // 用户获取看房单
const static  short COMMAND_USER_ADD_LOOK_HOUSE_LIST = 3010; // 用户添加看房单
const static  short COMMAND_USER_DELETE_LOOK_HOUSE_LIST = 3011; // 用户删除看房单

const static  short COMMAND_SEARCH_AUTO_COMPLETE_TEXT = 3012; //搜索提示
const static  short COMMAND_PUBLISH_HOUSE_RESOURCE = 3013;// 发布房源
const static  short COMMAND_LOOK_LANDLORD_PHONE = 3014;// 查看房东电话

const static  short COMMAND_UPDATE_HOUSE_RESOURCE = 3016;// 修改房源
const static  short COMMAND_HOUSE_ONLINE_OFFLINE = 3017;// 房源上下架
const static  short COMMAND_GET_HOUSE_DETAIL_PRE = 3018;// 房源预览
const static  short COMMAND_DELETE_HOUSE = 3019;// 删除房源
const static  short COMMAND_USER_LOOK_PUBLICH_HOUSE_RESOURCE = 3020;// 用户查看发布房源
const static  short COMMAND_GET_PRE_RENT_NUM = 3021; // 获取预租房房源数量（app首页更新）
const static  short COMMAND_USER_PUBLISH_HOPE_RENT = 3022;// 用户发布求租
const static  short COMMAND_USER_UPDATE_HOPE_RENT_INFO = 3023; //  用户修改求租信息
const static  short COMMAND_USER_PUBLISH_HOPE_RENT_INFO = 3024; //  用户发布的求租信息
const static  short COMMAND_DELETE_USER_HOPE_RENTINFP = 3025; // 用户删除求租信息
const static  short COMMAND_HOPE_RENT_INFO = 3026;// 求租详情
const static  short COMMAND_LOOK_HOPE_RENT_PHONE = 3027;// 查看求租电话
const static  short COMMAND_HOPE_RENT_LIST = 3028;// 求租列表
const static  short COMMAND_Reserve_INFO = 3029;// 预定房源
const static  short COMMAND_GET_PICTURE_LIST = 3030; //获取图片列表
const static  short COMMAND_ADD_FEEDBACK = 3031; // 添加反馈信息
const static  short COMMAND_TAKE_HOUSE_RESOURCE_MONEY = 3032; // 提取房源保证金
const static  short COMMAND_ADD_PREDETERMINE = 3033;// 加入在线预订
const static  short COMMAND_EXIT_PREDETERMINE = 3034; // 退出在线预订
const static  short COMMAND_FINDHOUSE_FROMMAP = 3035;  //地图找房
const static  short COMMAND_GET_APP_VERSION = 4509; // 获取app版本信息



/**
 * 状态码
 */
const static  short  STATUS_CODE_OK         =  0;   // 返回的状态码正常
const static  short  RESULTCODE_UNKNOW      = -1;   //未知错误
const static  short  RESULTCODE_QUERY_FAIL  = -2;   //查询失败
const static  short  RESULTCODE_COMMIT_FAIL = -3;   //提交失败
const static  short  RESULTCODE_VERSION_FAIL= -4;   //新版本更新
const static  short  RESULTCODE_LOGIN_FAIL  = -5;   //未登录
const static  short  RESULTCODE_SMSCODE_FAIL= -501; //当日手机接收短信已达上线(业务限制)
const static  short  RESULTCODE_SMSSERVER_FAIL  = -502;   //短信服务器发送异常(短信服务器故障)
const static  short  RESULTCODE_PAY_FAIL  = -1002;   //账户余额不足

const static  short  RESULTCODE_LOGIN_NAME_PASSWORD = -2004; //登录失败用户名或密码有误
const static  short  RESULTCODE_UPDATE_PASSWORD = -2005;  //密码校验不通过
const static  short  RESULTCODE_VERIFICATION_FAIL = -2006;  //验证码有误
const static  short  RESULTCODE_RESULTED = -2007;        //密码校验不通过
const static  short  STATUS_CODE_HOUSE_DOWN = -3006; //房源已经下架
const static  short  STATUS_CODE_RENT_FAIL = -3008; //用户未预定房源
const static  short  STATUS_CODE_NUMBER_LIMIT   = -3009; // 查看次数达到上线
const static  short  STATUS_CODE_PAY_FAIL       = -3010; // 房源未支付
const static  short  STATUS_CODE_DUMP_RENT      = -3011; //重复预定

const static  short  STATUS_CODE_HOUSE_UP_FAIL       = -3012; // 房源已上架 (提取保证金错误码，房源已上架)
const static  short  STATUS_CODE_HOUSE_NO_MAGIRE_FAIL      = -3013; //非保证金房源（提取保证金错误码，非保证金房源）
const static  short  STATUS_CODE_HOUSE_ADVED_FAIL   = -3014; //房源已有预约（提取保证金错误码，房源已有预约）
const static  short  STATUS_CODE_HOUSE_NO_AUDIT_FAIL       = -3015; //房源未审核（加入在线预约错误码：房源未审核）
const static  short  STATUS_CODE_HOUSE_PAYED_FAIL   = -3016; // 房源已支付（退出在线预约错误码：房源已支付）





/*
 *图片类型：头像
 */
#define PICTURE_TYPE_LOGO @"LOGO"
/*
 *选中的城市列表
 */
#define CITY @"CITY"
#define CITY_NAME  @"CITY_NAME"
#define CITY_ID  @"CITY_ID"
#define CITY_PY @"CITY_PY"
/**
 * 图片类型：卧室
 */
#define PICTURE_TYPE_BEDROOM @"BEDROOM"
/**
 * 图片类型：客厅
 */
#define PICTURE_TYPE_LIVINGROOM @"LIVINGROOM"
/**
 * 图片类型：厨房
 */
#define PICTURE_TYPE_KITCHEN @"KITCHEN"
/**
 * 图片类型：户型
 */
#define PICTURE_TYPE_ROOMTYPE @"ROOMTYPE"
/**
 * 图片类型：小区
 */
#define PICTURE_TYPE_VILLAGE @"VILLAGE"
/**
 * 图片类型：周边
 */
#define PICTURE_TYPE_AROUND @"AROUND"

/**
 * 图片类型：居住情况
 */
#define PICTURE_TYPE_LIVECONDITION @"LIVECONDITION"
/**
 * 图片类型：其它
 */
#define PICTURE_TYPE_OTHER @"OTHER"


//***************************************************************//
/**
 * 百度LBS ak
 */
#define  BAIDU_BLS_AK @"CmwX3haqAcKcTzTzxTylr8Mp"

/**
 * 短信验证码#注册验证码
 */
#define   SMS_CODE_REGIST @"CODE_REGIST"
/**
 * 短信验证码#重置密码验证码
 */
#define  SMS_CODE_RESET_PWD @"CODE_RESET_PWD"
/**
 * 短信验证码#修改手机号
 */
#define  SMS_CODE_CHANGE_MOBILE @"CODE_CHANGE_MOBILE"
/**
 * 短信验证码#确认付款验证码
 */
#define   SMS_CODE_PAY_MONEY @"CODE_PAY_MONEY"

/**
 * 短信验证码#提现验证码
 */
#define   SMS_CODE_DRAW_MONEY @"CODE_DRAW_MONEY"

#endif
