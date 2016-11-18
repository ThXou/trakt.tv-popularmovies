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

+ (TTMovie *)importFromDictionary:(NSDictionary *)dictionary searching:(BOOL)searching
{
    TTMovie *movie = [[TTMovie alloc] init];
    [movie importValuesFromDictionary:dictionary searching:searching];
    return movie;
}


- (void)importValuesFromDictionary:(NSDictionary *)dictionary searching:(BOOL)searching
{
    NSDictionary *movie;
    if (searching) {
        movie = dictionary[@"movie"];
    } else {
        movie = dictionary;
    }
    
    NSDictionary *ids = movie[@"ids"];
    self.imdb = ids[@"imdb"] != [NSNull null] ? ids[@"imdb"] : @"";
    
    self.title = movie[@"title"] != [NSNull null] ? movie[@"title"] : @"";
    self.year = movie[@"year"] != [NSNull null] ? [NSString stringWithFormat:@"%li", (long)[movie[@"year"] integerValue]] : @"";
    self.overview = movie[@"overview"] != [NSNull null] ? movie[@"overview"] : @"";
}


- (NSString *)description {
    return [NSString stringWithFormat:@"title: %@ | year: %@", self.title, self.year];
}


@end
