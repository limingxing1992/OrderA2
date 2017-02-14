//
//  OrderDetailViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/18.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"


@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) OrderModel *detailModel;


@property (nonatomic, strong) UITableView *tablView;

/** 商品列表数据源*/
@property (nonatomic, strong) NSMutableArray *data;


/** 订单信息视图*/
@property (nonatomic, strong) UIView *orderView;


/** 订单编号*/
@property (nonatomic, strong) UILabel *orderNum;

/** 下单时间*/
@property (nonatomic, strong) UILabel *regTimeLb;

/** 总价*/
@property (nonatomic, strong) UILabel *priceLb;

/** 付款状态*/
@property (nonatomic, strong) UILabel *payStyleLb;

/** 订单状态*/
@property (nonatomic, strong) UILabel *orderStyleLb;

/** 收货人*/
@property (nonatomic, strong) UILabel *nameLb;

/** 电话*/
@property (nonatomic, strong) UILabel *phoneLb;

/** 地址*/
@property (nonatomic, strong) UILabel *addressLb;

/** 数量*/
@property (nonatomic, strong) UILabel *numLb;

/** 付款账号*/
@property (nonatomic, strong) UILabel *payPhoneLb;

/** 付款时间*/
@property (nonatomic, strong) UILabel *payTimeLb;

/** 邮编*/
@property (nonatomic, strong) UILabel *postCodeLb;


/** 付款按钮*/
@property (nonatomic, strong) UIButton *payBtn;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"订单详情";
    [self.contentView addSubview:self.orderView];
    [self.contentView addSubview:self.tablView];
    [self setNavi];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _orderView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(240);
    
    _tablView.sd_layout
    .topSpaceToView(_orderView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    
    [self.contentView setupAutoContentSizeWithBottomView:_tablView bottomMargin:20];
    
    [self loadData];
}

- (void)setNavi{
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:self.payBtn];
    self.navigationItem.rightBarButtonItem = bar;
}

#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadData{
    [SVProgressHUD show];
    WeakObj(self);
    [ShareBusinessManager.orderManager getOrderDetailWithDictionary:@{@"id":_orderId} success:^(OrderModel *orderModel) {
        [SVProgressHUD dismiss];
        weakself.detailModel = orderModel;
        [weakself updateUI];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)updateUI{

    _orderNum.text = _detailModel.ordernum;
    _regTimeLb.text = _detailModel.regtime;
    _priceLb.text = _detailModel.price.stringValue;
    _numLb.text = _detailModel.num.stringValue;
    _payPhoneLb.text = _detailModel.payInfo;
    _payTimeLb.text = _detailModel.payTime;
    
    if (_detailModel.payStatus.integerValue == 0) {
        _payStyleLb.text = @"未付款";
        _payStyleLb.textColor = BLACKTEXTCOLOR;
        _payBtn.enabled = YES;
    }else{
        _payStyleLb.text = @"已付款";
        _payStyleLb.textColor = APPColor;
        _payBtn.enabled = NO;
    }
    
    

//     0未发货，1已发货，2交易完成，11已退回
    switch (_detailModel.sendStatus.integerValue) {
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

    
    
    //根据地址id请求地址详情。根据订单号请求商品数据
    [self addressDetailLoad];
    [self goodsDetailListLoad];
    

}
/** 请求地址信息*/
- (void)addressDetailLoad{
    /*********************************************************************
     函数名称 : getAddressDetailWithDictionary:
     函数描述 : 查看地址详情接口（Address_Json）
     输入参数 : id：地址ID
     返回值 : success（addressModel），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    WeakObj(self);
    [ShareBusinessManager.userManager getAddressDetailWithDictionary:@{@"id":_detailModel.addr}
                                                             success:^(AddressModel *addressModel) {
                                                                 weakself.nameLb.text = addressModel.realname;
                                                                 weakself.phoneLb.text = addressModel.tel;
                                                                 weakself.addressLb.text = addressModel.address;
                                                                 weakself.postCodeLb.text = addressModel.postcode;
                                                             } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                 
                                                             }];
}
/** 请求商品*/
- (void)goodsDetailListLoad{
    /*********************************************************************
     函数名称 : getOrderDeatilListWithDictionary:
     函数描述 : 获取订单下的商品列表接口（OrderDetail_List）
     输入参数 : order：订单号
     返回值 : success（prosArray 存放订单商品列表数据（数据为OrderProductModel模型）），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    WeakObj(self);
    [ShareBusinessManager.orderManager getOrderDeatilListWithDictionary:@{@"order":_detailModel.ordernum}
                                                                success:^(NSArray *prosArray) {
                                                                    [weakself.data removeAllObjects];
                                                                    [weakself.data addObjectsFromArray:prosArray];
                                                                    
                                                                    [weakself.tablView reloadData];
                                                                    weakself.tablView.sd_layout
                                                                    .heightIs(115 * prosArray.count);
                                                                } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                    
                                                                }];
}

#pragma mark ----------------付款

- (void)payActionByDetail{
    NSString *str = [NSString stringWithFormat:@"https://appserver.1035.mobi/MobiSoft/Alipay_Send?str=%@", _detailModel.ordernum];
    DetailWebViewController *wb = [[DetailWebViewController alloc] init];
    wb.url = [NSURL URLWithString:str];
    wb.name = @"支付宝支付";
    [self.navigationController pushViewController:wb animated:YES];
}



#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetail"];
    cell.model = _data[indexPath.row];
    return cell;
}

#pragma mark ----------------实例

- (UITableView *)tablView{
    if (!_tablView) {
        _tablView = [[UITableView alloc] init];
        _tablView.delegate = self;
        _tablView.dataSource = self;
        _tablView.separatorColor = BLACKCOLOR;
        _tablView.rowHeight = 115;
        _tablView.separatorInset = UIEdgeInsetsZero;
        _tablView.scrollEnabled = NO;
        [_tablView registerClass:[OrderDetailTableViewCell class] forCellReuseIdentifier:@"orderDetail"];
    }
    return _tablView;
}

- (UIView *)orderView{
    if (!_orderView) {
        _orderView = [[UIView alloc] init];
        _orderView.backgroundColor = WHITECOLOR;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = BLACKCOLOR;
        [_orderView addSubview:lineView];
        lineView.sd_layout
        .bottomSpaceToView(_orderView, 0)
        .leftSpaceToView(_orderView, 0)
        .rightSpaceToView(_orderView, 0)
        .heightIs(0.5);
        
        NSArray *ary = @[@"订单编号：", @"下单时间：", @"总价：", @"付款状态：", @"订单状态：", @"收货人：", @"电话：", @"地址："];
        NSArray *ary_0 = @[@"数量：", @"付款账号：", @"付款时间：", @"邮编："];
        for (NSInteger i = 0; i< ary.count; i++) {
            UILabel *lav = [[UILabel alloc] init];
            lav.font = FONT(12);
            lav.textColor = BLACKCOLOR;
            lav.text = ary[i];
            [_orderView addSubview:lav];
            lav.sd_layout
            .topSpaceToView(_orderView, 10 + i*30)
            .leftSpaceToView(_orderView, 10)
            .widthIs(80)
            .heightIs(12);
        }
        
        for (NSInteger  i = 0; i < ary_0.count; i++) {
            UILabel *lav = [[UILabel alloc] init];
            lav.font = FONT(12);
            lav.textColor = BLACKCOLOR;
            lav.text = ary_0[i];
            [_orderView addSubview:lav];

            CGFloat orygiy;
            if (i ==0) {
                orygiy = 70;
            }else if (i == 1){
                orygiy = 100;
            }else if (i == 2){
                orygiy = 130;
            }else{
                orygiy = 190;
            }
            
            lav.sd_layout
            .topSpaceToView(_orderView, orygiy)
            .leftSpaceToView(_orderView, 200)
            .widthIs(80)
            .heightIs(12);
            
        }

        [_orderView sd_addSubviews:@[self.orderNum, self.regTimeLb, self.priceLb, self.payStyleLb, self.orderStyleLb, self.nameLb, self.phoneLb, self.addressLb,
                                     self.numLb, self.payPhoneLb, self.payTimeLb, self.postCodeLb]];
        
        _orderNum.sd_layout
        .topSpaceToView(_orderView, 10)
        .leftSpaceToView(_orderView, 90)
        .rightSpaceToView(_orderView, 10)
        .heightIs(13);
        
        _regTimeLb.sd_layout
        .topSpaceToView(_orderView, 40)
        .leftSpaceToView(_orderView, 90)
        .rightSpaceToView(_orderView, 10)
        .heightIs(13);
        
        
        _priceLb.sd_layout
        .topSpaceToView(_orderView, 70)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);
        

        _payStyleLb.sd_layout
        .topSpaceToView(_orderView, 100)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);

        _orderStyleLb.sd_layout
        .topSpaceToView(_orderView, 130)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);

        _nameLb.sd_layout
        .topSpaceToView(_orderView, 160)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);

        _phoneLb.sd_layout
        .topSpaceToView(_orderView, 190)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);

        _addressLb.sd_layout
        .topSpaceToView(_orderView, 220)
        .leftSpaceToView(_orderView, 90)
        .widthIs(105)
        .heightIs(13);

        _numLb.sd_layout
        .topSpaceToView(_orderView, 70)
        .leftSpaceToView(_orderView, 270)
        .widthIs(105)
        .heightIs(13);

        _payPhoneLb.sd_layout
        .topSpaceToView(_orderView, 100)
        .leftSpaceToView(_orderView, 270)
        .widthIs(105)
        .heightIs(13);

        _payTimeLb.sd_layout
        .topSpaceToView(_orderView, 130)
        .leftSpaceToView(_orderView, 270)
        .widthIs(105)
        .heightIs(13);

        _postCodeLb.sd_layout
        .topSpaceToView(_orderView, 190)
        .leftSpaceToView(_orderView, 270)
        .widthIs(105)
        .heightIs(13);

        
    }
    return _orderView;

}

- (UILabel *)orderNum{
    if (!_orderNum) {
        _orderNum = [[UILabel alloc] init];
        _orderNum.font = FONT(12);
        _orderNum.textColor = SHENTEXTCOLOR;
    }
    return _orderNum;
}

- (UILabel *)regTimeLb{
    if (!_regTimeLb) {
        _regTimeLb = [[UILabel alloc] init];
        _regTimeLb.font = FONT(12);
        _regTimeLb.textColor = SHENTEXTCOLOR;
    }
    return _regTimeLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(12);
        _priceLb.textColor = SHENTEXTCOLOR;
    }
    return _priceLb;
}

- (UILabel *)payStyleLb{
    if (!_payStyleLb) {
        _payStyleLb = [[UILabel alloc] init];
        _payStyleLb.font = FONT(12);
        _payStyleLb.textColor = SHENTEXTCOLOR;
    }
    return _payStyleLb;
}

- (UILabel *)orderStyleLb{
    if (!_orderStyleLb) {
        _orderStyleLb = [[UILabel alloc] init];
        _orderStyleLb.font = FONT(12);
        _orderStyleLb.textColor = SHENTEXTCOLOR;
    }
    return _orderStyleLb;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(12);
        _nameLb.textColor = SHENTEXTCOLOR;
    }
    return _nameLb;
}

- (UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.font = FONT(12);
        _phoneLb.textColor = SHENTEXTCOLOR;
    }
    return _phoneLb;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(12);
        _addressLb.textColor = SHENTEXTCOLOR;
    }
    return _addressLb;
}

- (UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc] init];
        _numLb.font = FONT(12);
        _numLb.textColor = SHENTEXTCOLOR;
    }
    return _numLb;
}

- (UILabel *)payPhoneLb{
    if (!_payPhoneLb) {
        _payPhoneLb = [[UILabel alloc] init];
        _payPhoneLb.font = FONT(12);
        _payPhoneLb.textColor = SHENTEXTCOLOR;
    }
    return _payPhoneLb;
}

- (UILabel *)payTimeLb{
    if (!_payTimeLb) {
        _payTimeLb = [[UILabel alloc] init];
        _payTimeLb.font = FONT(12);
        _payTimeLb.textColor = SHENTEXTCOLOR;
    }
    return _payTimeLb;
}

- (UILabel *)postCodeLb{
    if (!_postCodeLb) {
        _postCodeLb = [[UILabel alloc] init];
        _postCodeLb.font = FONT(12);
        _postCodeLb.textColor = SHENTEXTCOLOR;
    }
    return _postCodeLb;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitle:@"" forState:UIControlStateDisabled];
        _payBtn.titleLabel.font = FONT(14);
        [_payBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payActionByDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;

}
@end
