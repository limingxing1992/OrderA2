//
//  ListCell_3CollectionViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/17.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ListCell_3CollectionViewCell.h"

@interface ListCell_3CollectionViewCell ()

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

/** 原价*/
@property (nonatomic, strong) UILabel *oldPriceLb;


@end

@implementation ListCell_3CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
//        [self.contentView addSubview:self.BackIv];
        [self.contentView addSubview:self.logoIv];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.priceLb];
        [self.contentView addSubview:self.oldPriceLb];
//        [self.contentView addSubview:self.countLb];
        
        _logoIv.sd_layout
        .topSpaceToView(self.contentView, 5)
        .leftSpaceToView(self.contentView, 5)
        .rightSpaceToView(self.contentView, 5)
        .heightIs(120);
        
        _titleLb.sd_layout
        .topSpaceToView(_logoIv, 15)
        .centerXEqualToView(self.contentView)
        .autoHeightRatio(0);
        [_titleLb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
        
        
        _priceLb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .heightIs(14);
        [_priceLb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
        
        _oldPriceLb.isAttributedContent = YES;
        _oldPriceLb.sd_layout
        .centerYEqualToView(_priceLb)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(14);
        [_oldPriceLb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
        
        
    }
    return self;

}


#pragma mark ----------------数据处理

- (void)setModel:(GroupProModel *)model{
    _model = model;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _priceLb.text = [NSString stringWithFormat:@"¥ %@", model.price2];
    _countLb.text = [NSString stringWithFormat:@"  已售 %@ 个", model.discount];
    /** 
     NSString *str53 = @"\n设置删除线为细单实线,颜色为红色";
     NSDictionary *dictAttr53 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor redColor]};
     NSAttributedString *attr53 = [[NSAttributedString alloc]initWithString:str53 attributes:dictAttr53];
     [attributedString appendAttributedString:attr53];

     */
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元", model.price1] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:RGBColor(131, 131, 131)}];
    _oldPriceLb.attributedText = str;
}


#pragma mark ----------------实例

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        [_logoIv addSubview:self.countLb];
        _countLb.sd_layout
        .bottomSpaceToView(_logoIv, 0)
        .leftSpaceToView(_logoIv, 3)
        .heightIs(20);
        [_countLb setSd_cornerRadius:@10];
        [_countLb setSingleLineAutoResizeWithMaxWidth:170];

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
//        _BackIv.image = IMAGE(@"classify12");
        [_BackIv addSubview:self.logoIv];
        [_BackIv addSubview:self.countLb];
//        self.logoIv.sd_layout
//        .topSpaceToView(_BackIv,-3)
//        .leftSpaceToView(_BackIv,-3)
//        .rightSpaceToView(_BackIv, 3)
//        .bottomSpaceToView(_BackIv,3);
        
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
        [_countLb setBackgroundColor:[[UIColor alloc] initWithWhite:0.3 alpha:0.5]];
        _countLb.textColor = WHITECOLOR;
        _countLb.text = @"已售";
        _countLb.textAlignment= NSTextAlignmentCenter;
    }
    return _countLb;

}

- (UILabel *)oldPriceLb{
    if (!_oldPriceLb) {
        _oldPriceLb = [[UILabel alloc] init];
        _oldPriceLb.font = FONT(13);
        _oldPriceLb.textColor = RGBColor(131, 131, 131);
    }
    return _oldPriceLb;
}

@end
