//
//  CommenIdea.m
//  LevelModel1
//
//  Created by 李明星 on 2016/12/27.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "CommenIdea.h"

@implementation CommenIdea

+ (UINavigationController *)loginNavi{
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_header_small"] forBarMetrics:UIBarMetricsDefault];
    return navi;
}

+ (BOOL)isLogin{
    
    if ([UserDefault objectForKey:@"userId"]) {
        return YES;
    }
    return NO;
}

+ (NSURL *)imgUrl:(NSString *)str{
    NSString *fillStr = [NSString stringWithFormat:@"https://appserver.1035.mobi/MobiSoftManage/upload/%@",str];
    return [NSURL URLWithString:fillStr];
}


+ (NSString*)image2ByteStr:(UIImage*)image
{
    UIImage *newImg = [CommenIdea scaleToSize:CGSizeMake(300, 300) byImage:image];
    
    NSData *imageData = UIImagePNGRepresentation(newImg);
    Byte *imageByte = (Byte *)[imageData bytes];
    NSMutableString *imageStr = [[NSMutableString alloc] init];
    for(int i=0;i<[imageData length];i++)
        [imageStr appendFormat:@",%d",imageByte[i]];
    
    [imageStr deleteCharactersInRange:NSMakeRange(0, 1)];
    return imageStr;
}

+ (UIImage*)scaleToSize:(CGSize)size byImage:(UIImage *)img
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (void)alertWithTarget:(id)target Title:(NSString *)title message:(NSString *)message action_0:(NSString *)action_0 action_1:(NSString *)action_1 block_0:(NILBlock)block_0 block_1:(NILBlock)block_1{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0;
    if (action_0) {
        action0 = [UIAlertAction actionWithTitle:action_0 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block_0) {
                block_0();
            }        }];
        [alertVc addAction:action0];
    }
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:action_1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block_1) {
            block_1();
        }else{
            [alertVc dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    if (Device_VERSION >= 8.3) {
        [action0 setValue:BLACKTEXTCOLOR forKey:@"_titleTextColor"];
        [action1 setValue:GLOBALCOLOR forKey:@"_titleTextColor"];
    }
    
    //    [alertVc addAction:action0];
    [alertVc addAction:action1];
    [target presentViewController:alertVc animated:YES completion:nil];
}


@end
