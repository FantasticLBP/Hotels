

//
//  SalePromotionImageView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "SalePromotionImageView.h"

@interface SalePromotionImageView()<UIGestureRecognizerDelegate>
@end

@implementation SalePromotionImageView

#pragma mark - public method
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString placeHolder:(NSString *)imageName{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.defaultImageName = imageName;
        self.imageUrl = urlString;
    }
    return self;
}

-(void)showInView:(UIViewController *)viewController{
    [viewController.view addSubview:self];
    __weak SalePromotionImageView *WeakSelf = self;
    [UIView animateWithDuration:1.3 delay:1.0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect = WeakSelf.frame;
        rect.origin.y = BoundHeight/2-50;
        WeakSelf.frame = rect;
    } completion:^(BOOL finished) {
        [WeakSelf performSelector:@selector(moveToFinalLocation) withObject:nil afterDelay:.35f];
    }];
}

#pragma mark - private method
-(void)setupUI{
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.userInteractionEnabled = YES;
    [self addTapGestureRecognizer];
    [self addPanGestureRecognizer];
}

/**<添加单击手势*/
-(void)addTapGestureRecognizer{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singalTap:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
}

/**<添加拖拽手势*/
-(void)addPanGestureRecognizer{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTap:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
}

-(void)singalTap:(UITapGestureRecognizer *)tapGestureRecognizer{
    if(self.delegate &&[self.delegate respondsToSelector:@selector(salePromotionImageView:didClickAtPromotionView:)]) {
        [self.delegate salePromotionImageView:self didClickAtPromotionView:@"click"];
    }
}

-(void)dragTap:(UIPanGestureRecognizer *)panGestureRecognizer{
    [self adjustAnchorPointForGestureRecognizer:panGestureRecognizer];
    UIView *piece = panGestureRecognizer.view;
    //获得手势在父视图上的偏移量
    CGPoint translation = [panGestureRecognizer translationInView:piece.superview];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [piece setCenter:CGPointMake(piece.center.x+translation.x, piece.center.y+translation.y)];
        [panGestureRecognizer setTranslation:CGPointZero inView:piece.superview];
        self.locationType = SalePromotionImageViewLocationType_Center;
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        //手势作用结束，判断位置是否需要移动到边界
        [self moveToFinalLocation];
        [panGestureRecognizer setTranslation:CGPointZero inView:piece.superview];
    }
}

/**<调整锚点*/
-(void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        //设置锚点为当前手势点击的点
        piece.layer.anchorPoint = CGPointMake(locationInView.x/piece.bounds.size.width, locationInView.y/piece.bounds.size.height);
        //根据在View上的位置设置锚点
        //防止设置完锚点过后，view的位置发生变化，相当于把view的位置重新定位到原来的位置上。
        //设置手势移动的位置，并把view移动到相应的位置
        CGPoint locationInSuperView = [gestureRecognizer locationInView:piece.superview];
        piece.center = locationInSuperView;
    }
}

/**<移动到最终停留位置*/
-(void)moveToFinalLocation{
    CGFloat minX = CGRectGetMinX(self.frame);
    CGFloat maxX = CGRectGetMaxX(self.frame);
    CGFloat midX = (minX + maxX)/2;
    
    CGFloat speed = BoundWidth/1.0f;
    CGFloat animationTime = 0.5;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    if (minX <= 0) {
        //贴到左边
        animationTime = -minX/speed;
        self.locationType = SalePromotionImageViewLocationType_Left;
    }else if (midX <= BoundWidth/2){
        //贴到左边
        animationTime = minX/speed;
        self.locationType = SalePromotionImageViewLocationType_Left;
    }else{
        //贴到右边
        animationTime = (BoundWidth-maxX)/speed;
        self.locationType = SalePromotionImageViewLocationType_RIght;
    }
    [UIView setAnimationDuration:animationTime];
    [UIView commitAnimations];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (self.locationType) {
        case SalePromotionImageViewLocationType_Left:
            self.image = [UIImage imageNamed:self.defaultImageName];
            break;
        case SalePromotionImageViewLocationType_Center:
            self.image = [UIImage imageNamed:self.defaultImageName];
            break;
        case SalePromotionImageViewLocationType_RIght:
            self.image = [UIImage imageNamed:self.defaultImageName];
            break;
    }
}

#pragma mark -- setter && getter 
-(void)setDefaultImageName:(NSString *)defaultImageName{
    _defaultImageName = defaultImageName;
    self.image = [UIImage imageNamed:defaultImageName];
    self.userInteractionEnabled = YES;
}

-(void)setImageUrl:(NSString *)imageUrl{
    if ([ProjectUtil isBlank:imageUrl]) {
        return ;
    }
    _imageUrl = imageUrl;
}

-(void)setLocationType:(SalePromotionImageViewLocationType)locationType{
    _locationType = locationType;
    CGRect pieceRect = self.frame;
    switch (locationType) {
        case SalePromotionImageViewLocationType_Left:
            pieceRect.origin.x = 0;
            break;
        case SalePromotionImageViewLocationType_Center:
            self.image = [UIImage imageNamed:self.defaultImageName];
            break;
        case SalePromotionImageViewLocationType_RIght:
            pieceRect.origin.x = BoundWidth - pieceRect.size.width;
            break;
    }
    self.frame = pieceRect;
}

@end

