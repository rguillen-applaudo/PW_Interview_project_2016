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

// requestDataFromURL takes as a parameter a stringURL to perform a get request to this URL
// the method has two different completion blocks: Success and Error
// Once the get request is made the method evaluates the response and executes the corresponding completon block for success or error.
-(void)requestDataFromURL:(NSString *)stringURL success:(void (^)(id))successCompletionHandler error:(void (^)(NSError *))errorCompletionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager GET:stringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        successCompletionHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        errorCompletionHandler(error);
    }];
}

// networkManagerConnected uses reachability library to check if the internet connection is available or not
-(BOOL)networkManagerConnected{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
