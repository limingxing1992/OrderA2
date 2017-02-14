//
//  ListCell_1TableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ListCell_1TableViewCell.h"

@interface ListCell_1TableViewCell ()

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 简介*/
@property (nonatomic, strong) UILabel *shortLb;
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 右边箭头*/
@property (nonatomic, strong) UIImageView *accessView;



@end

@implementation ListCell_1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView sd_addSubviews:@[self.titleLb, self.shortLb, self.logoIv, self.accessView]];
        
        
        _logoIv.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 15)
        .widthEqualToHeight();
        
        
        self.titleLb.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 30)
        .leftSpaceToView(_logoIv, 10)
        .autoHeightRatio(0);
        [_titleLb setMaxNumberOfLinesToShow:1];
        
        
        _shortLb.sd_layout
        .topSpaceToView(_titleLb, 15)
        .leftEqualToView(_titleLb)
        .rightEqualToView(_titleLb)
        .autoHeightRatio(0);
        [_shortLb setMaxNumberOfLinesToShow:2];
        
        _accessView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(12)
        .widthIs(7);
        

    }
    return self;
}


- (void)setModel:(NewsModel *)model{
    _model  = model;
    _titleLb.text = model.title;
    _shortLb.text = model.des;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
}


#pragma mark ----------------实例

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb  = [[UILabel alloc] init];
        _titleLb.font = FONT(15);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UILabel *)shortLb{
    if (!_shortLb) {
        _shortLb = [[UILabel alloc] init];
        _shortLb.font = FONT(13);
        _shortLb.textColor = SHENTEXTCOLOR;
    }
    return _shortLb;
}

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
    }
    return _logoIv;
}

- (UIImageView *)accessView{
    if (!_accessView) {
        _accessView = [[UIImageView alloc] init];
        _accessView.image = IMAGE(@"classify8-1");
    }
    return _accessView;
}

@end