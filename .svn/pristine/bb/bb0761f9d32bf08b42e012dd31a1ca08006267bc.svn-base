//
//  LeftDrawMenuViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/6.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "LeftDrawMenuViewController.h"

@interface LeftDrawMenuViewController ()<
UITableViewDelegate,
    UITableViewDataSource
>


/** 背景图*/
@property (nonatomic, strong) UIImageView *backIv;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 姓名*/
@property (nonatomic, strong) UILabel *titleLb;
/** 菜单列表*/
@property (nonatomic, strong) UITableView *menuTable;

/** 图片*/
@property (nonatomic, strong) NSArray *data;

/** baoc*/
@property (nonatomic, strong) NSMutableArray *btnAry;

/** 记录点击位置*/
@property (nonatomic, assign) NSInteger index;

@end

@implementation LeftDrawMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _data = @[@{@"noraml":@"bt_home_normal",
                @"select":@"bt_home_select"},
              @{@"noraml":@"bt_search_noraml",
                @"select":@"bt_search_select"},
              @{@"noraml":@"bt_map_normal",
                @"select":@"bt_map_select"},
              @{@"noraml":@"bt_more_normal",
                @"select":@"bt_more_select"}];
    _btnAry = [[NSMutableArray alloc] init];
    [self.view addSubview:self.backIv];
    [self.backIv addSubview:self.headIv];
    [self.backIv addSubview:self.titleLb];
    [self.backIv addSubview:self.menuTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
    self.navigationController.navigationBar.hidden = YES;
    [self loadUserInfo];
}
/** 布局界面*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .centerXIs(self.view.frame.size.width /2)
    .topSpaceToView(_backIv, 55)
    .heightIs(55)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _titleLb.sd_layout
    .topSpaceToView(_headIv, 15)
    .centerXEqualToView(_headIv)
    .autoHeightRatio(0);
    [_titleLb setSingleLineAutoResizeWithMaxWidth:self.view.size.width];
    
    
    
    _menuTable.sd_layout
    .topSpaceToView(_headIv, 65)
    .centerXIs(self.view.frame.size.width /2)
    .widthIs(self.view.frame.size.width)
    .heightIs(_data.count *50);
    
}

#pragma mark ----------------切换菜单
/** 切换菜单*/
- (void)changeMenu:(UIButton *)button{
    UIButton *lastBtn = _btnAry[_index];
    [lastBtn setSelected:NO];
    _index = button.tag -100;
    button.selected = !button.isSelected;
    
    switch (_index) {
        case 0:
        {
            HomeViewController *homeVc = [[HomeViewController alloc] init];
            BaseNaviViewController *baseVc = [[BaseNaviViewController alloc] initWithRootViewController:homeVc];
            [self.mm_drawerController setCenterViewController:baseVc withCloseAnimation:YES completion:nil];
        }
            break;
        case 1:
        {
            SearchViewController *homeVc = [[SearchViewController alloc] init];
            BaseNaviViewController *baseVc = [[BaseNaviViewController alloc] initWithRootViewController:homeVc];
            [self.mm_drawerController setCenterViewController:baseVc withCloseAnimation:YES completion:nil];

        }
            break;
        case 2:
        {
            MapViewController *homeVc = [[MapViewController alloc] init];
            BaseNaviViewController *baseVc = [[BaseNaviViewController alloc] initWithRootViewController:homeVc];
            [self.mm_drawerController setCenterViewController:baseVc withCloseAnimation:YES completion:nil];

        }
            break;
        case 3:
        {
            SettingViewController *homeVc = [[SettingViewController alloc] init];
            BaseNaviViewController *baseVc = [[BaseNaviViewController alloc] initWithRootViewController:homeVc];
            [self.mm_drawerController setCenterViewController:baseVc withCloseAnimation:YES completion:nil];

        }
            break;

        default:
            break;
    }

}
/** 进入个人中心*/
- (void)intoUserInfo{
    UIButton *lastBtn = _btnAry[_index];
    [lastBtn setSelected:NO];
    if (!IsLogin) {
        LoginViewController *loginVc = [[LoginViewController alloc] init];
        BaseNaviViewController *loginNavi = [[BaseNaviViewController alloc] initWithRootViewController:loginVc];
        [self.mm_drawerController setCenterViewController:loginNavi withCloseAnimation:YES completion:nil];
    }else{
        UserViewController *userVc = [[UserViewController alloc] init];
        BaseNaviViewController *baseVc = [[BaseNaviViewController alloc] initWithRootViewController:userVc];
        [self.mm_drawerController setCenterViewController:baseVc withCloseAnimation:YES completion:nil];
    }
}
/** 每次进入此页面。请求个人信息*/
- (void)loadUserInfo{
    
    if (!IsLogin) {
        return;
    }
    
    WeakObj(self);
    [ShareBusinessManager.userManager getUserInfoWithDictionary:@{@"id":UserID} success:^(UserInfoModel *userInfoModel) {
        [SVProgressHUD dismiss];
        [weakself upUIWith:userInfoModel];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"个人信息获取错误"];
    }];
}

- (void)upUIWith:(UserInfoModel *)model{
    //更新用户头型
    WeakObj(self);
    [ShareBusinessManager.userManager showUserLogoWithDictionary:@{@"id":UserID}
                                                         success:^(id object) {
                                                             
                                                             NSData *data = [ShareBusinessManager.userManager getImageDataByEncodingString:object];
                                                             UIImage *img = [UIImage imageWithData:data];
                                                             [weakself.headIv setImage:img];
                                                             [UserDefault setObject:object forKey:@"userLogo"];
                                                             
                                                         } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:@"头像加载失败"];
                                                         }];
    //更新用户昵称
    _titleLb.text = model.realname;
    
}

#pragma mark ----------------代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (!cell.contentView.subviews.count) {
        
        UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 50)];
        [bnt setBackgroundImage:IMAGE(_data[indexPath.row][@"noraml"]) forState:UIControlStateNormal];
        [bnt setBackgroundImage:IMAGE(_data[indexPath.row][@"select"]) forState:UIControlStateSelected];
        [bnt addTarget:self action:@selector(changeMenu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:bnt];
        if (indexPath.row == 0) {
            bnt.selected = YES;
        }
        bnt.tag = indexPath.row + 100;
        [_btnAry addObject:bnt];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark ----------------实例

- (UIImageView *)backIv{
    if (!_backIv) {
        _backIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _backIv.image = IMAGE(@"bg_left_body");
        _backIv.userInteractionEnabled = YES;
    
    }
    return _backIv;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = IMAGE(@"userHeaderImageDefault");
        _headIv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(intoUserInfo)];
        [_headIv addGestureRecognizer:tap];
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = WHITECOLOR;
        _titleLb.text = @"登录/注册";
    }
    return _titleLb;
}

- (UITableView *)menuTable{
    if (!_menuTable) {
        _menuTable = [[UITableView alloc] init];
        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        _menuTable.rowHeight = 50;
        _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_menuTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menuCell"];
    }
    return _menuTable;
}

@end
