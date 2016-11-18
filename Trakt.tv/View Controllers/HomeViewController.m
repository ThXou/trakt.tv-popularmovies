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


@interface HomeViewController () <UIScrollViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic) APIManager *apiManager;
@property (nonatomic) NSMutableArray *movies;
@property (nonatomic) NSMutableArray *filteredMovies;
@property (nonatomic, getter = isLoading) BOOL loading;
@property (nonatomic) NSInteger nextPage;
@property (nonatomic) NSInteger filteredNextPage;

@property (nonatomic) UISearchController *searchController;


@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.movies = [@[] mutableCopy];
    self.filteredMovies = [@[] mutableCopy];
    self.nextPage = 1;
    self.filteredNextPage = 1;
    
    self.apiManager = [[APIManager alloc] init];
    
    [self loadMovies];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0;
}



#pragma mark - UIScrollView methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat distanceToBottom = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height);
    self.loading = (distanceToBottom <= 44);
    if (distanceToBottom == 0) {
        if (self.searchController.active && ![self.searchController.searchBar.text isEqualToString:@""]) {
            [self searchMoviesWithTerm:self.searchController.searchBar.text paginating:YES];
        } else {
            [self loadMovies];
        }
    }
}



#pragma mark - UISearchBar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchController.active = NO;
    self.filteredNextPage = 1;
    [self.tableView reloadData];
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
    [self.apiManager getPopularMoviesWithPage:self.nextPage completionBlock:^(id responseData, NSError *error) {
        NSArray *moviesData = responseData;
        if (moviesData.count > 0) {
            [self.movies addObjectsFromArray:responseData];
            self.nextPage++;
            [self.tableView reloadData];
        }
    }];
}


- (void)searchMoviesWithTerm:(NSString *)term paginating:(BOOL)paginating
{
    [self.apiManager searchMoviesWithTerm:term page:self.filteredNextPage completionBlock:^(id responseData, NSError *error) {
        NSArray *moviesData = responseData;
        if (moviesData.count > 0) {
            if (paginating) {
                [self.filteredMovies addObjectsFromArray:responseData];
            } else {
                self.filteredMovies = [responseData mutableCopy];
            }
            
            self.filteredNextPage++;
            [self.tableView reloadData];
        }
    }];
}



#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.filteredNextPage = 1;
    [self searchMoviesWithTerm:searchController.searchBar.text paginating:NO];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active && ![self.searchController.searchBar.text isEqualToString:@""]) {
        return self.filteredMovies.count;
    }
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTMovie *movie;
    if (self.searchController.active && ![self.searchController.searchBar.text isEqualToString:@""]) {
        movie = self.filteredMovies[indexPath.row];
    } else {
        movie = self.movies[indexPath.row];
    }
    
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    [cell configureCellWithMovie:movie];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
