//
//  TTMovie.h
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTMovie : NSObject

@property (nonatomic, copy) NSString *imdb;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *overview;

+ (TTMovie *)importFromDictionary:(NSDictionary *)dictionary searching:(BOOL)searching;


@end
