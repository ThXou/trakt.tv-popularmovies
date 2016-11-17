//
//  MovieCell.m
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import "MovieCell.h"
#import "TTMovie.h"
#import <UIImageView+WebCache.h>


@interface MovieCell ()

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end


@implementation MovieCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _activityIndicator.center = _posterImageView.center;
    [self addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
}


- (void)configureCellWithMovie:(TTMovie *)movie
{
    self.titleLabel.text = movie.title;
    self.yearLabel.text = movie.year;
    self.overviewLabel.text = movie.overview;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.omdbapi.com/?i=%@", movie.imdb]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDictionary *response;
        if (data) {
            response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
                [self.activityIndicator stopAnimating];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:response[@"Poster"]
                                      options:0
                                     progress:nil
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        self.posterImageHeightConstraint.constant = self.posterImageView.frame.size.width / image.size.width * image.size.height;
                                        self.posterImageView.image = image;
                                        [self layoutIfNeeded];
                                    }];
            }
        });
        
    });
    
    
}


@end
