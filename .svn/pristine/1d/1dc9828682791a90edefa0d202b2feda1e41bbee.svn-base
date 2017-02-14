//
//  HomeCollectionViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/27.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()




@end

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.contentIv];
        _contentIv.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
    }
    return self;
}


- (void)setModel:(ChannelModel *)model{
    _model = model;
}

#pragma mark ----------------shili 

- (UIImageView *)contentIv{
    if (!_contentIv) {
        _contentIv = [[UIImageView alloc] init];
    }
    return _contentIv;
}


@end
