//
//  HHBaseController.h
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NibType) {
    NibTypeNone = 0,//没有
    NibTypeiPhone,
    NibTypeiPad,
};




@interface HHBaseController : UIViewController


@property (nonatomic, strong) UIView   *navView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, copy)   NSString *titleString;

//如果是xib用这个初始化 如果不是，直接init
- (instancetype)initWithNibVCName:(NSString *)vcName;

- (void)backClick;
















@end
