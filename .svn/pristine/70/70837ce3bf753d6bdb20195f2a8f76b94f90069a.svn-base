//
//  ProductListViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/9.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()<
SegementControlDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UISearchBarDelegate
>

/** 头部菜单栏*/
@property (nonatomic, strong) SegementControl *segement;

/** 当前菜单栏数据*/
@property (nonatomic, strong) NSMutableArray *menuData;

/** 商品列表*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 数据*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger page;

/** 当前栏目id*/
@property (nonatomic, strong) NSNumber *currentID;

/** 搜索框*/
@property (nonatomic, strong) UISearchBar *searchBar;


@end

static NSString *const productCellId = @"productCellListID";

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMenuData];
    self.isAutoBack = NO;
    self.name = _model.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------数据

- (void)initData{
    _menuData = [[NSMutableArray alloc] init];
    _data = [[NSMutableArray alloc] init];
}
/** 请求菜单栏数据*/
- (void)loadMenuData{
    /*********************************************************************
     函数名称 : getOneChannelListWithDictionary:
     函数描述 : 获取一级栏目及一级栏目下二级栏目列表接口（Channel_List）
     输入参数 : os：端口型号 android-安卓 apple-苹果，cid：应用ID，result：每页显示数量，id：栏目ID
     返回值 : success（channelsArray 存放栏目列表数据（数据为ChannelModel模型）），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    [SVProgressHUD show];
    WeakObj(self);
    [ShareBusinessManager.newsManager getOneChannelListWithDictionary:@{@"os":@"apple",
                                                                        @"id":_model.chid}
                                                              success:^(NSArray *channelsArray) {
                                                                  [_menuData addObjectsFromArray:channelsArray];
                                                                  [SVProgressHUD dismiss];
                                                                  [weakself creatMenu];
                                                              } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];

}
/** 请求商品数据*/
- (void)loadDataWithRet:(BOOL)ret{
    
    if (ret) {
        _page = 1;
    }else{
        _page += 1;
    }
    
    /*********************************************************************
     函数名称 : getProductListDictionary:
     函数描述 : 获取商品列表接口（Pro_List ）
     输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
     返回值 : success（productsArray 存放商品列表数据（数据为ProductModel模型）），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    /**  输入参数 : id ：栏目id ,page：页码 ,size：每页条数*/
    [dict setValue:PAGESIZE forKey:@"size"];
    [dict setValue:[NSNumber numberWithInteger:_page] forKey:@"page"];
    [dict setValue:_currentID forKey:@"id"];
    WeakObj(self);
    [SVProgressHUD show];
    [ShareBusinessManager.mallManager getProductListDictionary:dict
                                                       success:^(NSArray *productsArray) {                                                           
                                                           [SVProgressHUD dismiss];
                                                           if (ret) {
                                                               [self.data removeAllObjects];
                                                               [self.collectionView.mj_header endRefreshing];
                                                               [self.collectionView.mj_footer setState:MJRefreshStateIdle];
                                                           }else{
                                                               if (productsArray.count < PAGESIZE.integerValue ) {
                                                                   [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                                                               }else{
                                                                   [self.collectionView.mj_footer endRefreshing];
                                                               }
                                                           }
                                                           [weakself.data addObjectsFromArray:productsArray];
                                                           [weakself.collectionView reloadData];

                                                       }
                                                       failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           if (ret) {
                                                               [weakself.collectionView.mj_header endRefreshing];
                                                           }else{
                                                               [weakself.collectionView.mj_footer endRefreshing];
                                                           }
                                                           [weakself.collectionView reloadData];                                                       }];
}

#pragma mark ----------------业务

- (void)selectCurrentIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex{
    ChannelModel *model = _menuData[index];
    _currentID = model.chid;
    [self loadDataWithRet:YES];
}
/** 创建菜单栏*/
- (void)creatMenu{
    ChannelModel *model = _menuData.firstObject;
    _currentID = model.chid;
    [self.view addSubview:self.segement];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.collectionView];
    [self loadDataWithRet:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (!searchBar.text.length) {
        [SVProgressHUD showErrorWithStatus:@"输入搜索关键字"];
        return;
    }
    [searchBar resignFirstResponder];
    SearchResultListViewController *searchResultVc = [[SearchResultListViewController alloc] init];
    searchResultVc.keyWord = searchBar.text;
    searchResultVc.type = @"product";
    searchResultVc.Id = _model.chid;
    [self.navigationController pushViewController:searchResultVc animated:YES];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = _data[indexPath.row];
    ProductDetailViewController *detailVc = [[ProductDetailViewController alloc] init];
    detailVc.model = model;
    detailVc.proId = model.proid;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark ----------------代理collectionview

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListCell_1CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productCellId forIndexPath:indexPath];
    cell.productModel = _data[indexPath.row];
    return cell;
}


#pragma mark ----------------实例

- (SegementControl *)segement{
    if (!_segement) {
        NSMutableArray *ary = [[NSMutableArray alloc] init];
        for (ChannelModel *model in _menuData) {
            [ary addObject:model.title];
        }
        _segement = [[SegementControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) titles:ary];
        _segement.delegate = self;
    }
    return _segement;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45) / 2, 150);
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 85) collectionViewLayout:layout];;
        _collectionView.backgroundColor = WHITECOLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ListCell_1CollectionViewCell class] forCellWithReuseIdentifier:productCellId];
        WeakObj(self);
        //下拉刷新
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        _collectionView.mj_footer.automaticallyHidden = YES;
        
    }
    return _collectionView;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.frame = CGRectMake(0, 40, SCREEN_WIDTH, 45);
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
