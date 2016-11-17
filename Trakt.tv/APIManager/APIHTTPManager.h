//
//  APIManager.h
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import <AFNetworking.h>

@interface APIHTTPManager : AFHTTPSessionManager

+ (APIHTTPManager *)sharedManager;

- (void)GET:(NSString *)path parameters:(id)parameters completionBlock:(CompletionBlock)completionBlock;


@end
