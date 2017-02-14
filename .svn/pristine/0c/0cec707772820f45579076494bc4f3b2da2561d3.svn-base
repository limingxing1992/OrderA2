//
//  AddressTableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/11.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell ()

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) UILabel *phoneLb;

@property (nonatomic, strong) UILabel *postCodeLb;

@property (nonatomic, strong) UILabel *addressLb;





@end

@implementation AddressTableViewCell

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
        [self.contentView sd_addSubviews:@[self.selectBtn, self.deletBtn, self.phoneLb, self.nameLb, self.postCodeLb, self.addressLb]];
        
        [self autoLayoutSubViews];
    }
    return self;
}

- (void)autoLayoutSubViews{
    _selectBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(25)
    .widthEqualToHeight();
    
    _deletBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(25)
    .widthEqualToHeight();
    
    NSArray *art = @[@"名称：", @"电话：", @"邮编：", @"地址："];
    
    for (NSInteger i = 0; i < art.count; i++) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = FONT(16);
        titleLb.textColor = BLACKTEXTCOLOR;
        titleLb.text = art[i];
        [self.contentView addSubview:titleLb];
        titleLb.sd_layout
        .centerYIs(30 + 25 *i)
        .leftSpaceToView(_selectBtn, 5)
        .heightIs(16);
        [titleLb setSingleLineAutoResizeWithMaxWidth:300];
        
        if (i==0) {
            _nameLb.sd_layout
            .centerYEqualToView(titleLb)
            .leftSpaceToView(titleLb, 7)
            .heightIs(16);
            [_nameLb setSingleLineAutoResizeWithMaxWidth:300];
        }
    }
    
    _phoneLb.sd_layout
    .centerYIs(55)
    .leftEqualToView(_nameLb)
    .heightRatioToView(_nameLb, 1);
    [_phoneLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _postCodeLb.sd_layout
    .centerYIs(80)
    .leftEqualToView(_nameLb)
    .heightRatioToView(_nameLb, 1);
    [_postCodeLb setSingleLineAutoResizeWithMaxWidth:300];

    _addressLb.sd_layout
    .centerYIs(105)
    .leftEqualToView(_nameLb)
    .heightRatioToView(_nameLb, 1);
    [_addressLb setSingleLineAutoResizeWithMaxWidth:300];

}

- (void)setModel:(AddressModel *)model{
    _model = model;
    
    /** 
     @property (nonatomic, copy) NSString *address;       //地址
     @property (nonatomic, copy) NSNumber *ID;            //图片
     @property (nonatomic, copy) NSNumber *isDefault;     //默认地址
     @property (nonatomic, copy) NSString *postcode;      //邮编
     @property (nonatomic, copy) NSString *realname;      //姓名
     @property (nonatomic, copy) NSString *tel;           //电话号码
     @property (nonatomic, copy) NSNumber *uid;           //用户id

     */
    _phoneLb.text = model.tel;
    _nameLb.text = model.realname;
    _postCodeLb.text = model.postcode;
    _addressLb.text = model.address;
}

#pragma mark ----------------实例

- (UIButton *)deletBtn{
    if (!_deletBtn) {
        _deletBtn = [[UIButton alloc] init];
        [_deletBtn setImage:IMAGE(@"bt_delete") forState:UIControlStateNormal];
    }
    return _deletBtn;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:IMAGE(@"selectAddrBg") forState:UIControlStateNormal];
        [_selectBtn setImage:IMAGE(@"selectAddress") forState:UIControlStateSelected];
    }
    return _selectBtn;
}


- (UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.font = FONT(15);
        _phoneLb.textColor = BLACKTEXTCOLOR;
    }
    return _phoneLb;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(15);
        _nameLb.textColor = BLACKTEXTCOLOR;
    }
    return _nameLb;
}

- (UILabel *)postCodeLb{
    if (!_postCodeLb) {
        _postCodeLb = [[UILabel alloc] init];
        _postCodeLb.font = FONT(15);
        _postCodeLb.textColor = BLACKTEXTCOLOR;
    }
    return _postCodeLb;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(15);
        _addressLb.textColor = BLACKTEXTCOLOR;
    }
    return _addressLb;
}
@end
