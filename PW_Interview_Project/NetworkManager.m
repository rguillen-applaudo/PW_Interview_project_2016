//
//  NetworkManager.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkManager

-(NetworkManager *)startNetworkManager{
    return self;
}

-(void)requestDataFromURL:(NSString *)stringURL success:(void (^)(id))successCompletionHandler error:(void (^)(NSError *))errorCompletionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager GET:stringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        successCompletionHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
        errorCompletionHandler(error);
    }];
}

-(BOOL)networkManagerConnected{
    return YES;
}

@end
