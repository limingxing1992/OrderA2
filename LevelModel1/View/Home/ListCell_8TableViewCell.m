//
//  ListCell_8TableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/7.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ListCell_8TableViewCell.h"

@interface ListCell_8TableViewCell ()
/** 图标背景图*/
@property (nonatomic, strong) UIImageView *BackIv;

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;

/** 现价*/
@property (nonatomic, strong) UILabel *shortLb;

/** 折扣价*/
@property (nonatomic, strong) UILabel *zhekouLb;

/** 库存*/
@property (nonatomic, strong) UILabel *countLb;



@end

@implementation ListCell_8TableViewCell
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
        [self.contentView sd_addSubviews:@[self.titleLb, self.shortLb, self.BackIv, self.zhekouLb, self.countLb]];
        
        
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
        .bottomEqualToView(_BackIv)
        .leftEqualToView(_titleLb)
        .autoHeightRatio(0);
        [_shortLb setSingleLineAutoResizeWithMaxWidth:300];
        [_shortLb setMaxNumberOfLinesToShow:1];
        
        _zhekouLb.sd_layout
        .centerYEqualToView(_shortLb)
        .leftSpaceToView(_shortLb, 22)
        .autoHeightRatio(0);
        [_zhekouLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _countLb.sd_layout
        .centerYEqualToView(_shortLb)
        .rightSpaceToView(self.contentView, 3)
        .autoHeightRatio(0);
        [_countLb setSingleLineAutoResizeWithMaxWidth:300];

        
        
    }
    return self;
}


- (void)setModel:(ProductModel *)model{
    _model = model;
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    _titleLb.text = model.title;
    _countLb.text = [NSString stringWithFormat:@"剩余%@件", model.numall];
    _shortLb.text = [NSString stringWithFormat:@"¥ %@", model.price2];
    NSString *str = [NSString stringWithFormat:@"¥ %@", model.price1];
    _zhekouLb.attributedText = [[NSAttributedString alloc] initWithString:str attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:LIGHTTEXTCOLOR}];
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
        _shortLb.textColor = OrangeCOLOR;
        _shortLb.text = @"¥ 220";
    }
    return _shortLb;
}

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
    }
    return _logoIv;
}

- (UILabel *)zhekouLb{
    if (!_zhekouLb) {
        _zhekouLb = [[UILabel alloc] init];
        _zhekouLb.font = FONT(13);
        _zhekouLb.textColor = LIGHTTEXTCOLOR;
        _zhekouLb.text = @"¥ 230";
    }
    return _zhekouLb;
}

- (UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        _countLb.font = FONT(13);
        _countLb.textColor = LIGHTTEXTCOLOR;
        _countLb.text = @"剩余1000件";
    }
    return _countLb;
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
