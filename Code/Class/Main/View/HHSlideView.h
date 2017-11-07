//
//  HHSlideView.h
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//




//********************** 侧滑面 *************************/

#import <UIKit/UIKit.h>

typedef void ((^callBack)(NSString *str));
typedef void (^SlideUserCtrolBlock)(NSString *str);

@interface HHSlideView : UIView

@property (nonatomic, copy)callBack block;

@property (nonatomic, copy)SlideUserCtrolBlock slideUserCtrolBlock;

- (instancetype)initWithSupView:(UIView *)supView;

- (void)hiddenAnimated:(BOOL)animated;

- (void)showAnimated:(BOOL)animated;

- (void)setHeaderImageWithFirstLoad:(BOOL)first;












@end
