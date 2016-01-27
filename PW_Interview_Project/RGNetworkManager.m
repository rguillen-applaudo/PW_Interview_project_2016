//
//  NetworkManager.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "RGNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"

@implementation RGNetworkManager

-(RGNetworkManager *)startNetworkManager{
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
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
