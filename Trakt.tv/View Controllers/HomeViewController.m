//
//  HomeViewController.m
//  Trakt.tv
//
//  Created by ThXou on 14/11/2016.
//  Copyright © 2016 ThXou. All rights reserved.
//

#import "HomeViewController.h"
#import "APIManager.h"
#import "MovieCell.h"
#import "TTMovie.h"


@interface HomeViewController ()

@property (nonatomic) APIManager *apiManager;
@property (nonatomic) NSArray *movies;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.apiManager = [[APIManager alloc] init];
    [self.apiManager getPopularMoviesWithCompletionBlock:^(id responseData, NSError *error) {
        self.movies = responseData;
        [self.tableView reloadData];
    }];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTMovie *movie = self.movies[indexPath.row];
    
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    [cell configureCellWithMovie:movie];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
