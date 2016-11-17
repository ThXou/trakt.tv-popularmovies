//
//  APIManager.m
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import "APIManager.h"
#import "APIHTTPManager.h"
#import "TTMovie.h"


@implementation APIManager

#pragma mark - Movies

- (void)getPopularMoviesWithCompletionBlock:(CompletionBlock)completionBlock
{
    [[APIHTTPManager sharedManager] GET:@"movies/popular"
                             parameters:@{ @"extended" : @"full" }
                        completionBlock:^(id responseData, NSError *error) {
                            if (error) {
                                completionBlock(nil, error);
                            } else {
                                NSArray *movies = [self parseMoviesWithResponseData:responseData];
                                completionBlock(movies, nil);
                            }
                        }];
}



#pragma mark - Parsing

- (NSArray *)parseMoviesWithResponseData:(NSArray *)responseData
{
    NSMutableArray *movies = [@[] mutableCopy];
    for (NSDictionary *movieData in responseData) {
        TTMovie *movie = [TTMovie importFromDictionary:movieData];
        [movies addObject:movie];
    }
    return movies;
}



@end
