//
//  MapViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/20.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
<   BMKMapViewDelegate,
    BMKLocationServiceDelegate
                            >

@property (nonatomic, strong) BMKMapView *mapView;//基础地图
@property (nonatomic, strong) BMKLocationService *locService;//定位工具类

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"地图";
    [self.view addSubview:self.mapView];
    [self.locService startUserLocationService];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.navigationItem.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(menuAction)];
}

- (void)menuAction{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
}



#pragma mark ----------------locationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView updateLocationData:userLocation];
    [self.locService stopUserLocationService];//停止定
//    _longti = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
//    _lanti = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
//    _distance = @"50000";
//    [self loadinfo];
//    
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = userLocation.location.coordinate.latitude;
//    coordinate.longitude = userLocation.location.coordinate.longitude;
//    _mapView.showsUserLocation = NO;
//    if (_myanno) {
//        [_mapView removeAnnotation:_myanno];
//    }
    
    
//    _myanno = [[YSSCPointAnnotation alloc] init];
//    _myanno.coordinate = userLocation.location.coordinate;
//    _myanno.tag = MYSELFTAG;
//    [_mapView addAnnotation:_myanno];
//    [_mapView selectAnnotation:_myanno animated:NO];
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"location error == %@",error);
}

#pragma mark ----------------实例化


- (BMKMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.showsUserLocation = YES;
        _mapView.zoomLevel = 20;//地图比例尺等级。3-21.范围越小
        [_mapView setMapType:BMKMapTypeStandard];//设置地图类型
    }
    return _mapView;
    
}

- (BMKLocationService *)locService{
    if (_locService == nil) {
        _locService = [[BMKLocationService alloc] init];
        _locService.distanceFilter = 100;
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locService;
    
}

@end
