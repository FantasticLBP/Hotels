//
//  ShareView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareView;

@protocol ShareViewDelegate <NSObject>

@required
-(void)shareView:(ShareView *)shareView didSelectItemAtIndexPath:(NSInteger)indexPath;

@end

@interface ShareView : UIView
@property (nonatomic, weak) id<ShareViewDelegate> delegate;
@end
