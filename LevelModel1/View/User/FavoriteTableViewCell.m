//
//  FavoriteTableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/17.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@interface FavoriteTableViewCell ()
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 简介*/
@property (nonatomic, strong) UILabel *shortLb;
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;


@end

@implementation FavoriteTableViewCell

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
        [self.contentView sd_addSubviews:@[self.titleLb, self.shortLb, self.logoIv]];
        
        
        _logoIv.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(70)
        .widthIs(70);
        
        
        self.titleLb.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(_logoIv, 10)
        .autoHeightRatio(0);
        [_titleLb setMaxNumberOfLinesToShow:2];
        
        
        _shortLb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .leftEqualToView(_titleLb)
        .rightEqualToView(_titleLb)
        .autoHeightRatio(0);
        [_shortLb setMaxNumberOfLinesToShow:2];
        
    }
    return self;
}


- (void)setFavoModel:(FavModel *)favoModel{
    _favoModel = favoModel;
    
    _titleLb.text = favoModel.infotitle;
    _shortLb.text = [NSString stringWithFormat:@"收藏时间：%@", favoModel.regtime];
    
    
    if (favoModel.infologo.length == 0 || [favoModel.infologo isEqualToString:@"0.gif"]) {
        _logoIv.sd_layout
        .widthIs(0);
    }else{
        _logoIv.sd_layout
        .widthIs(70);
        if ([favoModel.infotype isEqualToString:@"needs"]) {
            NSString *url = [NSString stringWithFormat:@"https://appserver.1035.mobi/MobiSoft/upload/%@", favoModel.infologo];
            [_logoIv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:Placeholder_middle];
        }else{
            [_logoIv sd_setImageWithURL:LOGOURL(favoModel.infologo) placeholderImage:Placeholder_middle];
        }
    }
    
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

@end
