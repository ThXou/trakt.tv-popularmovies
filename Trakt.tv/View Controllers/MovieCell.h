//
//  MovieCell.h
//  Trakt.tv
//
//  Created by ThXou on 17/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

@class TTMovie;
@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *overviewLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *posterImageHeightConstraint;

- (void)configureCellWithMovie:(TTMovie *)movie;

@end
