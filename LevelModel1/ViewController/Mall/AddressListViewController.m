//
//  AddressListViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/11.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressTableViewCell.h"

@interface AddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 添加新地址按钮*/
@property (nonatomic, strong) UIButton *rightBtn;

/** 地址列表*/
@property (nonatomic, strong) UITableView *tableView;

/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;

/** 上次选中的按钮*/
@property (nonatomic, strong) UIButton *lastSelectBtn;

/** 当前选中地址*/
@property (nonatomic, strong) AddressModel *currentModel;

/** 结算视图*/
@property (nonatomic, strong) UIView *totoalView;
/** 下单按钮*/
@property (nonatomic, strong) UIButton *buyBtn;

/** 总价*/
@property (nonatomic, strong) UILabel *totalPriceLb;

/** 已删除数组*/
@property (nonatomic, strong) NSMutableArray *didDelAry;


@end

static NSString *const addressId = @"addressCellId";

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"地址列表";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.totoalView];
    _totoalView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(70);

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _didDelAry = [[NSMutableArray alloc] init];
}

- (void)loadData{
    /*********************************************************************
     函数名称 : getAddressListWithDictionary:
     函数描述 : 获取收货地址列表接口（Address_List ）
     输入参数 : uid：用户ID
     返回值 : success（addressArray 存放地址列表数据（数据为AddressModel模型）），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    [SVProgressHUD show];
    WeakObj(self);
    
    [ShareBusinessManager.userManager getAddressListWithDictionary:@{@"uid":UserID}
                                                           success:^(NSArray *addressArray) {
                                                               [SVProgressHUD dismiss];
                                                               [weakself.data removeAllObjects];
                                                               [weakself.data addObjectsFromArray:addressArray];
                                                               [weakself.tableView reloadData];
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           }];
    
}


#pragma mark ----------------业务
/** 进入新增地址列表*/
- (void)intoAddAddressVcAction{
    //进入添加新地址列表
    CreateAddressViewController *create = [[CreateAddressViewController alloc] init];
    [self.navigationController pushViewController: create animated:YES];
}
/** 选择地址*/
- (void)selectAddress:(UIButton *)btn{
    NSInteger tag = btn.tag - 100000;
    
    if (btn.isSelected) {
        //取消
        _currentModel = nil;
        _lastSelectBtn = nil;
    }else{
        //选中
        if (_currentModel) {
            //如果有已选中位置,取消上次选中
            _lastSelectBtn.selected = NO;
        }
        _currentModel = _data[tag];
        _lastSelectBtn = btn;
    }
    
    btn.selected = !btn.isSelected;
    
    
}
/** 删除地址*/
- (void)deleteAddress:(UIButton *)btn{
    NSInteger tag = btn.tag - 10000;
    AddressModel *model = _data[tag];
    [self.data removeObject:model];
    
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    /*********************************************************************
     函数名称 : delAddressWithDictionary:
     函数描述 : 删除收货地址接口（Address_Del）
     输入参数 : uid：用户ID id：地址ID
     返回值 : success：1，responseFailure：0
     作者   : 张永亮
     *********************************************************************/
    [ShareBusinessManager.userManager delAddressWithDictionary:@{@"uid":UserID,
                                                                 @"id":model.ID}
                                                       success:^(id object) {
                                                           
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {                                                
                                                       }];

}
/** 结算-生成订单进入订单列表*/
- (void)buyOrderAction{
    if (_currentModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    [SVProgressHUD showWithStatus:@"提交订单中"];
    //业务逻辑为。先删除购物车内未选中商品---下单 ----添加未选中商品至购物车）
    
    
    if (self.noSelectData.count) {
        __block NSInteger count = 0;
        WeakObj(self);
        for (NSInteger i = 0; i < self.noSelectData.count; i++) {
            CartModel *model = _noSelectData[i];
            
            [ShareBusinessManager.mallManager delCartProductWithDictionary:@{@"id":model.ID} success:^(id object) {
                count += 1;//删除一个计数器加1
                [weakself.didDelAry addObject:model];
                [weakself sumbitOrderByDelCount:count];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:@"订单提交失败"];
            }];
        }
    }else{
        [self sumbitOrderByDelCount:0];
    }

}
/** 删除完成。执行下单操作*/
- (void)sumbitOrderByDelCount:(NSInteger)count{
    if (count == _noSelectData.count) {
        //删除完成
        WeakObj(self);
        [ShareBusinessManager.orderManager submitOrderWithDictionary:@{@"obj.uid":UserID,
                                                                       @"obj.cid":APPCID,
                                                                       @"obj.addr":_currentModel.ID}
                                                             success:^(id object) {
                                                                 //下单成功
                                                                 [weakself addProductToCar];
                                                             } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                 //下单失败
                                                                 [SVProgressHUD showErrorWithStatus:@"订单提交失败请重试"];
                                                             }];
    }

}
/** 将删除的商品添加回购物车*/
- (void)addProductToCar{
    __block NSInteger addCount = 0;

    if (_didDelAry.count) {
        for (NSInteger i = 0; i < _didDelAry.count; i++) {
            CartModel *model = _didDelAry[i];
            WeakObj(self);
            [ShareBusinessManager.mallManager addCartWithDictionary:@{@"obj.uid":UserID,
                                                                      @"obj.cid":APPCID,
                                                                      @"obj.proid":model.proid,
                                                                      @"obj.isGroup":@0,
                                                                      @"obj.num":model.num}
                                                            success:^(id object) {
                                                                addCount++;
                                                                [weakself intoOrderListActionByCount:addCount];
                                                            } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                [SVProgressHUD showErrorWithStatus:@"添加失败"];
                                                            }];
        }

    }else{
        [self intoOrderListActionByCount:0];
    }
    
}
/** 所有操作执行完成 -- 跳转订单页面*/
- (void)intoOrderListActionByCount:(NSInteger)count{
    if (count == _didDelAry.count) {
        //添加完成
        [SVProgressHUD dismiss];
        OrderListViewController *listVc = [[OrderListViewController alloc] init];
        [self.navigationController pushViewController:listVc animated:YES];
    }
}

#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressId];
    cell.model = _data[indexPath.row];
    cell.deletBtn.tag = 10000 +indexPath.row;
    cell.selectBtn.tag = 100000 + indexPath.row;
    [cell.deletBtn addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
    return cell;

}


#pragma mark ----------------实例

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _rightBtn.titleLabel.font = FONT(15);
        [_rightBtn setTitle:@"新地址" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(intoAddAddressVcAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 70)];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:addressId];
    }
    return _tableView;
}

- (UIView *)totoalView{
    if (!_totoalView) {
        _totoalView = [[UIView alloc] init];
        _totoalView.backgroundColor = BACKGROUNDCOLOR;
        [_totoalView addSubview:self.buyBtn];
        [_totoalView addSubview:self.totalPriceLb];
        
        _buyBtn.sd_layout
        .centerYEqualToView(_totoalView)
        .rightSpaceToView(_totoalView, 20)
        .heightIs(38)
        .widthIs(110);

        _totalPriceLb.sd_layout
        .centerYEqualToView(_totoalView)
        .leftSpaceToView(_totoalView, 25)
        .rightSpaceToView(_buyBtn, 10)
        .heightIs(18);
        
        
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
        _totalPriceLb.text = @"选择完地址后点击下单";
    }
    return _totalPriceLb;
}

@end
