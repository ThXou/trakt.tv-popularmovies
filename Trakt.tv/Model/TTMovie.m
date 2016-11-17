//
//  TTMovie.m
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import "TTMovie.h"
#import "APIManager.h"


@implementation TTMovie

+ (TTMovie *)importFromDictionary:(NSDictionary *)dictionary
{
    TTMovie *movie = [[TTMovie alloc] init];
    [movie importValuesFromDictionary:dictionary];
    return movie;
}


- (void)importValuesFromDictionary:(NSDictionary *)dictionary
{
    NSDictionary *ids = dictionary[@"ids"];
    self.imdb = ids[@"imdb"];
    
    self.title = dictionary[@"title"];
    self.year = dictionary[@"year"];
    self.overview = dictionary[@"overview"];
}


@end
