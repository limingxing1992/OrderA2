//
//  GroupManager.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/12.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
@class GroupProcessor;
@class GroupProModel;

@interface GroupManager : BaseManager

@property(nonatomic,strong) GroupProcessor *groupProcessor;

/*********************************************************************
 函数名称 : getGroupListWithDictionary:
 函数描述 : 团购商品列表接口（Group_List）
 输入参数 : cid ：栏目id, area：地区, page：页码, size：每页条数
 返回值 : success（groupProsArray 存放团购列表数据（数据为GroupProModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getGroupListWithDictionary:(NSDictionary *)parameters
                           success:(void (^)(NSArray *groupProsArray))responseSuccess
                           failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getSearchGroupListWithDictionary:
 函数描述 : 团购商品查询接口（Group_Search）
 输入参数 : id ：栏目id, str：搜索关键词, area：地区, page：页码, size：每页条数
 返回值 : success（groupProsArray 存放团购列表数据（数据为GroupProModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getSearchGroupListWithDictionary:(NSDictionary *)parameters
                                 success:(void (^)(NSArray *groupProsArray))responseSuccess
                                 failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getGroupProDetailWithDictionary:
 函数描述 : 团购商品详情接口（Group_Json）
 输入参数 : id ：商品id
 返回值 : success（GroupProModel），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getGroupProDetailWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(GroupProModel *groupProModel))responseSuccess
                                failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getGroupProPageUrlWithID:
 函数描述 : 获取团购商品详情（网页版）url
 输入参数 : id ：商品id, obj.cid：应用ID
 返回值 : groupPageUrl
 作者   : 张永亮
 *********************************************************************/
- (NSURL *)getGroupProPageUrlWithID:(NSNumber *)ID withCid:(NSNumber *)cid;

@end
