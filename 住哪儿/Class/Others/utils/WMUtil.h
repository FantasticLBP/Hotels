//
//  WMUtil.h
//  RCIM
//
//  Created by 郑文明 on 16/1/13.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/NSObject.h>
@interface WMUtil : NSObject
+ (NSDictionary*)dictionaryFromBundleWithName:(NSString*)fileName withType:(NSString*)typeName;
//字符串MD5转换
+ (NSString *)md5HexDigest:(NSString*)input;
+(NSString *)fileMd5sum:(NSString * )filename; //md5转换

//时间格式
+ (NSDate *)getNowTime;
+ (NSString *)getyyyymmdd;
+(NSString *)getyyyymmddHHmmss;
+(NSString *)getyyyy_mm_dd_HHmmss;
+ (NSString *)get1970timeString;
+ (NSString *)getTimeString:(NSDate *)date;
+ (NSString *)gethhmmss;
+ (NSDate *)getTime:(NSDate *)time AddMinutes:(NSInteger )Min;//当前时间+ 自定义分钟


+ (void)showTipsWithHUD:(NSString *)labelText;
+ (void)showTipsWithHUD:(NSString *)labelText inView:(UIView *)inView;
+ (void)showTipsWithView:(UIView *)uiview labelText:(NSString *)labelText showTime:(CGFloat)time;
+ (void) showHudMessage:(NSString*) msg hideAfterDelay:(NSInteger) sec uiview:(UIView *)uiview;

//+ (NetworkStatus)getCurrentNetworkStatus;
+ (void)showNotReachabileTips;

+ (NSDate *)dateFromString:(NSString *)dateString usingFormat:(NSString*)format;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString*)format;

//获取后台服务器主机名
//+(NSString*)readFromUmengOlineHostname;

//loadingView方法集
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle;
+(void)removeLoadingViewInView:(UIView*)viewToLoadData;
+(void)addLoadingViewInView:(UIView*)viewToLoadData usingUIActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)aStyle usingColor:(UIColor*)color;
+(void)removeLoadingViewAndLabelInView:(UIView*)viewToLoadData;
+(void)addLoadingViewAndLabelInView:(UIView*)viewToLoadData usingOrignalYPosition:(CGFloat)yPosition;
+(void)showProgessInView:(UIView *)view withExtBlock:(void (^)())exBlock withComBlock:(void (^)())comBlock;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation; //图片旋转

//将图片保存到应用程序沙盒中去,imageNameString的格式为 @"upLoad.png"
+ (void)saveImagetoLocal:(UIImage*)image imageName:(NSString *)imageNameString;
+ (NSString *)getDeviceOSType;


//判断字符串长度
+ (int)convertToInt:(NSString*)strtemp;
//end

+(NSMutableArray *)decorateString:(NSString *)string;
//正则表达式部分
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
//银行卡后四位
+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;
//CVN
+ (BOOL) validateCVNCode: (NSString *)cvnCode;
//month
+ (BOOL) validateMonth: (NSString *)month;
//year
+ (BOOL) validateYear: (NSString *)year;
//verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSString *)documentsDirectoryPath;
/**
 *  返回字符串所占用的尺寸
 *
 *  @param fontSize    字体
 *  @param stringSize 最大尺寸
 */
+ (CGSize)getWidthByString:(NSString*)string withFont:(UIFont*)stringFont withStringSize:(CGSize)stringSize;
/**
 *  正则表达式验证数字
 */
+ (BOOL)checkNum:(NSString *)str;

// View转化为图片
+ (UIImage *)getImageFromView:(UIView *)view;
// imageView转化为图片
+ (UIImage *)getImageFromImageView:(UIImageView *)imageView;

+ (BOOL)isLocationOpen;//判断是否打开定位
+ (NSInteger)getCellMaxNum:(CGFloat)cellHeight maxHeight:(CGFloat)height;//得到tableview最大页数
//匹配数字和英文字母
+ (BOOL) isNumberOrEnglish:(NSString *)string;
//匹配数字
+ (BOOL) isKimiNumber:(NSString *)number;

//是否存在字段
+ (BOOL)rangeString:(NSString *)string searchString:(NSString *)searchString;

//服务器500
+ (NSString *)server_error500Info:(NSError *)err WithFunctionName:(NSString *)name;


//去null
+ (NSString *)judgeNullForStr:(NSString *)str;

//收起键盘
+ (void)setOffKeyBoard;

//判断表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//根据UIlabel 内容 适应高度
+ (CGSize)getHeighWithLabel:(NSString *)labelTitle labelTextFunt:(UILabel *) label;

//字符串颜色分段显示

/**
 字符串颜色分段显示
 
 @param range 要变颜色的字符Range
 @param str   要变颜色的字符串
 
 @return 处理之后的字符串
 */
+ (NSAttributedString *)settitngNSStringColorWithRange:(NSRange )range Str:(NSString *)str WithColor:(UIColor *)color;

@end
