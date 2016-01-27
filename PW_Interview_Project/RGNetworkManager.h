//
//  NetworkManager.h
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGNetworkManager : NSObject
-(void)requestDataFromURL:(NSString *)stringURL success:(void (^)(id responseObject))successCompletionHandler error:(void (^)(NSError *error))errorCompletionHandler;
-(BOOL)networkManagerConnected;
@end
