//
//  YDHeaderView.h
//  shiwo
//
//  Created by maoziyue on 2017/11/6.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDHeaderView : UIView

@property (nonatomic,copy)void(^didSelectePhoto)(void);

@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@end
