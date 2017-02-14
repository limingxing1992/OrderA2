//
//  OrderListTableViewCell.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/12.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "OrderListTableViewCell.h"


@interface OrderListTableViewCell ()

@property (nonatomic, strong) UILabel *orderNumLb;

@property (nonatomic, strong) UILabel *priceLb;

@property (nonatomic, strong) UILabel *timeLb;

@property (nonatomic, strong) UILabel *numLb;

@property (nonatomic, strong) UILabel *payStyleLb;

@property (nonatomic, strong) UILabel *orderStyleLb;

@property (nonatomic, strong) UIButton *payBtn;



@end

@implementation OrderListTableViewCell

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
        [self.contentView sd_addSubviews:@[self.orderNumLb, self.priceLb, self.timeLb, self.numLb,
                                           self.payStyleLb, self.orderStyleLb, self.payBtn]];
        
        [self autoLayoutSubViews];
    }
    return self;
}


- (void)autoLayoutSubViews{
    
    NSArray *titleAry = @[@"单号：", @"总价：", @"时间：", @"数量："];
    
    for (NSInteger i = 0 ; i < titleAry.count; i++) {
        UILabel *lb = [[UILabel alloc] init];
        lb.font = FONT(13);
        lb.textColor = BLACKTEXTCOLOR;
        lb.text = titleAry[i];
        [self.contentView addSubview:lb];
        lb.sd_layout
        .centerYIs(25 + 20 *i)
        .leftSpaceToView(self.contentView, 15)
        .autoHeightRatio(0);
        [lb setSingleLineAutoResizeWithMaxWidth:300];
        
        if (i ==0) {
            _orderNumLb.sd_layout
            .centerYEqualToView(lb)
            .leftSpaceToView(lb, 0)
            .rightSpaceToView(self.contentView, 15)
            .autoHeightRatio(0);
        }
    }
    
    _priceLb.sd_layout
    .centerYIs(45)
    .leftEqualToView(_orderNumLb)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _timeLb.sd_layout
    .centerYIs(65)
    .leftEqualToView(_orderNumLb)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _numLb.sd_layout
    .centerYIs(85)
    .leftEqualToView(_orderNumLb)
    .rightSpaceToView(self.contentView, 200)
    .autoHeightRatio(0);
    
    UILabel *payStyleTitleLb = [[UILabel alloc] init];
    payStyleTitleLb.font = FONT(13);
    payStyleTitleLb.textColor = BLACKTEXTCOLOR;
    payStyleTitleLb.text = @"付款状态：";
    [self.contentView addSubview:payStyleTitleLb];
    payStyleTitleLb.sd_layout
    .centerYIs(105)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [payStyleTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    _payStyleLb.sd_layout
    .centerYEqualToView(payStyleTitleLb)
    .leftSpaceToView(payStyleTitleLb,0)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    UILabel *orderStyleTitleLb = [[UILabel alloc] init];
    orderStyleTitleLb.font = FONT(13);
    orderStyleTitleLb.textColor = BLACKTEXTCOLOR;
    orderStyleTitleLb.text = @"订单状态：";
    [self.contentView addSubview:orderStyleTitleLb];
    
    orderStyleTitleLb.sd_layout
    .centerYIs(125)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [orderStyleTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _orderStyleLb.sd_layout
    .centerYEqualToView(orderStyleTitleLb)
    .leftSpaceToView(orderStyleTitleLb, 0)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    
    _payBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(38)
    .widthIs(68);

}

#pragma mark ----------------业务

- (void)payOrderAction{
    
    /*********************************************************************
     函数名称 : payOrderWithDictionary:
     函数描述 : 提交支付接口（Order_Pay）
     输入参数 : id ：订单ID, uid：用户ID
     返回值 :  success：1，responseFailure：0
     作者   : 张永亮
     
     *********************************************************************/
    NSString *str = [NSString stringWithFormat:@"https://appserver.1035.mobi/MobiSoft/Alipay_Send?str=%@", _model.ordernum];
    if (_block) {
        _block(str);
    }

}

- (void)setModel:(OrderModel *)model{
    _model = model;
    _orderNumLb.text = model.ordernum;
    _priceLb.text = model.price.stringValue;
    _timeLb.text = model.regtime;
    _numLb.text = model.num.stringValue;
    
    if (model.payStatus.integerValue == 0) {
        _payStyleLb.text = @"未付款";
        _payBtn.sd_layout
        .heightIs(38);
        _payStyleLb.textColor = BLACKTEXTCOLOR;
    }else{
        _payStyleLb.text = @"已付款";
        _payStyleLb.textColor = APPColor;
        _payBtn.sd_layout
        .heightIs(0);
    }
    /** 
     0未发货，1已发货，2交易完成，11已退回
     */
    switch (model.sendStatus.integerValue) {
        case 0:
        {
            _orderStyleLb.text = @"未发货";
        }
            break;
        case 1:
        {
            _orderStyleLb.text = @"已发货";
        }
            break;
        case 2:
        {
            _orderStyleLb.text = @"交易完成";
        }
            break;
        case 3:
        {
            _orderStyleLb.text = @"已退回";
        }
            break;
        default:
            break;
    }
}

#pragma mark ----------------实例

- (UILabel *)orderNumLb{
    if (!_orderNumLb) {
        _orderNumLb = [[UILabel alloc] init];
        _orderNumLb.font = FONT(13);
        _orderNumLb.textColor = BLACKTEXTCOLOR;
    }
    return _orderNumLb;

}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(13);
        _priceLb.textColor = BLACKTEXTCOLOR;
    }
    return _priceLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(13);
        _timeLb.textColor = BLACKTEXTCOLOR;
    }
    return _timeLb;
}

- (UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc] init];
        _numLb.font = FONT(13);
        _numLb.textColor = BLACKTEXTCOLOR;
    }
    return _numLb;
}

- (UILabel *)payStyleLb{
    if (!_payStyleLb) {
        _payStyleLb = [[UILabel alloc] init];
        _payStyleLb.font = FONT(13);
        _payStyleLb.textColor = [UIColor redColor];
    }
    return _payStyleLb;
}

- (UILabel *)orderStyleLb{
    if (!_orderStyleLb) {
        _orderStyleLb = [[UILabel alloc] init];
        _orderStyleLb.font = FONT(13);
        _orderStyleLb.textColor = [UIColor redColor];
    }
    return _orderStyleLb;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] init];
        [_payBtn setBackgroundImage:IMAGE(@"bg_buy") forState:UIControlStateNormal];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = FONT(14);
        [_payBtn addTarget:self action:@selector(payOrderAction) forControlEvents:UIControlEventTouchUpInside];
        [_payBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    }
    return _payBtn;

}




@end
