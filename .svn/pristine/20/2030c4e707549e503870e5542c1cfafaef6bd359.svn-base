//
//  OrderDetailTableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/18.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@interface OrderDetailTableViewCell ()

@property (nonatomic, strong) UIImageView *logoIv;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *priceLb;

@property (nonatomic, strong) UILabel *countLb;





@end

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView sd_addSubviews:@[self.logoIv, self.titleLb, self.priceLb, self.countLb]];
        
        _logoIv.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10)
        .widthEqualToHeight();
        
        NSArray *ary = @[@"价格：", @"数量：", @"元"];
        for (NSInteger i = 0; i < ary.count; i++) {
            UILabel *lb = [[UILabel alloc] init];
            lb.font = FONT(17);
            lb.textColor = BLACKTEXTCOLOR;
            lb.text = ary[i];
            [self.contentView addSubview:lb];
        
            
            if (i == 0) {
                lb.sd_layout
                .centerYEqualToView(self.contentView)
                .leftSpaceToView(_logoIv, 10)
                .widthIs(58)
                .heightIs(17);
            }else if (i ==1){
                lb.sd_layout
                .bottomSpaceToView(self.contentView, 16)
                .leftSpaceToView(_logoIv, 10)
                .widthIs(58)
                .heightIs(17);
            }else{
                lb.sd_layout
                .centerYEqualToView(self.contentView)
                .rightSpaceToView(self.contentView, 85)
                .autoHeightRatio(0);
                [lb setSingleLineAutoResizeWithMaxWidth:100];
            }
        }
        
        _titleLb.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(_logoIv, 10)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(20);
        
        
        _priceLb.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_logoIv, 68)
        .widthIs(90)
        .heightIs(17);
        
        _countLb.sd_layout
        .bottomSpaceToView(self.contentView, 16)
        .leftSpaceToView(_logoIv, 68)
        .rightSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
    }
    return self;
}


- (void)setModel:(OrderProductModel *)model{
    _model = model;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _priceLb.text = model.price.stringValue;
    _countLb.text = model.num.stringValue;
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
        _titleLb.font = FONT(19);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(17);
        _priceLb.textColor = [UIColor redColor];
        _priceLb.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLb;
}

- (UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        _countLb.font = FONT(17);
        _countLb.textColor = LIGHTTEXTCOLOR;
    }
    return _countLb;
}


@end
