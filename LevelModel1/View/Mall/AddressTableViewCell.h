//
//  AddressTableViewCell.h
//  LevelModel1
//
//  Created by 李明星 on 2017/1/11.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell

/** 删除按钮*/
@property (nonatomic, strong) UIButton *deletBtn;
/** 选择*/
@property (nonatomic, strong) UIButton *selectBtn;


@property (nonatomic, strong) AddressModel *model;


@end
