//
//  GroupProModel.h
//  ZYLATWO
//
//  Created by 张永亮 on 2017/1/12.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@interface GroupProModel : ProductModel

@property (nonatomic, copy) NSNumber *buyuser;     //购买人
@property (nonatomic, copy) NSNumber *gid;         //应用ID
@property (nonatomic, copy) NSNumber *minuser;     //最少要求人数
@property (nonatomic, copy) NSString *endtime;     //团购结束时间

@end
