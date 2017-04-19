//
//  ValidateUtil.h
//  Textfield输入
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputType) {
    PureText = 1,
    PureNum = 2,
    
};

typedef void(^SuccessBlock)(BOOL flag);
typedef void(^FailBlock)();

@interface ValidateUtil : NSObject

@property (nonatomic, strong) SuccessBlock success;

@property (nonatomic, strong) FailBlock fail;

//单例
+(ValidateUtil *)sharedInstance;

//判断字符串非空
+ (BOOL)isNotBlank:(NSString*)source;

//判断字符串为空
+ (BOOL)isBlank:(NSString*)source;

//正整数验证(带0).
+(BOOL) isPositiveNum:(NSString*)source;

//非0正整数
+(BOOL)isNumNotZero:(NSString *)source;

//不是数字和字母
+(BOOL)isNotNumAndLetter:(NSString *)source;

//整数验证.
+(BOOL) isInt:(NSString*)source;

//小数验证.
+(BOOL) isFloat:(NSString*)source;

//日期验证.
+(BOOL) isDate:(NSString*)source;

//URL路径过滤掉随机数.
+(NSString*) urlFilterRan:(NSString*)urlPath;

//获得UUID
+(NSString *)getUniqueStrByUUID;



/**************** 关于"NSUserDefaults"快捷方法 **********************/

// 保存数据——NSUserDefaults
+ (void)setInfoObject:(id)object forKey:(NSString *)key;

// 取得数据——NSUserDefaults
+ (id)getInfoObject:(NSString *)key;

// 删除数据——NSUserDefaults
+ (void)delInfoObject:(NSString *)key;




//判断手机号码是否合法
+ (BOOL)checkTel:(NSString *)str;

//判断邮件是否合法
+ (BOOL)validateEmail:(NSString *)email;

//判断身份证合法
+ (BOOL)validateIDCardNumber:(NSString *)value;

//[Validator validate:(UITextField *)TextField withRule:() error];

//验证UITextfield的输入
+(void)registerValidator:(UITextField *)textfield withAccuracy:(NSInteger)accuracy;

//+(void)registerValidator:(UITextField *)textfield withAccuracy:(NSInteger)accuracy success:(SuccessBlock)success fail:(FailBlock)fail;


//+(void)registerValidator:(UITextField *)textField withRule:(NSDictionary *)rule;

@end
