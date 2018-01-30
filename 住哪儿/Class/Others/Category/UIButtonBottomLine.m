//
//  UIBottomLineButton.m
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "UIButtonBottomLine.h"

@implementation UIButtonBottomLine

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    _lineColor = self.titleLabel.textColor;
    [self setNeedsDisplay];
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, self.lineColor?self.lineColor.CGColor:self.titleLabel.textColor.CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 0, CGRectGetMaxY(self.titleLabel.frame));
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, CGRectGetMaxY(self.titleLabel.frame));
    CGContextDrawPath(currentContext, kCGPathStroke);
}

@end

