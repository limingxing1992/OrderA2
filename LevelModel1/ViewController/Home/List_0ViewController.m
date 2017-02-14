//
//  List_0ViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "List_0ViewController.h"


@interface List_0ViewController ()<SegementControlDelegate, UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,UISearchBarDelegate>
/** 头部菜单栏*/
@property (nonatomic, strong) SegementControl *segement;
/** 当前选择加载列表id*/
@property (nonatomic, copy) NSNumber *currentId;
/** 当前选择加载列表type*/
@property (nonatomic, copy) NSString *currentType;
/** 当前选择加载列表typeid*/
@property (nonatomic, copy) NSString *currentTypeId;
/** 当前model*/
@property (nonatomic, strong) ChannelModel *currentModel;
/** 根据type和TypeId组合确定选用什么cell*/
@property (nonatomic, assign) NSInteger typeTag;


/** 当前页*/
@property (nonatomic, assign) NSInteger page;
/** 数据*/
@property (nonatomic, strong) NSMutableArray *data;
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;


/** 发布按钮==供求关系*/
@property (nonatomic, strong) UIButton *sendBtn;

/** 搜索框 needs模式出现*/
@property (nonatomic, strong) UISearchBar *searchBar;

/** banner轮播*/
@property (nonatomic, strong) SDCycleScrollView *scorllView;

/** 首页banner数据源*/
@property (nonatomic, strong) NSMutableArray *bannerData;

@end

static NSString *const cellId_0 = @"cellId_0";
static NSString *const cellId_1 = @"cellId_1";
static NSString *const cellId_2 = @"cellId_2";
static NSString *const cellId_3 = @"cellId_3";
static NSString *const cellId_4 = @"cellId_4";
static NSString *const cellId_5 = @"cellId_5";
static NSString *const cellId_6 = @"cellId_6";
static NSString *const cellId_7 = @"cellId_7";



@implementation List_0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = _model.title;
    
    [self.view addSubview:self.segement];
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
    [self loadBannerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setNavi{
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
    self.navigationItem.rightBarButtonItem = itme;
}

#pragma mark ----------------切换菜单栏

- (void)selectCurrentIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex{
    ChannelModel *model = _model.twoChannelList[index];
    _currentModel = model;
    _currentId = model.chid;
    _currentType = model.type;
    _currentTypeId = model.typeId;
    _typeTag = [self comnByType:_currentType typeId:_currentTypeId];
    //因为业务请求错误判断原因。点击切换自行清空数据
    [_data removeAllObjects];
    [self loadDataWithRet:YES];
    [self loadBannerData];
    
    if ([_currentModel.type isEqualToString:@"needs"]) {
        if ([_currentTypeId isEqualToString:@"2"]) {
            [self setNavi];
        }
    }
}

/** 发布动作*/
- (void)sendAction{
    SendNeedsViewController *send = [[SendNeedsViewController alloc] init];
    send.chid = _currentId;
    send.type = _currentTypeId;
    [self.navigationController pushViewController:send animated:YES];
}

#pragma mark ----------------数据处理

- (void)initData{
    ChannelModel *model = _model.twoChannelList.firstObject;
    _currentId = model.chid;
    _currentType = model.type;
    _currentTypeId = model.typeId;
    _currentModel = model;
    _data = [[NSMutableArray alloc] init];
    _typeTag = [self comnByType:_currentType typeId:_currentTypeId];
    _bannerData = [[NSMutableArray alloc] init];
}

/** 获取banner数据*/
- (void)loadBannerData{
    //获取广告数据
    
    WeakObj(self);
    [ShareBusinessManager.advManager getAdvsWithDictionary:@{@"id":_currentId}
                                                   success:^(NSArray *advsArray) {
                                                       
                                                       
                                                       [weakself.bannerData removeAllObjects];
                                                       [weakself.bannerData addObjectsFromArray:advsArray];
                                                       [weakself updateBanner];
                                                       
                                                       
                                                       
                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                       [weakself.bannerData removeAllObjects];
                                                       [weakself updateBanner];
                                                   }];
    
    

}
///** 刷新banner*/
- (void)updateBanner{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    for (AdvModel *model in _bannerData) {
        [ary addObject:LOGOURL(model.logo)];
    }
    [_scorllView setImageURLStringsGroup:ary];
    [self.tableView reloadData];
}


//专业组合方法。传入type 和id，返回cell类型
- (NSInteger)comnByType:(NSString *)type typeId:(NSString *)typeId{
    

    if ([type isEqualToString:@"news"]) {
        return ListType0;
    }else if ([type isEqualToString:@"image"]){
        
        switch (typeId.integerValue) {
            case 0:
            {
                return ListType1;
            }
                break;
            case 1:
            {
                return ListType11;
            }
                break;
            case 2:
            {
                return ListType2;
            }
                break;
            case 1000:
            {
                return ListType1;
            }
                break;
            default:
                break;
        }
        
        
        
    }else if ([type isEqualToString:@"company"]){
        
        switch (typeId.integerValue) {
            case 0:
            {

            }
                break;
            case 1:
            {
                return ListType3;
            }
                break;
            case 2501:
            {
                
            }
                break;
            default:
                break;
        }
        
        
    }else if ([type isEqualToString:@"txt"]){
        //(超链接。直接进入H5页面。地址为)
        
    }else if ([type isEqualToString:@"show"]){
        return ListType4;
    }else if ([type isEqualToString:@"needs"]){
        //列表页（无菜单）
        return ListType5;
        
    }else if ([type isEqualToString:@"blog"]){
        return ListType6;
        
    }else if ([type isEqualToString:@"product"]){
        
    }else if ([type isEqualToString:@"group"]){
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"找不到对应类型，无法进入列表页"];
    }
    return 0;
}

/** 加载数据*/
- (void)loadDataWithRet:(BOOL)ret{
    
    if (ret) {
        _page = 1;
    }else{
        _page += 1;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    /**  输入参数 : id ：栏目id ,page：页码 ,size：每页条数*/
    [dict setValue:PAGESIZE forKey:@"size"];
    [dict setValue:[NSNumber numberWithInteger:_page] forKey:@"page"];
    [dict setValue:_currentId forKey:@"id"];
    switch (_typeTag) {
        case ListType0:
        {
            [self getNewsListByParameters:dict ret:ret];
        }
            break;
        case ListType1:
        {
            [self getNewsListByParameters:dict ret:ret];
        }
            break;
        case ListType2:
        {
            [self getNewsListByParameters:dict ret:ret];
        }
            break;
        case ListType3:
        {
            [self getCompanyListByParameters:dict ret:ret];
        }
            break;
        case ListType4:
        {
            [self getShowsListByParameters:dict ret:ret];
        }
            break;
        case ListType5:
        {
            [dict setValue:_currentModel.typeId forKey:@"type"];
            [self getNeedsListByParameters:dict ret:ret];
        }
            break;
        case ListType6:
        {
            [self getBlogsListByParameters:dict ret:ret];
        }
            break;
        case ListType11:
        {
            [self getNewsListByParameters:dict ret:ret];
        }
            break;
        default:
            break;
    }

}

/** 请求news--images类型*/
- (void)getNewsListByParameters:(NSDictionary *)parameters ret:(BOOL)ret{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakObj(self);
    [ShareBusinessManager.newsManager getNewsListWithDictionary:parameters
                                                        success:^(NSArray *newsArray) {
                                                            [weakself successWith:newsArray ret:ret];
                                                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                            [SVProgressHUD showErrorWithStatus:errorMsg];
                                                            if (ret) {
                                                                [weakself.tableView.mj_header endRefreshing];
                                                            }else{
                                                                [weakself.tableView.mj_footer endRefreshing];
                                                            }
                                                            [weakself.tableView reloadData];
                                                        }];
}

/** 请求shows类型*/
- (void)getShowsListByParameters:(NSDictionary *)parameters ret:(BOOL)ret{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakObj(self);

    [ShareBusinessManager.showManager getShowListWithDictionary:parameters
                                                        success:^(NSArray *showArray) {
                                                            [weakself successWith:showArray ret:ret];
                                                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                            [SVProgressHUD showErrorWithStatus:errorMsg];
                                                            if (ret) {
                                                                [weakself.tableView.mj_header endRefreshing];
                                                            }else{
                                                                [weakself.tableView.mj_footer endRefreshing];
                                                            }
                                                            [weakself.tableView reloadData];

                                                        }];
}

/** 请求company类型*/
- (void)getCompanyListByParameters:(NSDictionary *)parameters ret:(BOOL)ret{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakObj(self);
    [ShareBusinessManager.companyManager getCompanyListWithDictionary:parameters
                                                              success:^(NSArray *companyArray) {
                                                                  [weakself successWith:companyArray ret:ret];
                                                              } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                  if (ret) {
                                                                      [weakself.tableView.mj_header endRefreshing];
                                                                  }else{
                                                                      [weakself.tableView.mj_footer endRefreshing];
                                                                  }
                                                                  [weakself.tableView reloadData];

                                                              }];;
    
}

/** 请求needs类型*/
- (void)getNeedsListByParameters:(NSDictionary *)parameters ret:(BOOL)ret{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakObj(self);
    [ShareBusinessManager.needsManager getNeedsListWithDictionary:parameters
                                                          success:^(NSArray *needsArray) {
                                                              [weakself successWith:needsArray ret:ret];

                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              if (ret) {
                                                                  [weakself.tableView.mj_header endRefreshing];
                                                              }else{
                                                                  [weakself.tableView.mj_footer endRefreshing];
                                                              }
                                                              [weakself.tableView reloadData];

                                                          }];
}

/** 请求blog类型*/
- (void)getBlogsListByParameters:(NSDictionary *)parameters ret:(BOOL)ret{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakObj(self);
    [ShareBusinessManager.blogManager getBlogListWithDictionary:parameters
                                                        success:^(NSArray *blogArray) {
                                                            [weakself successWith:blogArray ret:ret];
                                                        } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                            [SVProgressHUD showErrorWithStatus:errorMsg];
                                                            if (ret) {
                                                                [weakself.tableView.mj_header endRefreshing];
                                                            }else{
                                                                [weakself.tableView.mj_footer endRefreshing];
                                                            }
                                                            [weakself.tableView reloadData];

                                                        }];
}

/** 成功操作*/
- (void)successWith:(NSArray *)ary ret:(BOOL)ret{
    [SVProgressHUD dismiss];
    if (ret) {
        [self.data removeAllObjects];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer setState:MJRefreshStateIdle];
    }else{
        if (ary.count < PAGESIZE.integerValue ) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }
    [self.data addObjectsFromArray:ary];
    [self.tableView reloadData];
}


#pragma mark ----------------详情页入口

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *infoId;
    NSString *title;
    if ([_currentType isEqualToString:@"news"]) {
        NewsModel *model = _data[indexPath.row];
        infoId = model.iid;
        title = model.title;
    }else if ([_currentType isEqualToString:@"image"]){
        
        if (_typeTag == ListType11) {
            return;
        }
        
        NewsModel *model = _data[indexPath.row];
        infoId = model.iid;
        title = model.title;
    }else if ([_currentType isEqualToString:@"company"]){
        CompanyModel *model = _data[indexPath.row];
        infoId = model.ID;
        title = model.title;
        CompanyDetailViewController *detailVc = [[CompanyDetailViewController alloc] init];
        detailVc.Id = infoId;
        detailVc.type = _currentType;
        detailVc.titleText = title;
        detailVc.model = model;
        [self.navigationController pushViewController:detailVc animated:YES];
        return;
    }else if ([_currentType isEqualToString:@"show"]){
        ShowModel *model = _data[indexPath.row];
        infoId = model.ID;
        title = model.title;
        ShowDetailViewController *detailVc = [[ShowDetailViewController alloc] init];
        detailVc.Id = infoId;
        detailVc.type = _currentType;
        detailVc.titleText = title;
        detailVc.model = model;
        [self.navigationController pushViewController:detailVc animated:YES];
        return;
    }else if ([_currentType isEqualToString:@"needs"]){
        NeedsModel *model = _data[indexPath.row];
        infoId = model.ID;
        title = model.title;
    }else if ([_currentType isEqualToString:@"blog"]){
        BlogModel *model = _data[indexPath.row];
        infoId = model.bid;
        title = model.title;
        BlogDetailViewController *detailVc = [[BlogDetailViewController alloc] init];
        detailVc.Id = infoId;
        detailVc.type = _currentType;
        detailVc.titleText = title;
        detailVc.model = model;
        [self.navigationController pushViewController:detailVc animated:YES];
        return;

    }else if ([_currentType isEqualToString:@"product"]){
        
    }else if ([_currentType isEqualToString:@"group"]){
        
    }else if ([_currentType isEqualToString:@"menu"]){
        
    }
    
    
    
    
    if (infoId) {
        DetailViewController *detailVc = [[DetailViewController alloc] init];
        detailVc.Id = infoId;
        detailVc.type = _currentType;
        detailVc.titleText = title;
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

#pragma mark ----------------search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (!searchBar.text.length) {
        [SVProgressHUD showErrorWithStatus:@"输入搜索关键字"];
        return;
    }
    [searchBar resignFirstResponder];
    SearchResultListViewController *searchResultVc = [[SearchResultListViewController alloc] init];
    searchResultVc.keyWord = searchBar.text;
    searchResultVc.type = @"needs";
    searchResultVc.Id = _currentModel.chid;
    [self.navigationController pushViewController:searchResultVc animated:YES];
}




#pragma mark ----------------tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_typeTag == ListType11) {
        NSInteger coun = _data.count/2;
        if (_data.count % 2) {
            coun ++;
        }
        return coun;
    }
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_typeTag == ListType4) {
        
        if (indexPath.row == 0) {
            return 345;
        }
        return 110;
    }
    
    if (_typeTag == ListType11) {
        return 203;
    }

    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (![_currentModel.type isEqualToString:@"needs"]) {
        if (_bannerData.count != 0) {
            return 170;
        }else{
            return 0.001;
        }
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (![_currentModel.type isEqualToString:@"needs"]) {
        return self.scorllView;
    }else{
        return self.searchBar;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (_typeTag) {
        case ListType0:
        {
            ListCell_6TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_6];
            cell.newsModel = _data[indexPath.row];
            return cell;
        }
            break;
        case ListType1:
        {
            ListCell_1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_1];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType2:
        {
            ListCell_2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_2];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType3:
        {
            ListCell_3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_3];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType4:
        {
            
            if (indexPath.row == 0) {
                ShowSepecialTableViewCell *cell = [[ShowSepecialTableViewCell alloc] init];
                cell.model = _data[indexPath.row];

                return cell;
            }
            
            ListCell_4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_4];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType5:
        {
            ListCell_5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_5];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType6:
        {
            ListCell_6TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_6];
            cell.model = _data[indexPath.row];
            return cell;

        }
            break;
        case ListType11:
        {
            ListCell_9TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId_7];
            WeakObj(self);
            cell.block = ^(id object){
                NewsModel *model = object;
                DetailViewController *detailVc = [[DetailViewController alloc] init];
                detailVc.Id = model.iid;
                detailVc.type = weakself.currentType;
                detailVc.titleText = model.title;
                [self.navigationController pushViewController:detailVc animated:YES];
            };
            
            
            cell.model_1 = _data[indexPath.row * 2];
            if (indexPath.row *2 < _data.count - 1) {
                cell.model_2 = _data[indexPath.row*2 + 1];
            }else{
                cell.model_2 = nil;
            }
            
            return cell;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }

}


#pragma mark ----------------实例化

- (SDCycleScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 170) delegate:self placeholderImage:Placeholder_big];
        _scorllView.showPageControl = NO;
        [_scorllView setShowPageControl:YES];
        [_scorllView setCurrentPageDotColor:APPColor];
        _scorllView.delegate = self;
    }
    return _scorllView;
}

- (SegementControl *)segement{
    if (!_segement) {
        NSMutableArray *ary = [[NSMutableArray alloc] init];
        for (ChannelModel *model in _model.twoChannelList) {
            [ary addObject:model.title];
        }
        _segement = [[SegementControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) titles:ary];
        _segement.delegate = self;
    }
    return _segement;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 40) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        [_tableView registerClass:[ListCell_0TableViewCell class] forCellReuseIdentifier:cellId_0];
        [_tableView registerClass:[ListCell_1TableViewCell class] forCellReuseIdentifier:cellId_1];
        [_tableView registerClass:[ListCell_2TableViewCell class] forCellReuseIdentifier:cellId_2];
        [_tableView registerClass:[ListCell_3TableViewCell class] forCellReuseIdentifier:cellId_3];
        [_tableView registerClass:[ListCell_4TableViewCell class] forCellReuseIdentifier:cellId_4];
        [_tableView registerClass:[ListCell_5TableViewCell class] forCellReuseIdentifier:cellId_5];
        [_tableView registerClass:[ListCell_6TableViewCell class] forCellReuseIdentifier:cellId_6];
        [_tableView registerClass:[ListCell_9TableViewCell class] forCellReuseIdentifier:cellId_7];
        WeakObj(self);
        //下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        _tableView.mj_footer.automaticallyHidden = YES;
    }
    return _tableView;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _sendBtn.titleLabel.font = FONT(15);
        [_sendBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_sendBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
//        _searchBar.frame = CGRectMake(0, 40, SCREEN_WIDTH, 45);
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
