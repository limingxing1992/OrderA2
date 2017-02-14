//
//  GroupProcessor.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/12.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProcessor.h"

@interface GroupProcessor : BaseProcessor

/*********************************************************************
 函数名称 : getGroupListWithDictionary:
 函数描述 : 团购商品列表接口
 输入参数 : id ：栏目id, area：地区, page：页码, size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getGroupListWithDictionary:(NSDictionary *)parameters
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getSearchGroupListWithDictionary:
 函数描述 : 团购商品查询接口
 输入参数 : id ：栏目id, str：搜索关键词, area：地区, page：页码, size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getSearchGroupListWithDictionary:(NSDictionary *)parameters
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getGroupProDetailWithDictionary:
 函数描述 : 团购商品详情接口
 输入参数 : id ：商品id
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getGroupProDetailWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

@end
