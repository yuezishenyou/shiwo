//
//  YDStartAnnotationView.m
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "YDStartAnnotationView.h"

#define kWidth  44.//150.f
#define kHeight 22.//60.f

#define kw (30)
#define kh (40)

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   150.f
#define kCalloutHeight  50.0


@interface YDStartAnnotationView ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation YDStartAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.bounds = CGRectMake(0, 0,kWidth, kHeight);
        [self setup];
    }
    return self;
}


- (void)setup
{
    
    self.bounds = CGRectMake(0, 0, kw, kh);
    
    self.imageV = [[UIImageView alloc]initWithFrame:self.bounds];
    
    [self addSubview:self.imageV];
    
    
    
    
    self.waterView = [[UIView alloc] initWithFrame:CGRectMake( (self.frame.size.width - 100)/2, (self.frame.size.height - 100)/2, 100, 100)];
    
    [self addSubview:self.waterView];
    
    [self layerAnimation];
    
}



- (UIImage *)portrait
{
    return self.imageV.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.imageV.image = portrait;
}


- (void)layerAnimation
{
    self.waterView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = self.waterView.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = [UIColor blueColor].CGColor;//填充色
    pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.waterView.bounds;
    replicatorLayer.instanceCount = 4;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [self.waterView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}






@end
