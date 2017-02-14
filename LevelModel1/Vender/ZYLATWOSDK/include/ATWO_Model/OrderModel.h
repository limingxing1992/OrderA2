//
//  OrderModel.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/4.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *addr;        //地址ID
@property (nonatomic, copy) NSNumber *cid;         //应用ID
@property (nonatomic, copy) NSNumber *ID;          //订单ID
@property (nonatomic, copy) NSString *isDel;       //是否删除
@property (nonatomic, copy) NSString *logo;        //图片
@property (nonatomic, copy) NSNumber *num;         //商品数量
@property (nonatomic, copy) NSString *ordermemo;
@property (nonatomic, copy) NSString *ordernum;    //订单号
@property (nonatomic, copy) NSString *payInfo;     //支付编号[接口返回的支付参数]
@property (nonatomic, copy) NSString *payStatus;   //支付状态
@property (nonatomic, copy) NSString *payTime;     //支付时间
@property (nonatomic, copy) NSString *payType;     //支付方式
@property (nonatomic, copy) NSNumber *price;       //商品价格
@property (nonatomic, copy) NSString *regtime;     //下单时间
@property (nonatomic, copy) NSNumber *sendPrice;   //运费
@property (nonatomic, copy) NSString *sendStatus;  //发送状态，0未发货，1已发货，2交易完成，11已退回
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *uid;         //用户ID
@property (nonatomic, copy) NSNumber *usescore;    //使用积分数

@end

@interface OrderProductModel : NSObject

@property (nonatomic, copy) NSNumber *ID;          //ID
@property (nonatomic, copy) NSNumber *isGroup;     //是否团购 1-是 0- 否
@property (nonatomic, copy) NSString *isused;      //是否已使用
@property (nonatomic, copy) NSString *logo;        //图片
@property (nonatomic, copy) NSNumber *num;         //商品数量
@property (nonatomic, copy) NSString *ordernum;    //订单号
@property (nonatomic, copy) NSNumber *price;       //商品价格
@property (nonatomic, copy) NSNumber *proid;       //商品ID
@property (nonatomic, copy) NSString *regtime;     //下单时间
@property (nonatomic, copy) NSString *title;       //商品名
@property (nonatomic, copy) NSString *usepass;     //使用码

@end
