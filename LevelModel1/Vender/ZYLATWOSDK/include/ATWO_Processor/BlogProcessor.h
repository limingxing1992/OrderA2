//
//  BlogProcessor.h
//  ZYLATWO
//
//  Created by 张永亮 on 2016/12/29.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProcessor.h"

@interface BlogProcessor : BaseProcessor

/*********************************************************************
 函数名称 : getBlogListWithDictionary:
 函数描述 : 获取blog求职招聘等列表接口
 输入参数 : id ：栏目id ,page：页码 ,size：每页条数
 返回值 : success（），responseFailure（errCode、errorMsg）
 作者   : 张永亮
 *********************************************************************/
- (void)getBlogListWithDictionary:(NSDictionary *)parameters
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

@end
