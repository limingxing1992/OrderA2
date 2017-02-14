重要!

ATWO SDK 1.0

1. 支持兼容ipv6(提升稳定性)
2. iOS 9系统策略更新，集成了对https协议的访问

SDK 结构说明

ATWO_Manager（业务接口调用的相关头文件，业务逻辑的处理类 e.g. UserManager、CompanyManager...）
ATWOE_Model（业务相关的model，e.g. UserInfoModel、CompanyModel...）
ATWO_Processor（业务接口的网络实现类，e.g. UserProcessor、CompanyProcessor...）
ATWO_Z（业务实现和网络接口的基类文件以及工厂类）
ZYLATWOKit.h （快速引用了所有的业务逻辑实现类头文件）
ZYLATWOSDK.h （sdk配置类，e.g. + (void)setServerHost:(NSString *)host; //default is https://appserver.1035.mobi/）

SDK 使用说明

1. 将libZYLATWO.a及include导入到工程中
2. 在需要调用业务接口的控制器中添加#import "ZYLATWOKit.h"，也可以根据场景将ZYLATWOKit.h配置到pch文件中，然后即可快速调用相关业务接口
   e.g. 
//
//  ViewController.m
//  ATWO
//
//  Created by 张永亮 on 2016/12/27.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "ViewController.h"
#import "ZYLATWOKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [ZYLATWOSDK setServerHost:@"https://appserver.1035.mobi"];  //设置项目的服务器接口访问域名，如果设置为nil，则默认为https://appserver.1035.mobi

    //调用登陆接口案例
    [ATWOShareBusinessManager.userManager userLoginWithDictionary:@{@"obj.cid":[NSNumber numberWithInteger:2889],
                                                                    @"username":@"18212345678",
                                                                    @"password":@"123456"
                                                                    }
                                                          success:^(id object){                                          
                                                              NSLog(@"login:%@",object);
                                                          }
                                                          failure:^(NSInteger errCode,NSString *errorMsg){
                                                              NSLog(@"errCode:%ld,errorMsg:%@",(long)errCode,errorMsg);
                                                          }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

3.对应的接口调用以及服务器返回数据结构说明可查看相关业务逻辑实现类 e.g. SearchManager.h...
/*********************************************************************
 函数名称 : getSearchAppKeyListWithDictionary:
 函数描述 : 搜索应用下的热词关键字接口（SchKey_Cid）
 输入参数 : id ：栏目id ,page：页码 ,size：每页条数
 返回值 : success（keysArray 存放关键字列表数据（数据为KeyModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getSearchAppKeyListWithDictionary:(NSDictionary *)parameters
                                  success:(void (^)(NSArray *keysArray))responseSuccess
                                  failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getSearchListFromCidKeyWithDictionary:
 函数描述 : 根据应用下的热词关键字搜索结果集接口（SearchAll_Search，Blog_Sch）
 输入参数 : cid ：应用id ,str：关键字 ,size：每页条数
 返回值 : success（searchesArray 存放搜索列表数据（数据为SearchModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getSearchListFromCidKeyWithDictionary:(NSDictionary *)parameters
                                      success:(void (^)(NSArray *searchesArray))responseSuccess
                                      failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getSearchNewsListForKeyWithDictionary:
 函数描述 : 根据关键字搜索资讯接口（News_Sch）
 输入参数 : id ：子栏目的id ,str：关键字 ,size：每页条数 ,page：页数
 返回值 : success（newsArray 存放搜索列表数据（数据为NewsModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getSearchNewsListForKeyWithDictionary:(NSDictionary *)parameters
                                      success:(void (^)(NSArray *newsArray))responseSuccess
                                      failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;
4. 针对不同项目可能临时使用其他没有封装的业务接口情况，在OpenManager.h中开放了网络接口调用，无需自己实现
/*********************************************************************
 函数名称 : openHTTPRequestWithUrlString:parameters:responseSerializer:success:failure
 函数描述 : 自定义网络请求
 输入参数 : urlString:http://appserver.1035.mobi/MobiSoft/Channel_List?
          parameters:@{@"cid":@"xxx"}
          serializer:HTTPResponseSerializer/JSONResponseSerializer(ZYLAONETypedef.h)
 返回值 : success:id object     failure:errCode,errorMsg
 作者   : 张永亮
 *********************************************************************/
- (void)openHTTPRequestWithUrlString:(NSString *)urlString
                  responseSerializer:(NSInteger)serializer
                          parameters:(NSDictionary *)parameters
                             success:(void (^)(id object))responseSuccess
                             failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;



