//
//  ListCell_1CollectionViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ListCell_1CollectionViewCell.h"

@interface ListCell_1CollectionViewCell ()
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;

/** 价格*/
@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation ListCell_1CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.logoIv];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.priceLb];
        
        self.logoIv.sd_layout
        .topSpaceToView(self.contentView, 5)
        .leftSpaceToView(self.contentView, 5)
        .rightSpaceToView(self.contentView, 5)
        .heightIs(100);
        
        _titleLb.sd_layout
        .centerXEqualToView(_logoIv)
        .topSpaceToView(_logoIv, 10)
        .heightIs(16);
        [_titleLb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
        
        _priceLb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .centerXEqualToView(_logoIv)
        .autoHeightRatio(0);
        [_priceLb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
    }
    return self;
}


#pragma mark ----------------数据处理


- (void)setProductModel:(ProductModel *)productModel{
    _productModel = productModel;
    _titleLb.text = productModel.title;
    [_logoIv sd_setImageWithURL:LOGOURL(productModel.logo) placeholderImage:Placeholder_middle];
    
    _priceLb.text = [NSString stringWithFormat:@"¥%.1f",productModel.price2.floatValue];
    
    if (productModel.price2.floatValue == 0) {
        _priceLb.text = @"暂无报价";
    }
}

#pragma mark ----------------实例

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        _logoIv.layer.shadowOffset = CGSizeMake(5, 5);
        _logoIv.layer.shadowColor = BLACKCOLOR.CGColor;
        _logoIv.layer.shadowRadius = 5;
        _logoIv.layer.shadowOpacity = 1.0;
    }
    return _logoIv;
}


- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(16);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(12);
        _priceLb.textColor = [UIColor redColor];
        
    }
    return _priceLb;
}
@end
