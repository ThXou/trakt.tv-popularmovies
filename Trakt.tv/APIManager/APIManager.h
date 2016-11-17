//
//  APIManager.h
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef __block void (^CompletionBlock)(id responseData, NSError *error);

@interface APIManager : AFHTTPSessionManager

+ (APIManager *)sharedManager;

- (void)GET:(NSString *)path parameters:(id)parameters completionBlock:(CompletionBlock)completionBlock;


@end
