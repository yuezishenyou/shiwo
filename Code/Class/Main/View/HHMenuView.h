//
//  HHMenuView.h
//  shiwo
//
//  Created by maoziyue on 2017/11/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

//********************** 底部界面 *************************/

#import <UIKit/UIKit.h>

@interface HHMenuView : UIView


@property (nonatomic, copy) void(^submitOrderBlock)(void);

@property (nonatomic, copy) void(^cancelOrderBlock)(void);




@end
