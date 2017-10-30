//
//  HHSlideView.h
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void ((^callBack)(NSInteger index));

@interface HHSlideView : UIView

- (void)hidden;

- (void)show;

@property (nonatomic ,copy)callBack block;






@end
