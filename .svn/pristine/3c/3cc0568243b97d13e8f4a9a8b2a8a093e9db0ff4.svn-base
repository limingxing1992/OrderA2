//
//  HomeViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/27.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "HomeViewController.h"
#import <SDAutoLayout.h>
#import "QRCodeViewController.h"

#define todayId @"129745"
#define hotId @"129682"
#define endId @"129681"

@interface HomeViewController ()
<
    SDCycleScrollViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UITableViewDelegate,
    UITableViewDataSource
>

/** 背景画布*/
@property (nonatomic, strong) UIScrollView *contentView;
/** 头部背景图*/
@property (nonatomic, strong) UIImageView *topBackIv;
/** 集合视图背景图*/
@property (nonatomic, strong) UIImageView *collectionBackIv;
/** 今日*/
@property (nonatomic, strong) UIImageView *todayBavkIv;
/** 热销*/
@property (nonatomic, strong) UIImageView *hotBackIv;
/** 特惠*/
@property (nonatomic, strong) UIImageView *endBackIv;

/** banner轮播*/
@property (nonatomic, strong) SDCycleScrollView *scorllView;
/** 入口集合视图*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 今日视图*/
@property (nonatomic, strong) UITableView *todayTableView;
/** 热销视图*/
@property (nonatomic, strong) UICollectionView *hotCollectionView;
/** 特惠视图*/
@property (nonatomic, strong) UITableView *endTableView;







/** 入口数据*/
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSArray *imgData;
/** 首页banner数据源*/
@property (nonatomic, strong) NSMutableArray *bannerData;
/** 今日关注数据*/
@property (nonatomic, strong) NSMutableArray *todayData;
/** 热门推荐数据*/
@property (nonatomic, strong) NSMutableArray *hotData;
/** 特惠抢购数据*/
@property (nonatomic, strong) NSMutableArray *endData;





@end

static NSString *const todayCell = @"todayId";

static NSString *const cellId = @"homeCell";

static NSString *const hotCell = @"hotId";

static NSString *const endCell = @"endId";



@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavi];
    [self.view addSubview:self.contentView];
    //顶部背景视图
    [self.contentView addSubview:self.topBackIv];
    [self.contentView addSubview:self.collectionBackIv];
    [self.contentView addSubview:self.todayBavkIv];
    [self.contentView addSubview:self.hotBackIv];
    [self.contentView addSubview:self.endBackIv];
    
    
    [SVProgressHUD show];
    [self initData];
    [self loadData];
    [self loadBannerData];
    [self loadTodayData];
    [self loadHotData];
    [self loadEndData];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
//    self.tabBarController.tabBar.hidden = NO;

}


#pragma mark ----------------界面
/** 设置导航栏*/
- (void)setNavi{

    self.navigationItem.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(menuAction)];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]]];
    
    UIBarButtonItem *righthScan = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"classify1") style:UIBarButtonItemStylePlain target:self action:@selector(entoScan)];
    righthScan.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = righthScan;
}

/** 进入扫描*/
- (void)entoScan{
    QRCodeViewController *qrVc = [[QRCodeViewController alloc] init];
    [self.navigationController pushViewController:qrVc animated:YES];
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    
    _topBackIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(190);
    
    _collectionBackIv.sd_layout
    .topSpaceToView(_topBackIv, 5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(235 );
    
    _todayBavkIv.sd_layout
    .topSpaceToView(_collectionBackIv, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(290 );
    
    _hotBackIv.sd_layout
    .topSpaceToView(_todayBavkIv, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(560);
    
    _endBackIv.sd_layout
    .topSpaceToView(_hotBackIv, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(280 );
    [self.contentView setupAutoContentSizeWithBottomView:_endBackIv bottomMargin:20];


}

#pragma mark ----------------数据
/** 初始化数据*/
- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _imgData = @[@"classify3", @"classify4",@"classify5",@"classify6",@"classify7",@"classify8",@"classify9",@"classify10"];
    _todayData = [[NSMutableArray alloc] init];
    _hotData = [[NSMutableArray alloc] init];
    _endData = [[NSMutableArray alloc] init];
}
/** 获取入口数据*/
- (void)loadData{
    WeakObj(self);
    /** os：端口型号 android-安卓 apple-苹果，cid：应用ID，result：每页显示数量，id：栏目ID*/
    [ShareBusinessManager.newsManager getOneChannelListWithDictionary:@{@"os":@"apple",
                                                                        @"cid":APPCID,
                                                                        } success:^(NSArray *channelsArray) {
                                                                            [SVProgressHUD dismiss];
                                                                            [weakself.data removeAllObjects];
                                                                            [weakself.data addObjectsFromArray:channelsArray];
                                                                            [weakself.collectionView reloadData];
                                                                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                            [SVProgressHUD showErrorWithStatus:@"加载失败"];
                                                                        }];
}
/** 获取banner数据*/
- (void)loadBannerData{
    //获取广告数据
    if (!_bannerData) {
        _bannerData = [[NSMutableArray alloc] init];
    }
    
    WeakObj(self);
    [ShareBusinessManager.advManager getAdvsWithDictionary:@{@"cid":APPCID,
                                                             @"size":PAGESIZE}
                                                   success:^(NSArray *advsArray) {
                                                       [_bannerData addObjectsFromArray:advsArray];
                                                       [weakself updateBanner];
                                                       
                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                       [SVProgressHUD showErrorWithStatus:@"加载失败"];
                                                   }];

}
/** 刷新banner*/
- (void)updateBanner{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    for (AdvModel *model in _bannerData) {
        [ary addObject:LOGOURL(model.logo)];
    }
    [_scorllView setImageURLStringsGroup:ary];

}
/** 获取今日数据*/
- (void)loadTodayData{
    WeakObj(self);
    
    [ShareBusinessManager.newsManager getNewsListWithDictionary:@{@"id":todayId}
                                                        success:^(NSArray *newsArray) {
                                                            [weakself.todayData addObjectsFromArray:newsArray];
                                                            [weakself.todayTableView reloadData];
                                                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                            [SVProgressHUD showErrorWithStatus:@"加载失败"];
                                                        }];

}
/** 获取热门数据*/
- (void)loadHotData{
    
    WeakObj(self);
    
    [ShareBusinessManager.mallManager getProductListDictionary:@{@"id":endId                                                                }
                                                       success:^(NSArray *productsArray) {
                                                           [weakself.hotData addObjectsFromArray:productsArray];
                                                           [weakself.hotCollectionView reloadData];
                                                           
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:@"加载失败"];
                                                           
                                                       }];



}
/** 获取特惠数据*/
- (void)loadEndData{
    WeakObj(self);
    //输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
    [ShareBusinessManager.mallManager getProductListDictionary:@{@"id":hotId                                                                }
                                                       success:^(NSArray *productsArray) {
                                                           [weakself.endData addObjectsFromArray:productsArray];
                                                           [weakself.endTableView reloadData];
                                                           
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:@"加载失败"];
                                                           
                                                       }];


}

#pragma mark ----------------业务
/** 抽屉动作*/
- (void)menuAction{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/** 栏目入口*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        ChannelModel *model = _data[indexPath.row];
        [self intoListVcByModel:model];
    }else{
        ProductModel *model = _hotData[indexPath.row];
        ProductDetailViewController *detailVc = [[ProductDetailViewController alloc] init];
        detailVc.model = model;
        detailVc.proId = model.proid;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}
/** 根据model模型内type属性和typeId字段判断进入什么类型界面*/
- (void)intoListVcByModel:(ChannelModel *)model{
    
    if ([model.type isEqualToString:@"news"]) {
        //列表页（无菜单）
        List_1ViewController *listVc = [[List_1ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];
        
        
    }else if ([model.type isEqualToString:@"menu"]){
        
        switch (model.typeId.integerValue) {
            case 0:
            {
                //列表页（有菜单）
                List_0ViewController *listVc = [[List_0ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            case 1:
            {
                //列表页（无菜单）
                MenuProductViewController *listVc = [[MenuProductViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            case 2:
            {
                //列表页（一排两个的collectionview）
                List_2ViewController *listVc = [[List_2ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            default:
                break;
        }
        
        
        
    }else if ([model.type isEqualToString:@"image"]){
        
        switch (model.typeId.integerValue) {
            case 0:
            {
                //列表页（无菜单）
                List_1ViewController *listVc = [[List_1ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            case 1:
            {
                //列表页(collectionview）
                List_2ViewController *listVc = [[List_2ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            case 2:
            {
                //列表页（无菜单）
                List_1ViewController *listVc = [[List_1ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];

            }
                break;
            case 1000:
            {
                //和0一致，详情页添加投票模块
                List_1ViewController *listVc = [[List_1ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];
            }
                break;
            default:
                break;
        }

        
        
    }else if ([model.type isEqualToString:@"company"]){
        
        switch (model.typeId.integerValue) {
            case 0:
            {
                //列表页（一行两张图collectiview）
                List_2ViewController *listVc = [[List_2ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];
                
            }
                break;
            case 1:
            {
                //列表页(无菜单）
                List_1ViewController *listVc = [[List_1ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];
                
            }
                break;
            case 2501:
            {
                //和1一致，详情页添加预订功能
                List_1ViewController *listVc = [[List_1ViewController alloc] init];
                listVc.model = model;
                [self.navigationController pushViewController:listVc animated:YES];
                
            }
                break;
            default:
                break;
        }

        
    }else if ([model.type isEqualToString:@"txt"]){
            //(超链接。直接进入H5页面。地址为)
//            NSLog(@"%@", model.content);
        DetailWebViewController *web = [[DetailWebViewController alloc] init];
        web.url = [NSURL URLWithString:model.content];
        [self.navigationController pushViewController:web animated:YES];
        
    }else if ([model.type isEqualToString:@"show"]){
        //列表页（无菜单）
        List_1ViewController *listVc = [[List_1ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];
        
    }else if ([model.type isEqualToString:@"needs"]){
        //列表页（无菜单）

        List_1ViewController *listVc = [[List_1ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];

    }else if ([model.type isEqualToString:@"blog"]){
        //列表页（无菜单）
        
        List_1ViewController *listVc = [[List_1ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];

        
    }else if ([model.type isEqualToString:@"product"]){
        //列表页（一行两张图collectiview）
        
        List_2ViewController *listVc = [[List_2ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];

    }else if ([model.type isEqualToString:@"group"]){
        //列表页（一行两张图collectiview）
        List_2ViewController *listVc = [[List_2ViewController alloc] init];
        listVc.model = model;
        [self.navigationController pushViewController:listVc animated:YES];

    }else{
        [SVProgressHUD showErrorWithStatus:@"找不到对应类型，无法进入列表页"];
    }

}
/** 商品入口*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _todayTableView) {
        NewsModel *model = _todayData[indexPath.row];
        DetailViewController *detailVc = [[DetailViewController alloc] init];
        detailVc.Id = model.iid;
        detailVc.type = @"news";
        detailVc.titleText = model.title;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        ProductModel *model = _endData[indexPath.row];
        ProductDetailViewController *detailVc = [[ProductDetailViewController alloc] init];
        detailVc.model = model;
        detailVc.proId = model.proid;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}
/** banner回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    AdvModel *model = _bannerData[index];
    DetailWebViewController *detailVc = [[DetailWebViewController alloc] init];
    detailVc.url = [ShareBusinessManager.advManager getAdvDetailUrlWithID:model.ID];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark ----------------collection代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _hotCollectionView) {
        if (_hotData.count >= 4 ) {
            return 4;
        }else{
            return _hotData.count;
        }
    }else{
        return _data.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _hotCollectionView) {
        ListCell_2CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotId forIndexPath:indexPath];
        cell.model = _hotData[indexPath.row];
        return cell;
    }
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
    cell.contentIv.image = IMAGE(_imgData[indexPath.row]);
    return cell;


}

#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _todayTableView) {
        if (_todayData.count >= 2) {
            return 2;
        }else{
            return _todayData.count;
        }
    }else if (tableView == _endTableView){
        if (_endData.count >=2 ) {
            return 2;
        }else{
            return _endData.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _todayTableView) {
        ListCell_7TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:todayId];
        cell.model = _todayData[indexPath.row];
        return cell;
    }
    
    if (tableView == _endTableView) {
        ListCell_8TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:endId];
        cell.model = _endData[indexPath.row];
        return cell;
    }
    
    return nil;

}


#pragma mark ----------------实例

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _contentView.backgroundColor = APPColor;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
    }
    return _contentView;
}

- (UIImageView *)topBackIv{
    if (!_topBackIv) {
        _topBackIv = [[UIImageView alloc] init];
        _topBackIv.image = [UIImage imageNamed:@"bg_banner"];
        _topBackIv.userInteractionEnabled = YES;
        [_topBackIv addSubview:self.scorllView];
    }
    return _topBackIv;
}

- (UIImageView *)collectionBackIv{
    if (!_collectionBackIv) {
        _collectionBackIv = [[UIImageView alloc] init];
        _collectionBackIv.image = IMAGE(@"classify34");
        _collectionBackIv.userInteractionEnabled = YES;
        [_collectionBackIv addSubview:self.collectionView];
        self.collectionView.sd_layout
        .topSpaceToView(_collectionBackIv, 0)
        .leftSpaceToView(_collectionBackIv, 5)
        .rightSpaceToView(_collectionBackIv, 5)
        .bottomSpaceToView(_collectionBackIv, 10);
    }
    return _collectionBackIv;

}

- (UIImageView *)todayBavkIv{
    if (!_todayBavkIv) {
        _todayBavkIv = [[UIImageView alloc] init];
        _todayBavkIv.image = IMAGE(@"classify35");
        _todayBavkIv.userInteractionEnabled = YES;
        [_todayBavkIv addSubview:self.todayTableView];
        
        
        _todayTableView.sd_layout
        .topSpaceToView(_todayBavkIv, 65)
        .leftSpaceToView(_todayBavkIv, 15)
        .rightSpaceToView(_todayBavkIv, 15)
        .bottomSpaceToView(_todayBavkIv, 35);
    }
    return _todayBavkIv;

}

- (UIImageView *)hotBackIv{
    if (!_hotBackIv) {
        _hotBackIv = [[UIImageView alloc] init];
        _hotBackIv.image = IMAGE(@"classify36");
        _hotBackIv.userInteractionEnabled = YES;
        [_hotBackIv addSubview:self.hotCollectionView];
        _hotCollectionView.sd_layout
        .topSpaceToView(_hotBackIv, 65)
        .leftSpaceToView(_hotBackIv, 12)
        .rightSpaceToView(_hotBackIv, 12)
        .bottomSpaceToView(_hotBackIv, 35);
    }
    return _hotBackIv;

}

- (UIImageView *)endBackIv{
    if (!_endBackIv) {
        _endBackIv = [[UIImageView alloc] init];
        _endBackIv.image = IMAGE(@"classify37");
        _endBackIv.userInteractionEnabled = YES;
        [_endBackIv addSubview:self.endTableView];
        _endTableView.sd_layout
        .topSpaceToView(_endBackIv, 55)
        .leftSpaceToView(_endBackIv, 15)
        .rightSpaceToView(_endBackIv, 15)
        .bottomSpaceToView(_endBackIv, 20);
    }
    return _endBackIv;

}

- (SDCycleScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 2, SCREEN_WIDTH - 20, 171) delegate:self placeholderImage:Placeholder_big];
        _scorllView.showPageControl = NO;
        [_scorllView setShowPageControl:YES];
        [_scorllView setCurrentPageDotColor:APPColor];
        _scorllView.delegate = self;
    }
    return _scorllView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH - 70) / 4;
        CGFloat height = 87;
        layout.sectionInset = UIEdgeInsetsMake(15, 10, 22.5, 10);
        layout.minimumLineSpacing = 5;
        layout.itemSize = CGSizeMake(width, height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView= [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WHITECOLOR;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;

}

- (UITableView *)todayTableView{
    if (!_todayTableView) {
        _todayTableView = [[UITableView alloc] init];
        _todayTableView.separatorColor = GRAYCOLOR;
        _todayTableView.separatorInset = UIEdgeInsetsZero;
        _todayTableView.delegate = self;
        _todayTableView.dataSource = self;
        _todayTableView.rowHeight = 90;
        [_todayTableView registerClass:[ListCell_7TableViewCell class] forCellReuseIdentifier:todayId];
    }
    return _todayTableView;
}

- (UICollectionView *)hotCollectionView{
    if (!_hotCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH - 75) / 2;
        CGFloat height = 217.5;
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        layout.minimumLineSpacing = 15;
        layout.itemSize = CGSizeMake(width, height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        [_hotCollectionView registerClass:[ListCell_2CollectionViewCell class] forCellWithReuseIdentifier:hotId];
        _hotCollectionView.showsHorizontalScrollIndicator = NO;
        _hotCollectionView.scrollEnabled = NO;
        _hotCollectionView.backgroundColor = WHITECOLOR;
    }
    return _hotCollectionView;


}

- (UITableView *)endTableView{
    if (!_endTableView) {
        _endTableView = [[UITableView alloc] init];
        _endTableView.separatorColor = GRAYCOLOR;
        _endTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _endTableView.delegate = self;
        _endTableView.dataSource = self;
        _endTableView.rowHeight = 100;
        [_endTableView registerClass:[ListCell_8TableViewCell class] forCellReuseIdentifier:endId];

    }
    return _endTableView;

}

@end
