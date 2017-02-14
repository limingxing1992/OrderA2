//
//  MallProcessor.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/4.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProcessor.h"

@interface MallProcessor : BaseProcessor

/*********************************************************************
 函数名称 : getProductClassifyListDictionary:
 函数描述 : 获取商品分类接口
 输入参数 : cid：应用ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductClassifyListDictionary:(NSDictionary *)parameters
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getProductListDictionary:
 函数描述 : 获取商品列表接口
 输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductListDictionary:(NSDictionary *)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getRecommendProductListDictionary:
 函数描述 : 获取推荐商品列表接口
 输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getRecommendProductListDictionary:(NSDictionary *)parameters
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getProductDetailDictionary:
 函数描述 : 获取商品详情接口
 输入参数 : id：商品ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductDetailDictionary:(NSDictionary *)parameters
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getProductDiscussListWithDictionary:
 函数描述 : 获取商品评论列表接口
 输入参数 : id：商品ID， page：页码， size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductDiscussListWithDictionary:(NSDictionary *)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getMyProductDiscussListWithDictionary:
 函数描述 : 获取我的商品评论列表接口
 输入参数 : cid：应用ID， uid：用户ID， page：页码， size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getMyProductDiscussListWithDictionary:(NSDictionary *)parameters
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : addProductDiscussWithDictionary:
 函数描述 : 发布商品评论接口
 输入参数 : cid：应用ID， id：商品ID， uid：用户ID， obj.proid：商品ID， obj.content：评论内容
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)addProductDiscussWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : delProductDiscussWithDictionary:
 函数描述 : 删除商品评论接口
 输入参数 : id：商品ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)delProductDiscussWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : getMyCartListWithDictionary:
 函数描述 : 获取我的购物车接口
 输入参数 : cid：应用ID, uid：用户ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getMyCartListWithDictionary:(NSDictionary *)parameters
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : addCartWithDictionary:
 函数描述 : 加入购物车接口
 输入参数 : obj.uid：用户ID， obj.cid：应用ID， obj.proid：商品ID， obj.num：商品数量， obj.isGroup：是否团购 1-是 0-否
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)addCartWithDictionary:(NSDictionary *)parameters
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : modifyCartNumWithDictionary:
 函数描述 : 修改购物车中商品的数量接口
 输入参数 : id：购物车ID, num：商品数量
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)modifyCartNumWithDictionary:(NSDictionary *)parameters
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/*********************************************************************
 函数名称 : delCartProductWithDictionary:
 函数描述 : 移除购物车中的商品接口
 输入参数 : id：购物车ID
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)delCartProductWithDictionary:(NSDictionary *)parameters
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

@end
