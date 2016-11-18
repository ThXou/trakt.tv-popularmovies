//
//  APIManager.m
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import "APIHTTPManager.h"

static NSString *const kBaseURL = @"https://api.trakt.tv";
static NSString *const kClientID = @"019a13b1881ae971f91295efc7fdecfa48b32c2a69fe6dd03180ff59289452b8";

@interface APIHTTPManager ()



@end


@implementation APIHTTPManager

+ (APIHTTPManager *)sharedManager
{
    static APIHTTPManager *apiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return apiManager;
}


- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:kClientID forHTTPHeaderField:@"trakt-api-key"];
        [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"trakt-api-version"];
    }
    
    return self;
}



#pragma mark - Sending requests

- (void)GET:(NSString *)path parameters:(id)parameters completionBlock:(CompletionBlock)completionBlock
{
    [self GET:path
   parameters:parameters
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:NULL];
          completionBlock(response, nil);
     }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          completionBlock(nil, error);
     }];
}



#pragma mark - Managing operations

- (void)cancel {
    [self.operationQueue cancelAllOperations];
}



@end
