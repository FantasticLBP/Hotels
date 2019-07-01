//
//  UIProgressView+FlatUI.h
//  FlatUITestProj
//
//  Created by Alex Medearis on 5/16/13.
//  Copyright (c) 2013 Alex Medearis. All rights reserved.
//

#import "UIImage+FlatUI.h"

@implementation UIProgressView (FlatUI)

- (void)configureFlatProgressViewWithTrackColor:(UIColor *)trackColor {
	UIImage *trackImage = [UIImage imageWithColor:trackColor cornerRadius:4.0];
    trackImage = [trackImage imageWithMinimumSize:CGSizeMake(10.0f, 10.0f)];
    [self setTrackImage:trackImage];

	if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
		[self setTintColor:trackColor];
	}

}

- (void)configureFlatProgressViewWithProgressColor:(UIColor *)progressColor {
    UIImage *progressImage = [UIImage imageWithColor:progressColor cornerRadius:4.0];
    [self setProgressImage:progressImage];
	
	if ([[[UIDevice currentDevice] systemVersion] compare:@"7.1" options:NSNumericSearch] != NSOrderedAscending) {
		[self setTintColor:progressColor];
	}

}

- (void) configureFlatProgressViewWithTrackColor:(UIColor *)trackColor
                                   progressColor:(UIColor *)progressColor {
    [self configureFlatProgressViewWithTrackColor:trackColor];
    [self configureFlatProgressViewWithProgressColor:progressColor];
}

@end
