//
//  MenuProductViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/7.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "MenuProductViewController.h"

@interface MenuProductViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

/** banner轮播*/
@property (nonatomic, strong) SDCycleScrollView *scorllView;

/** 首页banner数据源*/
@property (nonatomic, strong) NSMutableArray *bannerData;
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;

@end


static NSString *productId = @"productCellId";

@implementation MenuProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scorllView];
    [self.view addSubview:self.tableView];
    [self loadBannerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ----------------数据


/** 获取banner数据*/
- (void)loadBannerData{
    //获取广告数据
    if (!_bannerData) {
        _bannerData = [[NSMutableArray alloc] init];
    }
    
    WeakObj(self);
    [ShareBusinessManager.advManager getAdvsWithDictionary:@{@"id":_model.chid}
                                                   success:^(NSArray *advsArray) {
//                                                       if (advsArray.count) {
//                                                           AdvModel *model = advsArray.firstObject;
//                                                           NSLog(@"%@", LOGOURL(model.logo));
//                                                       }
                                                       
                                                       [weakself.bannerData addObjectsFromArray:advsArray];
                                                       [weakself updateBanner];
                                                       
                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                       
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


#pragma mark ----------------业务
/** 进入子栏目*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelModel *model = _model.twoChannelList[indexPath.row];
    ProductListViewController *list = [[ProductListViewController alloc] init];
    list.model = model;
    [self.navigationController pushViewController:list animated:YES];
    
}
/** banner回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    AdvModel *model = _bannerData[index];
    DetailWebViewController *detailVc = [[DetailWebViewController alloc] init];
    detailVc.url = [ShareBusinessManager.advManager getAdvDetailUrlWithID:model.ID];
    [self.navigationController pushViewController:detailVc animated:YES];
}



#pragma mark ----------------实例

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.twoChannelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelModel *model = _model.twoChannelList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView sd_setImageWithURL:LOGOURL(model.logo) placeholderImage:Placeholder_small];
    CGRect fame = cell.imageView.frame;
    fame.origin.x += 15;
    fame.origin.y += 10;
    fame.size.height -= 20;
    fame.size.width -= 20;
    cell.imageView.frame = fame;
    cell.textLabel.font = FONT(18);
    cell.textLabel.textColor = BLACKCOLOR;
    cell.textLabel.text = model.title;
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8-1")];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark ----------------实例


- (SDCycleScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 171) delegate:self placeholderImage:Placeholder_big];
        _scorllView.showPageControl = NO;
        [_scorllView setShowPageControl:YES];
        [_scorllView setCurrentPageDotColor:APPColor];
        _scorllView.delegate = self;
    }
    return _scorllView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 171, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 171)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:productId];
    }
    return _tableView;
}

@end
