//
//  AnimationUtil.h
//  Textfield输入
//
//  Created by geek on 2016/10/18.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationUtil : NSObject
+(void) animal:(UIViewController*) controller type:(NSString*)type direction:(NSString*)direction;
+(void) animal2:(UIViewController*) controller type:(NSString*)type direction:(NSString*)direction;
+(void) animalEdit:(UIViewController*) controller action:(NSInteger)action;


+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// move
+ (void)animationMoveUp:(UIView *)view;
+ (void)animationMoveDown:(UIView *)view;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;
@end
