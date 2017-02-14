//
//  ListCell_2CollectionViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/7.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ListCell_2CollectionViewCell.h"

@interface ListCell_2CollectionViewCell ()

/** 图标背景图*/
@property (nonatomic, strong) UIImageView *BackIv;

/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;

/** 价格*/
@property (nonatomic, strong) UILabel *priceLb;

/** 售出数量*/
@property (nonatomic, strong) UILabel *countLb;




@end

@implementation ListCell_2CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.BackIv];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.priceLb];
        [self.contentView addSubview:self.countLb];

        _BackIv.sd_layout
        .topSpaceToView(self.contentView, 5)
        .leftSpaceToView(self.contentView, 5)
        .rightSpaceToView(self.contentView, 5)
        .heightIs(110);
        
        _titleLb.sd_layout
        .topSpaceToView(_BackIv, 15)
        .leftSpaceToView(self.contentView, 5)
        .rightSpaceToView(self.contentView, 5)
        .autoHeightRatio(0);
        
        
        _priceLb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .leftEqualToView(_titleLb)
        .heightIs(14);
        [_priceLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _countLb.sd_layout
        .centerYEqualToView(_priceLb)
        .rightEqualToView(_titleLb)
        .heightIs(13);
        [_countLb setSingleLineAutoResizeWithMaxWidth:300];
    }
    return self;
}


#pragma mark ----------------数据处理

- (void)setModel:(ProductModel *)model{
    _model = model;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _priceLb.text = [NSString stringWithFormat:@"¥ %@", model.price1];
    _countLb.text = [NSString stringWithFormat:@"售出%@", model.numsale];
}


#pragma mark ----------------实例

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
    }
    return _logoIv;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKCOLOR;
    }
    return _titleLb;
}


- (UIImageView *)BackIv{
    if (!_BackIv) {
        _BackIv = [[UIImageView alloc] init];
        _BackIv.image = IMAGE(@"classify12");
        [_BackIv addSubview:self.logoIv];
        self.logoIv.sd_layout
        .topSpaceToView(_BackIv,-3)
        .leftSpaceToView(_BackIv,-3)
        .rightSpaceToView(_BackIv, 3)
        .bottomSpaceToView(_BackIv,3);
    }
    return _BackIv;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(14);
        _priceLb.textColor = [UIColor redColor];
        _priceLb.text = @"¥ 1643";
    }
    return _priceLb;
}

- (UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        _countLb.font = FONT(13);
        _countLb.textColor = LIGHTTEXTCOLOR;
        _countLb.text = @"售出0";
    }
    return _countLb;
}


@end
