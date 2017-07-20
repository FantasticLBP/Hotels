//
//  AFNetPackage.h
//  KSGuidViewDemo
//
//  Created by 杭城小刘 on 2016/10/21.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"
@interface AFNetPackage : NSObject

/**
 *检查网络状态
 */
+(void)netWorkStatus;

/**
 *  JSON方式获取数据
 */
+(void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;

/**
 *
 *  xml方式获取数据
 *
 */
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail;



/**
 *
 *  get提交json数据
 *
 */
+ (void)getJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;


+ (void)deleteJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *
 *  post提交json数据
 *
 */
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;



/**
 *
 *  下载文件
 *
 */
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;


/**
 *
 *  文件上传－自定义上传文件名
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr para:(NSDictionary *)para name:(NSString *)name fileData:(NSData *)fileData fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail;



@end
