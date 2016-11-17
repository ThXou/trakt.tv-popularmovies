//
//  APIManager.h
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

@interface APIManager : NSObject

- (void)getPopularMoviesWithCompletionBlock:(CompletionBlock)completionBlock;

@end
