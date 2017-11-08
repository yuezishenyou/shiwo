//
//  YDStartAnnotationView.h
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface YDStartAnnotationView : MAAnnotationView

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) UIView   *calloutView;
@property (nonatomic, strong) UIView   *waterView;
@property (nonatomic, strong) UIImage *portrait;



- (void)layerAnimation;

@end
