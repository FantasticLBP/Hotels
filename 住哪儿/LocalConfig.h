
//
//  LocalConfig.h
//  KSGuidViewDemo
//
//  Created by 杭城小刘 on 2016/10/13.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef LocalConfig_h
#define LocalConfig_h

/************************************获取屏幕 宽度、高度******************************************/
#define BoundWidth [UIScreen mainScreen].bounds.size.width
#define BoundHeight [UIScreen mainScreen].bounds.size.height

/************************************颜色******************************************/

#ifdef DEBUG

#define LBPLog(...) NSLog(__VA_ARGS__)

#else

#define LBPLog(...) 

#endif

/************************************颜色******************************************/
#define GlobalMainColor [UIColor colorWithRed:93/255.0 green:70/255.0 blue:148/255.0 alpha:1]
#define TintTextColor [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]
#define TextColor [UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]
#define TableViewBackgroundColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]
#define CollectionViewBackgroundColor [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]
#define DefaultButtonColor [UIColor colorWithRed:68/255.0 green:153/255.0 blue:255/255.0 alpha:1]
#define PlaceHolderColor [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1]


/************************************颜色******************************************/
#define TelePhoneNumber @"18968103090"
#define LoginUserInfo @"LoginUserInfo"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"


/************************************url******************************************/
//#define Base_Url @"http://bxu2359670321.my3w.com"
//#define Base_Url @"http://192.168.20.170:8888"
//#define Base_Url @"http://192.168.0.103:8888"
//#define Base_Url @"http://192.168.20.170:8888/Hotels_Server"
#define Base_Url @"http://bxu2359670321.my3w.com/Hotels_Server"

/************************************App key******************************************/
#define AppKey @"TheHotelReversationApplication"

/************************************通知名称******************************************/
#define LocalNitificationArray @"LocalNitificationArray"
#define LogoutNotification @"LogoutNotification"
/************************************用户信息******************************************/
#define User_Info @"User_Info"
#define User_Avator @"User_Avator"


/************************************接口操作类型type******************************************/
#define  UpdaterUser_NickName @"1"
#define  UpdaterUser_Gender @"2"
#define  UpdaterUser_Birthday @"3"
#define  UpdaterUser_Password @"4"
#define  UpdaterUser_Avator @"5"

#endif /* LocalConfig_h */

