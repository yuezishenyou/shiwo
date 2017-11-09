//
//  HHMovingAnnotation.h
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

typedef void (^CustomMovingAnnotationCallback)(void);

@interface HHMovingAnnotation : MAAnimatedAnnotation

@property (nonatomic, copy) CustomMovingAnnotationCallback stepCallback;

- (CLLocationDirection)rotateDegree;

@end
