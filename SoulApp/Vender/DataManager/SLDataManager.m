//
//  SLDataManager.m
//  SoulApp
//
//  Created by shiyu on 2020/4/20.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLDataManager.h"

@implementation SLDataManager

//获取数据
+ (id)getDataKey:(NSString *)key {
    NSData *dataObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
}

//设置提示
+ (void)setDataKey:(NSString *)key {
    NSData *keyData = [NSKeyedArchiver archivedDataWithRootObject:@"YES"];
    [[NSUserDefaults standardUserDefaults] setObject:keyData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置数据
+ (void)setDataKey:(NSString *)key data:(id)data {
    NSData *keyData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:keyData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//储存图片到沙盒
+ (NSString *)saveImage:(UIImage *)image {
    NSString *imagekey = [NSString stringWithFormat:@"/%.0f.jpg", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000];
    //获取沙盒路径
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接图片名为"currentImage.png"的路径
    NSString *imageFilePath = [filePath stringByAppendingPathComponent:imagekey];
    //其中参数0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    BOOL isSuccessful=[UIImageJPEGRepresentation(image,1) writeToFile:imageFilePath  atomically:YES];
    if (isSuccessful) {
        return imagekey;
    } else {
        return nil;
    }
}

//取出保存的图片
+ (UIImage*)getImage:(NSString *)filePathString {
    if (filePathString.length) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imagePath = [path stringByAppendingPathComponent:filePathString];
        UIImage *getimage = [UIImage imageWithContentsOfFile:imagePath];
        return getimage;
    } else {
        return nil;
    }
}

/* NSString转换NSDate */
+ (NSDate *)NSStringDateToNSDate:(NSString *)datetime formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:datetime];
    return date;
}

/* NSDate转换NSString */
+ (NSString *)NSDateToNSString:(NSDate *)datetime formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:datetime];
    return dateStr;
}

@end
