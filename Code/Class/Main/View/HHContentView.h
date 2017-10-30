//
//  HHContentView.h
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void ((^HHSelectedBlock)(NSString *str));

@interface HHContentView : UIView

+ (HHContentView *)initView;

@property (nonatomic, copy) HHSelectedBlock selectedBlock;





@end
