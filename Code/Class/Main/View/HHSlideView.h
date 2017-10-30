//
//  HHSlideView.h
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void ((^callBack)(NSString *str));

@interface HHSlideView : UIView

- (instancetype)initWithSupView:(UIView *)supView;

- (void)hidden;

- (void)show;









@property (nonatomic ,copy)callBack block;






@end
