//
//  CarProductTableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/10.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "CarProductTableViewCell.h"

@interface CarProductTableViewCell ()
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 单价标题*/
@property (nonatomic, strong) UILabel *priceTitleLb;
/** 数量标题*/
@property (nonatomic, strong) UILabel *countTitleLb;
/** 价格*/
@property (nonatomic, strong) UILabel *priceLb;
/** 价格单位*/
@property (nonatomic, strong) UILabel *priceArcLb;
/** 减号*/
@property (nonatomic, strong) UIButton *subBtn;
/** 加号*/
@property (nonatomic, strong) UIButton *addBtn;
/** 数量*/
@property (nonatomic, strong) UILabel *countLb;
/** log*/
@property (nonatomic, strong) UIImageView *logoIv;





@end

@implementation CarProductTableViewCell

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
        [self.contentView sd_addSubviews:@[self.selectBtn, self.logoIv, self.titleLb, self.priceTitleLb, self.countTitleLb,
                                           self.priceLb, self.priceArcLb, self.subBtn, self.addBtn, self.countLb,
                                           self.deletBtn]];
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
    
    _logoIv.sd_layout
    .leftSpaceToView(_selectBtn, 7)
    .topSpaceToView(self.contentView, 25)
    .bottomSpaceToView(self.contentView, 25)
    .widthEqualToHeight();

    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 27)
    .leftSpaceToView(_logoIv, 5)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(20);
    
    _priceTitleLb.sd_layout
    .centerYEqualToView(_logoIv)
    .leftEqualToView(_titleLb)
    .heightIs(17);
    [_priceTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _countTitleLb.sd_layout
    .topSpaceToView(_priceTitleLb, 25)
    .leftEqualToView(_priceTitleLb)
    .heightIs(17);
    [_countTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _priceLb.sd_layout
    .centerYEqualToView(_priceTitleLb)
    .leftSpaceToView(_priceTitleLb, 0)
    .heightRatioToView(_priceTitleLb, 1);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _priceArcLb.sd_layout
    .centerYEqualToView(_priceLb)
    .leftSpaceToView(_priceLb, 0)
    .heightRatioToView(_priceLb, 1);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _deletBtn.sd_layout
    .centerYEqualToView(_priceArcLb)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(25)
    .widthEqualToHeight();
    
    _subBtn.sd_layout
    .centerYEqualToView(_countTitleLb)
    .leftSpaceToView(_countTitleLb, 15)
    .heightIs(25)
    .widthEqualToHeight();
    
    _countLb.sd_layout
    .centerYEqualToView(_countTitleLb)
    .leftSpaceToView(_subBtn, 0)
    .heightIs(35)
    .widthIs(55);
    [_countLb setSd_cornerRadius:@5];
    
    _addBtn.sd_layout
    .centerYEqualToView(_countLb)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(25)
    .widthEqualToHeight();
    
}

#pragma mark ----------------数据

- (void)setModel:(CartModel *)model{
    _model = model;
    /** 
     @property (nonatomic, copy) NSNumber *cid;        //应用ID
     @property (nonatomic, copy) NSNumber *ID;         //购物车ID
     @property (nonatomic, copy) NSNumber *isGroup;    //是否团购  1-是 0-否
     @property (nonatomic, copy) NSString *logo;       //图片
     @property (nonatomic, copy) NSNumber *num;        //商品数量
     @property (nonatomic, copy) NSNumber *price;      //价格
     @property (nonatomic, copy) NSNumber *proid;      //商品ID
     @property (nonatomic, copy) NSString *regtime;    //添加时间
     @property (nonatomic, copy) NSString *title;      //商品名称
     @property (nonatomic, copy) NSNumber *uid;        //用户ID

     */
    _countLb.text = [model.num stringValue];
    _titleLb.text = model.title;
    _priceLb.text = [NSString stringWithFormat:@"%.2f", model.price.floatValue];
    [_logoIv sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_middle];
    [_selectBtn setSelected:_model.isSelect];
    
    if ([_model.isGroup isEqualToNumber:@1]) {
        _subBtn.sd_layout
        .heightIs(0);
        _addBtn.sd_layout
        .heightIs(0);
    }else{
        _subBtn.sd_layout
        .heightIs(25);
        _addBtn.sd_layout
        .heightIs(25);

    }

    
}


#pragma mark ----------------业务

- (void)subAction{
    

    
    NSInteger count = [_model.num integerValue];
    if (count != 1) {
        count -= 1;
    }
    
    _model.num = [NSNumber numberWithInteger:count];
    _countLb.text = [_model.num stringValue];
    [self changeCountByCoun:_countLb.text];
    
}

- (void)addAction{
    
    NSInteger count = [_model.num integerValue];
    count += 1;
    _model.num = [NSNumber numberWithInteger:count];
    _countLb.text = [_model.num stringValue];
    [self changeCountByCoun:_countLb.text];
}

- (void)changeCountByCoun:(NSString *)count{
    /*********************************************************************
     函数名称 : modifyCartNumWithDictionary:
     函数描述 : 修改购物车中商品的数量接口（Cart_Num）
     输入参数 : id：购物车ID, num：商品数量
     返回值 :  success：1，responseFailure：0
     作者   : 张永亮
     *********************************************************************/

    WeakObj(self);
    [ShareBusinessManager.mallManager modifyCartNumWithDictionary:@{@"id":_model.ID,
                                                                    @"num":count}
                                                          success:^(id object) {
                                                              
                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                              [SVProgressHUD showErrorWithStatus:@"修改失败"];
                                                          }];
    [NotificationCenter postNotificationName:CalculateOrderName object:nil];
}



#pragma mark ----------------实例

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:IMAGE(@"selectAddrBg") forState:UIControlStateNormal];
        [_selectBtn setImage:IMAGE(@"selectAddress") forState:UIControlStateSelected];
    }
    return _selectBtn;
}

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        _logoIv.image = Placeholder_middle;
    }
    return _logoIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(20);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UILabel *)priceTitleLb{
    if (!_priceTitleLb) {
        _priceTitleLb = [[UILabel alloc] init];
        _priceTitleLb.font = FONT(17);
        _priceTitleLb.textColor = BLACKTEXTCOLOR;
        _priceTitleLb.text = @"单价：";
    }
    return _priceTitleLb;
}

- (UILabel *)countTitleLb{
    if (!_countTitleLb) {
        _countTitleLb = [[UILabel alloc] init];
        _countTitleLb.font = FONT(17);
        _countTitleLb.textColor = BLACKTEXTCOLOR;
        _countTitleLb.text = @"数量：";
    }
    return _countTitleLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(17);
        _priceLb.textColor = [UIColor redColor];
    }
    return _priceLb;
}

- (UILabel *)priceArcLb{
    if (!_priceArcLb) {
        _priceArcLb = [[UILabel alloc] init];
        _priceArcLb.font = FONT(17);
        _priceArcLb.textColor = BLACKTEXTCOLOR;
        _priceArcLb.text = @"元";
    }
    return _priceArcLb;
}

- (UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn = [[UIButton alloc] init];
        _subBtn.titleLabel.font = FONT(15);
        [_subBtn setTitle:@"-" forState:UIControlStateNormal];
        [_subBtn setTitleColor:APPColor forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        _addBtn.titleLabel.font = FONT(15);
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:APPColor forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc] init];
        _countLb.font = FONT(15);
        _countLb.textColor = BLACKTEXTCOLOR;
        _countLb.layer.borderColor = GRAYCOLOR.CGColor;
        _countLb.layer.borderWidth = 1;
        
        _countLb.backgroundColor = BACKGROUNDCOLOR;
        _countLb.textAlignment  = NSTextAlignmentCenter;
    }
    return _countLb;
}

- (UIButton *)deletBtn{
    if (!_deletBtn) {
        _deletBtn = [[UIButton alloc] init];
        [_deletBtn setImage:IMAGE(@"bt_delete") forState:UIControlStateNormal];
    }
    return _deletBtn;
}

@end
