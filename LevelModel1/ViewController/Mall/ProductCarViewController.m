//
//  ProductCarViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/10.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ProductCarViewController.h"
#import "CarProductTableViewCell.h"

@interface ProductCarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

/** 结算视图*/
@property (nonatomic, strong) UIView *totoalView;
/** 下单按钮*/
@property (nonatomic, strong) UIButton *buyBtn;

/** 总价*/
@property (nonatomic, strong) UILabel *totalPriceLb;
@property (nonatomic, assign) float totalPrice;

/** 进入订单中心按钮*/
@property (nonatomic, strong) UIButton *orderListBtn;



@end

NSString *const carCell = @"carCell";

@implementation ProductCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"购物车";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.totoalView];
    _totoalView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(70);
    
    [NotificationCenter addObserver:self selector:@selector(calculateOrderPrice) name:CalculateOrderName object:nil];

    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:self.orderListBtn];
    self.navigationItem.rightBarButtonItem = itme;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    [self calculateOrderPrice];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self];
}

#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadData{
    /*********************************************************************
     函数名称 : getMyCartListWithDictionary:
     函数描述 : 获取我的购物车接口（Cart_List）
     输入参数 : cid：应用ID, uid：用户ID
     返回值 : success（cartsArray 存放购物车列表数据（数据为CartModel模型）），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    [SVProgressHUD show];
    WeakObj(self);
    [ShareBusinessManager.mallManager getMyCartListWithDictionary:@{@"cid":APPCID,
                                                                    @"uid":UserID}
                                                          success:^(NSArray *cartsArray) {
                                                              [weakself.data removeAllObjects];
                                                              [weakself.data addObjectsFromArray:cartsArray];
                                                              [weakself.tableView reloadData];
                                                              [SVProgressHUD dismiss];
                                                          }
                                                          failure:^(NSInteger errCode, NSString *errorMsg) {
                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                          }];
}

#pragma mark ----------------业务
/** 选中*/
- (void)selectProduct:(UIButton *)btn{
    NSInteger tag = btn.tag - 1000;
    CartModel *model = _data[tag];
    if (btn.isSelected) {
        //取消选择
        model.isSelect = NO;
    }else{
        //选中
        model.isSelect = YES;
    }
    btn.selected = !btn.isSelected;
    
    [self calculateOrderPrice];


}
/**移除购物车*/
- (void)deleteProduct:(UIButton *)btn{
    NSInteger tag = btn.tag - 100;
    CartModel *model = _data[tag];
    [self.data removeObjectAtIndex:tag];

    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    //静默删除业务
    /*********************************************************************
     函数名称 : delCartProductWithDictionary:
     函数描述 : 移除购物车中的商品接口（Cart_Del）
     输入参数 : id：购物车ID
     返回值 :  success：1，responseFailure：0
     作者   : 张永亮
     *********************************************************************/
    [ShareBusinessManager.mallManager delCartProductWithDictionary:@{@"id":model.ID}
                                                           success:^(id object) {
                                                               
                                                           }
                                                           failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           }];

    [self calculateOrderPrice];
}
/** 结算-进入地址列表*/
- (void)buyOrderAction{
    
    NSMutableArray *selectData = [[NSMutableArray alloc] init];
    NSMutableArray *noSelectData = [[NSMutableArray alloc] init];
    for (CartModel *model in _data) {
        if (model.isSelect == NO) {
            [noSelectData addObject:model];
        }else{
            [selectData addObject:model];
        }
    }
    
    if (selectData.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品"];
        return;
    }
    
    AddressListViewController *list = [[AddressListViewController alloc] init];
    list.selecData = selectData;
    list.noSelectData = noSelectData;
    [self.navigationController pushViewController:list animated:YES];

}

/** 计算当前订单金额*/
- (void)calculateOrderPrice{
    _totalPrice = 0;
    for (CartModel *model in _data) {
        if (model.isSelect == YES) {
            _totalPrice += model.price.floatValue * model.num.floatValue;
        }
    }
    
    _totalPriceLb.text = [NSString stringWithFormat:@"%.2f",_totalPrice];
}
/** 进入订单中心*/
- (void)intoOrderListVcAction{
    OrderListViewController *order = [[OrderListViewController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:carCell];
    cell.model = _data[indexPath.row];
    cell.deletBtn.tag = 100 +indexPath.row;
    cell.selectBtn.tag = 1000 + indexPath.row;
    [cell.deletBtn addTarget:self action:@selector(deleteProduct:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn addTarget:self action:@selector(selectProduct:) forControlEvents:UIControlEventTouchUpInside];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 152.5;
}

#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 70)];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CarProductTableViewCell class] forCellReuseIdentifier:carCell];
    }
    return _tableView;
}

- (UIView *)totoalView{
    if (!_totoalView) {
        _totoalView = [[UIView alloc] init];
        _totoalView.backgroundColor = BACKGROUNDCOLOR;
        [_totoalView addSubview:self.buyBtn];
        [_totoalView addSubview:self.totalPriceLb];
        UILabel *priceTotalTitleLb = [[UILabel alloc] init];
        priceTotalTitleLb.font = FONT(18);
        priceTotalTitleLb.textColor = OrangeCOLOR;
        priceTotalTitleLb.text = @"合计：";
        [_totoalView addSubview:priceTotalTitleLb];
        
        UILabel *unitLb = [[UILabel alloc] init];
        unitLb.font = FONT(18);
        unitLb.text = @"元";
        unitLb.textColor = OrangeCOLOR;
        [_totoalView addSubview:unitLb];
        
        priceTotalTitleLb.sd_layout
        .centerYEqualToView(_totoalView)
        .leftSpaceToView(_totoalView, 15)
        .autoHeightRatio(0);
        [priceTotalTitleLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _totalPriceLb.sd_layout
        .centerYEqualToView(priceTotalTitleLb)
        .leftSpaceToView(priceTotalTitleLb, 5)
        .heightIs(18);
        [_totalPriceLb setSingleLineAutoResizeWithMaxWidth:200];
        
        _buyBtn.sd_layout
        .centerYEqualToView(priceTotalTitleLb)
        .rightSpaceToView(_totoalView, 20)
        .heightIs(38)
        .widthIs(110);
        
        unitLb.sd_layout
        .centerYEqualToView(priceTotalTitleLb)
        .leftSpaceToView(_totalPriceLb,3)
        .rightSpaceToView(_buyBtn, 3)
        .heightIs(18);
        
//        [_totoalView addSubview:self. ]
    }
    return _totoalView;
}

- (UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] init];
        _buyBtn.titleLabel.font = FONT(16);
        [_buyBtn setTitle:@"下订单" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:IMAGE(@"list_footer_btn_normal") forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UILabel *)totalPriceLb{
    if (!_totalPriceLb) {
        _totalPriceLb = [[UILabel alloc] init];
        _totalPriceLb.font  = FONT(18);
        _totalPriceLb.textColor = OrangeCOLOR;
        _totalPriceLb.text = @"0.00";
    }
    return _totalPriceLb;
}

- (UIButton *)orderListBtn{
    if (!_orderListBtn) {
        _orderListBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        _orderListBtn.titleLabel.font = FONT(15);
        [_orderListBtn setTitle:@"订单" forState:UIControlStateNormal];
        [_orderListBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_orderListBtn addTarget:self action:@selector(intoOrderListVcAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderListBtn;
}
@end
