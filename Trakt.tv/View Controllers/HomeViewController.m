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


@interface HomeViewController () <UIScrollViewDelegate>

@property (nonatomic) APIManager *apiManager;
@property (nonatomic) NSMutableArray *movies;
@property (nonatomic, getter = isLoading) BOOL loading;
@property (nonatomic) NSInteger nextPage;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.movies = [@[] mutableCopy];
    self.nextPage = 1;
    
    [self loadMovies];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0;
}



#pragma mark - UIScrollView methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat distanceToBottom = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height);
    self.loading = (distanceToBottom <= 44);
    if (distanceToBottom == 0) {
        [self loadMovies];
    }
}



#pragma mark - Helpers

- (void)setLoading:(BOOL)loading
{
    if (_loading != loading) {
        _loading = loading;
        
        if (_loading)
        {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicator.contentMode = UIViewContentModeCenter;
            
            CGRect frame = indicator.frame;
            frame.size.height = 44.0;
            indicator.frame = frame;
            
            [indicator startAnimating];
            
            self.tableView.tableFooterView = indicator;
        }
        else {
            self.tableView.tableFooterView = nil;
        }
    }
}


- (void)loadMovies
{
    self.apiManager = [[APIManager alloc] init];
    [self.apiManager getPopularMoviesWithPage:self.nextPage completionBlock:^(id responseData, NSError *error) {
        NSArray *moviesData = responseData;
        if (moviesData.count > 0) {
            [self.movies addObjectsFromArray:responseData];
            self.nextPage++;
            [self.tableView reloadData];
        }
    }];
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
