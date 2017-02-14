//
//  OrderProcessor.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/4.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProcessor.h"

@interface OrderProcessor : BaseProcessor

/*********************************************************************
 函数名称 : getPayConfigureWithDictionary:
 函数描述 : 获取支付配置信息接口
 输入参数 : cid：应用ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getPayConfigureWithDictionary:(NSDictionary *)parameters
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getMyOrderListWithDictionary:
 函数描述 : 获取我的订单列表接口
 输入参数 : uid ：用户ID, cid：应用ID, page：页码, size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getMyOrderListWithDictionary:(NSDictionary *)parameters
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getOrderDetailWithDictionary:
 函数描述 : 订单详情接口
 输入参数 : id ：订单ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getOrderDetailWithDictionary:(NSDictionary *)parameters
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : submitOrderWithDictionary:
 函数描述 : 提交订单接口
 输入参数 : obj.cid ：应用ID, obj.uid：用户ID, obj.addr：地址ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)submitOrderWithDictionary:(NSDictionary *)parameters
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : payOrderWithDictionary:
 函数描述 : 提交支付接口
 输入参数 : id ：订单ID, uid：用户ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)payOrderWithDictionary:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : completeOrderWithDictionary:
 函数描述 : 订单状态交易完成接口
 输入参数 : id ：订单ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)completeOrderWithDictionary:(NSDictionary *)parameters
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getOrderDeatilListWithDictionary:
 函数描述 : 获取订单下的商品列表接口
 输入参数 : order：订单号
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getOrderDeatilListWithDictionary:(NSDictionary *)parameters
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

@end
