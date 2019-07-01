//
//  LBPHightedAttributedString.h
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/17.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBPHightedAttributedString : NSMutableAttributedString

/**
 *  设置在一个文本中所有特殊字符的特殊颜色
 *  @pragma  allStr      所有字符串
 *  @pragma  specifiStr  特殊字符
 *  @pragma  color       默认特殊字符颜色    红色
 *  @pragma  font        默认字体           systemFont 17.号字
 **/
+ (NSMutableAttributedString *)setAllText:(NSString *)allStr andSpcifiStr:(NSString *)keyWords withColor:(UIColor *)color specifiStrFont:(UIFont *)font;

@end
