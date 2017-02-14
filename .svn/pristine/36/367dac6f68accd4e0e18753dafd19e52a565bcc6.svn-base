//
//  ListCell_9TableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/19.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ListCell_9TableViewCell.h"

@interface ListCell_9TableViewCell ()

@property (nonatomic, strong) UIView *view_1;

@property (nonatomic, strong) UIView *view_2;

@property (nonatomic, strong) UIImageView *iv_1;

@property (nonatomic, strong) UIImageView *iv_2;


@property (nonatomic, strong) UILabel *lb_1;

@property (nonatomic, strong) UILabel *lb_2;





@end

@implementation ListCell_9TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#define SepecialCellWidth (SCREEN_WIDTH- 60)/2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView sd_addSubviews:@[self.view_1, self.view_2]];
        
        _view_1.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 20)
        .bottomSpaceToView(self.contentView, 12.5)
        .widthIs(SepecialCellWidth);
        
        _view_2.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(_view_1, 20)
        .bottomSpaceToView(self.contentView, 12.5)
        .widthIs(SepecialCellWidth);
    }
    return self;
}



- (void)setModel_1:(NewsModel *)model_1{
    _model_1 = model_1;
    
    
    [_iv_1 sd_setImageWithURL:LOGOURL(model_1.logo) placeholderImage:Placeholder_middle];
    _lb_1.text = model_1.title;

}

- (void)setModel_2:(NewsModel *)model_2{
    _model_2 = model_2;
    
    if (model_2 == nil) {
        [_view_2 removeFromSuperview];
    }else{
        [self.contentView addSubview:self.view_2];
        
        [_iv_2 sd_setImageWithURL:LOGOURL(model_2.logo) placeholderImage:Placeholder_middle];
        _lb_2.text = model_2.title;
        

    }
    
    
}

#pragma mark ----------------业务

- (void)touchCompanyBy:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag -100;
    if (tag ==0) {
        if (_block) {
            _block(_model_1);
        }
    }else{
        if (_block) {
            _block(_model_2);
        }
    }
}



#pragma mark ----------------实例

- (UIView *)view_1{
    if (!_view_1) {
        _view_1 = [[UIView alloc] init];
        _view_1.layer.borderWidth = 1;
        _view_1.layer.borderColor= GRAYCOLOR.CGColor;
        
        _view_1.tag = 100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCompanyBy:)];
        [_view_1 addGestureRecognizer:tap];

        
        [_view_1 sd_addSubviews:@[self.iv_1, self.lb_1]];
        
        _iv_1.sd_layout
        .topSpaceToView(_view_1, 0)
        .leftSpaceToView(_view_1, 0)
        .rightSpaceToView(_view_1, 0)
        .bottomSpaceToView(_view_1, 60);
        
        _lb_1.sd_layout
        .topSpaceToView(_iv_1, 23)
        .leftSpaceToView(_view_1, 10)
        .rightSpaceToView(_view_1, 0)
        .bottomSpaceToView(_view_1, 23);

    }
    return _view_1;
}

- (UIView *)view_2{
    if (!_view_2) {
        _view_2 = [[UIView alloc] init];
        _view_2.layer.borderColor = GRAYCOLOR.CGColor;
        _view_2.layer.borderWidth = 1;
        _view_2.tag = 101;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCompanyBy:)];
        [_view_2 addGestureRecognizer:tap];
        
        [_view_2 sd_addSubviews:@[self.iv_2, self.lb_2]];
        
        _iv_2.sd_layout
        .topSpaceToView(_view_2, 0)
        .leftSpaceToView(_view_2, 0)
        .rightSpaceToView(_view_2, 0)
        .bottomSpaceToView(_view_2, 60);
        
        _lb_2.sd_layout
        .topSpaceToView(_iv_2, 23)
        .leftSpaceToView(_view_2, 10)
        .rightSpaceToView(_view_2, 0)
        .bottomSpaceToView(_view_2, 23);

    }
    return _view_2;
}


- (UIImageView *)iv_1{
    if (!_iv_1) {
        _iv_1 = [[UIImageView alloc] init];
    }
    return _iv_1;
}

- (UILabel *)lb_1{
    if (!_lb_1) {
        _lb_1 = [[UILabel alloc] init];
        _lb_1.font = FONT(13);
        _lb_1.textColor = BLACKTEXTCOLOR;
    }
    return _lb_1;
}

- (UIImageView *)iv_2{
    if (!_iv_2) {
        _iv_2 = [[UIImageView alloc] init];
    }
    return _iv_2;
}

- (UILabel *)lb_2{
    if (!_lb_2) {
        _lb_2 = [[UILabel alloc] init];
        _lb_2.font = FONT(13);
        _lb_2.textColor = BLACKTEXTCOLOR;
    }
    return _lb_2;
}



@end
