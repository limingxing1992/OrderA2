//
//  MallManager.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/4.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "MallProcessor.h"
@class ProductModel;
@class DiscussModel;

@interface MallManager : BaseManager

@property(strong,nonatomic) MallProcessor *mallProcessor;

/*********************************************************************
 函数名称 : getProductClassifyListDictionary:
 函数描述 : 获取商品分类接口（ProType_List） 
 输入参数 : cid：应用ID
 返回值 : success（proClassifyArray 存放商品分类列表数据（数据为ProClassifyModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductClassifyListDictionary:(NSDictionary *)parameters
                                 success:(void (^)(NSArray *proClassifyArray))responseSuccess
                                 failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getProductListDictionary:
 函数描述 : 获取商品列表接口（Pro_List ）
 输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
 返回值 : success（productsArray 存放商品列表数据（数据为ProductModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductListDictionary:(NSDictionary *)parameters
                         success:(void (^)(NSArray *productsArray))responseSuccess
                         failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getRecommendProductListDictionary:
 函数描述 : 获取推荐商品列表接口（Pro_ListTj）
 输入参数 : area：地区, id：栏目ID, size：每页条数, page：页码
 返回值 : success（productsArray 存放商品列表数据（数据为ProductModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getRecommendProductListDictionary:(NSDictionary *)parameters
                                  success:(void (^)(NSArray *productsArray))responseSuccess
                                  failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getProductDetailUrlWithID:
 函数描述 : 商品详情（网页版）url
 输入参数 : id：商品ID
 返回值 : productDetailUrl
 作者   : 张永亮
 *********************************************************************/
- (NSURL *)getProductDetailUrlWithID:(NSNumber *)ID;

/*********************************************************************
 函数名称 : getProductDetailDictionary:
 函数描述 : 获取商品详情接口（Pro_Json）
 输入参数 : id：商品ID
 返回值 : success（ProductModel），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductDetailDictionary:(NSDictionary *)parameters
                           success:(void (^)(ProductModel *productModel))responseSuccess
                           failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getProductDiscussListWithDictionary:
 函数描述 : 获取商品评论列表接口（ProDis_List）
 输入参数 : id：商品ID， page：页码， size：每页条数
 返回值 : success（discussArray 存放评论列表数据（数据为DiscussModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getProductDiscussListWithDictionary:(NSDictionary *)parameters
                                    success:(void (^)(NSArray *discussArray))responseSuccess
                                    failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getMyProductDiscussListWithDictionary:
 函数描述 : 获取我的商品评论列表接口（ProDis_Local）
 输入参数 : cid：应用ID， uid：用户ID， page：页码， size：每页条数
 返回值 : success（discussArray 存放评论列表数据（数据为DiscussModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getMyProductDiscussListWithDictionary:(NSDictionary *)parameters
                                      success:(void (^)(NSArray *discussArray))responseSuccess
                                      failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : addProductDiscussWithDictionary:
 函数描述 : 发布商品评论接口（ProDis_Add）
 输入参数 : cid：应用ID， id：商品ID， uid：用户ID， obj.proid：商品ID， obj.content：评论内容
 返回值 :  success：1，responseFailure：0
 作者   : 张永亮
 *********************************************************************/
- (void)addProductDiscussWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(id object))responseSuccess
                                failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : delProductDiscussWithDictionary:
 函数描述 : 删除商品评论接口（ProDis_Del）
 输入参数 : id：商品ID
 返回值 :  success：1，responseFailure：0
 作者   : 张永亮
 *********************************************************************/
- (void)delProductDiscussWithDictionary:(NSDictionary *)parameters
                                success:(void (^)(id object))responseSuccess
                                failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : getMyCartListWithDictionary:
 函数描述 : 获取我的购物车接口（Cart_List）
 输入参数 : cid：应用ID, uid：用户ID
 返回值 : success（cartsArray 存放购物车列表数据（数据为CartModel模型）），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getMyCartListWithDictionary:(NSDictionary *)parameters
                            success:(void (^)(NSArray *cartsArray))responseSuccess
                            failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : addCartWithDictionary:
 函数描述 : 加入购物车接口（Cart_add）
 输入参数 : obj.uid：用户ID， obj.cid：应用ID， obj.proid：商品ID， obj.num：商品数量， obj.isGroup：是否团购 1-是 0-否
 返回值 :  success：1，responseFailure：0
 作者   : 张永亮
 *********************************************************************/
- (void)addCartWithDictionary:(NSDictionary *)parameters
                      success:(void (^)(id object))responseSuccess
                      failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : modifyCartNumWithDictionary:
 函数描述 : 修改购物车中商品的数量接口（Cart_Num）
 输入参数 : id：购物车ID, num：商品数量
 返回值 :  success：1，responseFailure：0
 作者   : 张永亮
 *********************************************************************/
- (void)modifyCartNumWithDictionary:(NSDictionary *)parameters
                            success:(void (^)(id object))responseSuccess
                            failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;

/*********************************************************************
 函数名称 : delCartProductWithDictionary:
 函数描述 : 移除购物车中的商品接口（Cart_Del）
 输入参数 : id：购物车ID
 返回值 :  success：1，responseFailure：0
 作者   : 张永亮
 *********************************************************************/
- (void)delCartProductWithDictionary:(NSDictionary *)parameters
                             success:(void (^)(id object))responseSuccess
                             failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;


@end
