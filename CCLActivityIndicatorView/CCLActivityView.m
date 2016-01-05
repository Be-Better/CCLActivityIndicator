//
//  CCLActivityView.m
//  CCLActivityIndicatorView
//
//  Created by chen on 15/12/24.
//  Copyright © 2015年 chen. All rights reserved.
//

#import "CCLActivityView.h"

static const int kNumberOfFrames = 8;
static const CGFloat kViewWidth = 40;
static const CGFloat kSpaceDegree = 3.0;
static const CGFloat kEndDegree = 39.0;
static const CGFloat kRadius = 10.0;
static const CGFloat kWidth = 6.0;

@interface CCLActivityView()

@property (nonatomic, assign) BOOL isAnimating;

@end


@implementation CCLActivityView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self startAnimating];
    
}

- (UIImage *)cclActivityView:(int)index scale:(CGFloat)scale {
    
    NSArray * colors = @[
                         [UIColor colorWithRed: 242/255.0 green: 242/255.0 blue: 242/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 230/255.0 green: 230/255.0 blue: 230/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 179/255.0 green: 179/255.0 blue: 179/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 128/255.0 green: 128/255.0 blue: 128/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 128/255.0 green: 128/255.0 blue: 128/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 128/255.0 green: 128/255.0 blue: 128/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 128/255.0 green: 128/255.0 blue: 128/255.0 alpha: 1.0],
                         [UIColor colorWithRed: 128/255.0 green: 128/255.0 blue: 128/255.0 alpha: 1.0]];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kViewWidth, kViewWidth), false, scale);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat startDegree = kSpaceDegree;
    for (int i = 0; i < 8; i++) {
        //初始化一个UIBezierPath实例
        UIBezierPath * arcPath = [UIBezierPath bezierPath];
        //获取中点
        CGPoint center = CGPointMake(kViewWidth / 2, kViewWidth / 2);
        CGFloat startAngle = [self angleToRadian:startDegree];
        CGFloat endAngle = [self angleToRadian:(startDegree + kEndDegree)];
        //构建路径
        [arcPath addArcWithCenter:center radius:kRadius startAngle:startAngle endAngle:endAngle clockwise:true];
        //把路径添加到当前绘图的上下文
        CGContextAddPath(context, arcPath.CGPath);
        startDegree += kEndDegree + kSpaceDegree * 2;
        //设置线段宽度
        CGContextSetLineWidth(context, kWidth);
        //设置线段颜色
        CGContextSetStrokeColorWithColor(context, [colors[abs(i - index)] CGColor]);
//        CGContextSetStrokeColorWithColor(context, [colors[i] CGColor]);
        CGContextStrokePath(context);
    }
    //截图
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
//角度转弧度
- (double)angleToRadian:(double)angle {
    return angle * (M_PI / 180);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        [self startAnimating];
    }
    return self;
}
- (void)startAnimating {
    if (!self.isAnimating) {
        self.isAnimating = YES;
        self.hidden = NO;
        float animationDuration = 0.8;
        NSMutableArray * animationImages = [NSMutableArray array];
        
        self.layer.contents = (__bridge id)([self cclActivityView:0 scale:[UIScreen mainScreen].nativeScale].CGImage);
        
            for (int i = 0; i < kNumberOfFrames; i++) {
                [animationImages addObject:[[self cclActivityView:i scale:[UIScreen mainScreen].nativeScale] CGImage]];
            }
        
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"contents";
            animation.calculationMode = kCAAnimationDiscrete;
            animation.duration = animationDuration;
            animation.repeatCount = HUGE;
            animation.values = animationImages;
            animation.removedOnCompletion = false;
            animation.fillMode = kCAFillModeBoth;
            [self.layer addAnimation:animation forKey:@"contents"];
        
        //    CGAffineTransform transform = CGAffineTransformIdentity;
        //    transform = CGAffineTransformRotate(transform, M_PI);
        //
        //    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        //    animation.toValue = [NSValue valueWithCGAffineTransform:transform];
        //    animation.cumulative = YES;
        //    animation.duration = animationDuration;
        //    animation.repeatCount = HUGE;
        //    animation.autoreverses = YES;
        //    animation.removedOnCompletion = NO;
        //    animation.fillMode = kCAFillModeForwards;
        //    [self.layer addAnimation:animation forKey:@"transform"];
    }
}

- (void)stopAnimating {
    self.isAnimating = false;
//    self.layer.contents = (__bridge id)([self cclActivityView:0 scale:[UIScreen mainScreen].nativeScale].CGImage);
    self.hidden = YES;
}

//- (CGSize)intrinsicContentSize {
//    return CGSizeMake(kViewWidth, kViewWidth);
//}
//- (CGSize)sizeThatFits:(CGSize)size {
//    return CGSizeMake(kViewWidth, kViewWidth);
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.layer.bounds.size.width != kViewWidth) {
        self.layer.bounds = CGRectMake(0, 0, kViewWidth, kViewWidth);
    }
}

@end
