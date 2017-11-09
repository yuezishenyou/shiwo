//
//  HHMovingAnnotation.m
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMovingAnnotation.h"



@implementation HHMovingAnnotation

- (void)step:(CGFloat)timeDelta {
    [super step:timeDelta];
    
    if(self.stepCallback) {
        self.stepCallback();
    }
}

- (CLLocationDirection)rotateDegree {
    return 0;
}


@end
