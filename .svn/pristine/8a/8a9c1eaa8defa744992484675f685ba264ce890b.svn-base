//
//  ListCell_4TableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ListCell_4TableViewCell.h"

@interface ListCell_4TableViewCell ()

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 时间标题*/
@property (nonatomic, strong) UILabel *timeLb;
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 时间logo*/
@property (nonatomic, strong) UIImageView *timeIv;
/** 展会标志*/
@property (nonatomic, strong) UIImageView *showIv;
/** 地址标志*/
@property (nonatomic, strong) UIImageView *addressIv;
/** 地址*/
@property (nonatomic, strong) UILabel *addressLb;




@end

@implementation ListCell_4TableViewCell

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
        [self.contentView sd_addSubviews:@[self.titleLb, self.logoIv, self.timeLb,
                                           self.timeIv, self.showIv, self.addressIv,
                                           self.addressLb]];
        
        _logoIv.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 15)
        .widthIs(110);
        
        
        self.titleLb.sd_layout
        .topSpaceToView(self.contentView, 17.5)
        .rightSpaceToView(self.contentView, 0)
        .leftSpaceToView(_logoIv, 5)
        .heightIs(19);
        
        _timeIv.sd_layout
        .leftEqualToView(_titleLb)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthEqualToHeight();
        
    
        
        
        _timeLb.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_timeIv, 4)
        .rightSpaceToView(self.contentView, 0)
        .autoHeightRatio(0);
        [_timeLb setMaxNumberOfLinesToShow:1];
        
        _showIv.sd_layout
        .bottomEqualToView(_logoIv)
        .leftEqualToView(_timeIv)
        .heightIs(19)
        .widthIs(48);
        
        _addressIv.sd_layout
        .centerYEqualToView(_showIv)
        .leftSpaceToView(_showIv, 4)
        .heightIs(20)
        .widthEqualToHeight();
        
        _addressLb.sd_layout
        .centerYEqualToView(_addressIv)
        .leftSpaceToView(_addressIv, 4)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(18);
    
        
    }
    return self;
}


- (void)setModel:(ShowModel *)model{
    _model  = model;
    _titleLb.text = model.title;
    _timeLb.text = [NSString stringWithFormat:@"%@至%@", model.starttime, _model.endtime];
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    
    _addressLb.text = model.address;
}


#pragma mark ----------------实例

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb  = [[UILabel alloc] init];
        _titleLb.font = FONT(19);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}


- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
    }
    return _logoIv;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.textColor = SHENTEXTCOLOR;
        _timeLb.font = FONT(13);
    }
    return _timeLb;
}


- (UIImageView *)timeIv{
    if (!_timeIv) {
        _timeIv = [[UIImageView alloc] initWithImage:IMAGE(@"classify")];
    }
    return _timeIv;
}

- (UIImageView *)showIv{
    if (!_showIv) {
        _showIv = [[UIImageView alloc] initWithImage:IMAGE(@"IMG_0337")];
    }
    return _showIv;
}

- (UIImageView *)addressIv{
    if (!_addressIv) {
        _addressIv = [[UIImageView alloc] init];
        _addressIv.image = IMAGE(@"map");
    }
    return _addressIv;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(18);
        _addressLb.textColor = SHENTEXTCOLOR;
    }
    return _addressLb;
}


@end
