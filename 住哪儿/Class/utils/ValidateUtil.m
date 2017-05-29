//
//  ValidateUtil.m
//  Textfield输入
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ValidateUtil.h"
#import <UIKit/UIKit.h>
#import "RegexKitLite.h"

static NSString *Accuracy = @"accuracyValue";

@interface ValidateUtil()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger count;  /**<限制输入小数点的精度*/

@property (nonatomic, assign) BOOL isHavePoint;


@end

/*
 
@implementation ValidateUtil(TellPhone)

@end
*/

//类簇

@implementation ValidateUtil

//+(instancetype)alloc{
//    NSAssert(0, @"这是一个单例对象，请用sharedInstance类方法初始化");
//    return nil;
//}

+(ValidateUtil *)sharedInstance{
    static ValidateUtil *unti = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        unti = [[self alloc] init];
    });
    return unti;
}



+ (BOOL)isNotBlank:(NSString*)source
{
    if(source == nil || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isBlank:(NSString*)source
{
    if(source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

+(BOOL) isPositiveNum:(NSString*)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString *format = @"^[1-9]\\d*|0$";
    return [source isMatchedByRegex:format];
}


+(BOOL)isNumNotZero:(NSString *)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString *format = @"^[1-9]\\d*$";
    return [source isMatchedByRegex:format];
    
}

+(BOOL)isNotNumAndLetter:(NSString *)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString *format = @"[^a-zA-Z0-9]+";
    return [source isMatchedByRegex:format];
    
}

+(BOOL) isInt:(NSString*)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString *format = @"^-?[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

+(BOOL) isFloat:(NSString*)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString* format=@"^-?[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

+(BOOL) isDate:(NSString*)source{
    if ([self isBlank:source]) {
        return NO;
    }
    NSString* format=@"^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} CST$";
    return [source isMatchedByRegex:format];
}

+(NSString*) urlFilterRan:(NSString*)urlPath
{
    NSString *regex = @"(.*)([\\?|&]ran=[^&]+)";
    return [urlPath stringByReplacingOccurrencesOfRegex:regex withString:@"$1"];
}

+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    retStr=[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [retStr lowercaseString];
}



+ (void)setInfoObject:(id)object forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getInfoObject:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)delInfoObject:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)checkTel:(NSString *)phoneNum{
    NSString *str=[self getFormatPhoneNumber:phoneNum];
    if ([str length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"号码不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;   
    }
    return YES;
}


+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];

}


+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}


+(NSString *)getFormatPhoneNumber:(NSString *)original
{
    original = [original stringByReplacingOccurrencesOfString:@" " withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@"+" withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@"(" withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@")" withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@"-" withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (original.length>11) {
        NSMutableString *mutableNumber=original.mutableCopy;
        [mutableNumber deleteCharactersInRange:NSMakeRange(0, original.length-11)];
        return mutableNumber.copy;
    }
    return original;
}

+(void)registerValidator:(UITextField *)textfield withAccuracy:(NSInteger)accuracy{
    ValidateUtil *validator = [ValidateUtil sharedInstance];
    validator.count = accuracy;
    textfield.delegate = validator;
}


/*
1.输错了强制修改 -- 实现
2.输错了，提示用户 --

1.这个是不是浮点数。包括几位小数。 type
2.验证是不是字符串，最短 最长可以限制。 type
3.验证是不是手机号。 type

+++

type：（）
rule：（）


HLVilidateRule
1. 精度
2. 最短 最长
3. nil
*/










- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        self.isHavePoint=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                if (single == '0') {
                    NSLog(@"亲，您输入的格式不正确");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!self.isHavePoint)//text中还没有小数点
                {
                    self.isHavePoint=YES;
                    return YES;
                }else
                {
                    NSLog(@"亲，您输入的格式不正确");
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (self.isHavePoint)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt <= self.count){
                        return YES;
                    }else{
                        NSLog(@"亲，您输入的格式不正确");
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            NSLog(@"亲，您输入的格式不正确");
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}



@end
