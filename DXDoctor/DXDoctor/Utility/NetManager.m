//
//  NetManager.m
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"
#import "NSString+Hashing.h"//md5加密
#import "NSFileManager+pathMethod.h"

@implementation NetManager

+(void)requestWithString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock{
    NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"Documents/%@",[urlString   MD5Hash]];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]&&[NSFileManager isTimeOutWithPath:path time:60*60]==NO){
    
        NSData *data=[NSData dataWithContentsOfFile:path];
        finishedBlock(data);
    }else{
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];

        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //每个数据都有唯一的请求地址，数据为NSData，写到本地的文件中，文件名用请求地址的MD5加密之后的字符串
            //MD5为对数据的一种加密方式
            //调用完成block
            //本地的缓存数据，客户端可以规定一个有效时间，有效时间范围内使用缓存数据，否则，重新发起数据请求
            //将请求下来的数据写到本地
//            NSLog(@"%@",responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSData *responseData = (NSData *)responseObject;
                [responseData writeToFile:path atomically:YES];
                finishedBlock(responseData);
                NSDictionary *responseDic=(NSDictionary*)responseObject;
                finishedBlock(responseDic);
            }else{
                NSLog(@"%@",[responseObject class]);
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failedBlock(error.localizedDescription);
        }];
    

   }
}

+ (void)afPostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finishedBlock:(DownloadFinishedBlock)finishedBlock failedBlock:(DownloadFailedBlock)failedBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //Content-Type 要写成与服务器相匹配的类型,一开始可以不写，error信息中会提示我们Content-Type要写成什么
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //实现基本的post请求,函数的参数:为请求地址，和带有post请求参数的字典
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //调用自己定义的block
        finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //捕捉错误信息
        failedBlock(error.localizedDescription);
    }];
}


@end
