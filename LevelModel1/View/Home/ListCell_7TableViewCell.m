//
//  ListCell_7TableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/7.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ListCell_7TableViewCell.h"

@interface ListCell_7TableViewCell ()

/** 图标背景图*/
@property (nonatomic, strong) UIImageView *BackIv;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 简介*/
@property (nonatomic, strong) UILabel *shortLb;
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;



@end

@implementation ListCell_7TableViewCell

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
        [self.contentView sd_addSubviews:@[self.titleLb, self.shortLb, self.BackIv]];
        
        
        _BackIv.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 15)
        .widthEqualToHeight();
        
        
        self.titleLb.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 30)
        .leftSpaceToView(_BackIv, 10)
        .autoHeightRatio(0);
        [_titleLb setMaxNumberOfLinesToShow:1];
        
        
        _shortLb.sd_layout
        .topSpaceToView(_titleLb, 15)
        .leftEqualToView(_titleLb)
        .rightEqualToView(_titleLb)
        .autoHeightRatio(0);
        [_shortLb setMaxNumberOfLinesToShow:2];
        
    }
    return self;
}


- (void)setModel:(NewsModel *)model{
    _model = model;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _shortLb.text = model.regtime;
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
@end
