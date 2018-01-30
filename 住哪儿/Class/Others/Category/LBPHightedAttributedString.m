
//
//  LBPHightedAttributedString.m
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/17.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "LBPHightedAttributedString.h"

@implementation LBPHightedAttributedString

#pragma mark -- 设置在一个文本中所有特殊字符的特殊颜色
+ (NSMutableAttributedString *)setAllText:(NSString *)allStr andSpcifiStr:(NSString *)keyWords withColor:(UIColor *)color specifiStrFont:(UIFont *)font{
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    if (color == nil) {
        color = [UIColor redColor];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:17];
    }
    
    
    for (NSInteger j=0; j<=keyWords.length-1; j++) {
        
        NSRange searchRange = NSMakeRange(0, [allStr length]);
        NSRange range;
        NSString *singleStr = [keyWords substringWithRange:NSMakeRange(j, 1)];
        while
            ((range = [allStr rangeOfString:singleStr options:0 range:searchRange]).location != NSNotFound) {
                //改变多次搜索时searchRange的位置
                searchRange = NSMakeRange(NSMaxRange(range), [allStr length] - NSMaxRange(range));
                //设置富文本
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                [mutableAttributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
    }
    return mutableAttributedStr;
}


@end
