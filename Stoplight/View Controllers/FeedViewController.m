//
//  FeedViewController.m
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "FeedViewController.h"
#import "APIManager.h"
#import "Article.h"
#import "CategoryCell.h"
#import "Utility.h"
#import "APIManager.h"
#import "WebViewController.h"
#import "ArticleCell.h"
#import "User.h"
#import "AdjustCategoriesViewController.h"
/**
For right now, tab bar
0 - Home
1 - Following
**/
@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate, AdjustTopicsViewControllerDelegate, UISearchBarDelegate>

//keys --> category; vals--> art list
@property (strong, nonatomic) NSMutableDictionary *articlesDictionary;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) NSArray *sectionsList;

//Dictionary containing articles we want organized by source
//@property (strong,nonatomic) NSMutableDictionary *displayDict;

//dictionary --> (key) pol aff. to (val) list of sources
@property (strong,nonatomic) NSDictionary *sortedSourcesDict;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (strong, nonatomic) UISearchBar *searchBar;


@end

@implementation FeedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Prevents view from showing up before API call
    self.categoryTableView.alpha = 0;
    self.activityIndicator.center = self.view.center;
    [self.activityIndicator startAnimating];
    
    self.articlesDictionary = [[NSMutableDictionary alloc]init];
    
    //Set delegate and datasource for tableview.
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    
     //After merging and doing user defaults from the settings page, it should be like this:
    if (self.tabBarController.selectedIndex == 0) { //Main feed page
        self.sectionsList = [Utility fetchCategoriesList];
    } else  { //Following topics page
        self.sectionsList = [Utility getSelectedTopics];
    }

    
    //Initialize the arrays in dictionaries to be empty
    for (NSString *section in self.sectionsList) {
        self.articlesDictionary[section] = [NSMutableArray new];
    }
    
    //Switching to a different thread to start network call.
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf fetchArticles];
        
    });
    
    //Initialize refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.categoryTableView insertSubview:self.refreshControl atIndex:0];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.categoryTableView.frame.size.width, 44.0)];
    self.searchBar.delegate = self;
}


#pragma mark - TableView management

-(void) beginRefresh:(UIRefreshControl *)refreshControl {
    
    //Go through all articles and delete them.
    for (NSString *section in self.sectionsList) {
        [self.articlesDictionary[section] removeAllObjects];
    }
    //Switching to a different thread to start network call.
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf fetchArticles];
    });
    //[self fetchArticles];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [self.categoryTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSString *section = self.sectionsList[indexPath.row];

    NSArray *categoryArticles = self.articlesDictionary[section];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.articles = categoryArticles;
    
    // Special check for United States category (for correct UI display only)
    if ([section isEqualToString:@"us"]){
        cell.categoryNameLabel.text = @"United States";
    }
    // Check for "+" signs
    else if ([section containsString:@"+"]){
        NSString *stringWithoutPlusSign = [section stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        cell.categoryNameLabel.text = stringWithoutPlusSign;
    }
    else {
        cell.categoryNameLabel.text = [section capitalizedString];
    }
    [cell.categoryCollectionView reloadData];
    cell.vc = self;
  
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionsList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Data Fetching

-(void)fetchArticles {
    if (self.tabBarController.selectedIndex == 0) {
        [self fetchArticlesByCategory];
    } else  {
        [self fetchArticlesByTopic];
    }
}

- (IBAction)didTap:(id)sender {
    [self performSegueWithIdentifier:@"toWeb" sender:nil];
}


-(void)completionBlock:(NSData * _Nullable)data response:(NSURLResponse * _Nullable)response error:(NSError * _Nullable)error slant:(NSString *)slant topic:(NSString *)topic{
    
    if (error) {
        NSLog(@"Error");
        return;
    }
    
    NSDictionary *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //array of unprocessed dictionaries
    NSArray *articles = [Article articlesWithArray:articlesDictionary[@"value"]];
    
    if (articles.count == 0) {
        return;
    }
    
    for (Article *article in articles) {
        [article setAffiliation:slant];
    }
    
    NSArray *filteredArticles;
    
    if (self.tabBarController.selectedIndex == 0) {
        filteredArticles = [self filterArticles:topic articles:articles];
    } else  {
        filteredArticles = [self filterArticlesByTopic:topic articles:articles];
    }
    
    [self.articlesDictionary[topic] addObjectsFromArray:filteredArticles];
    
    if ([self.articlesDictionary[topic] count] == 6) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:[self.sectionsList indexOfObjectIdenticalTo:topic] inSection:0];
            NSArray *IPArray = [NSArray arrayWithObjects:myIP, nil];
            [self.categoryTableView reloadRowsAtIndexPaths:IPArray withRowAnimation:UITableViewRowAnimationNone];
            [self.refreshControl endRefreshing];
            self.categoryTableView.alpha = 1;
            [self.activityIndicator stopAnimating];
        });
    }
}

/**
Uses API call that inputs a query, not a specific source.
**/
-(void)fetchArticlesByTopic {
    NSDictionary *sourcesDictionary = [Utility fetchGeneralSourceDictionary];
    for (NSString *topic in self.sectionsList) {
        for (NSString *slant in sourcesDictionary) {
            NSArray *sourcesArray = sourcesDictionary[slant];
            for (NSString *source in sourcesArray) {
                [[APIManager shared] getTopicArticles:[Utility topicToQuery:topic] source:source completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    [self completionBlock:data response:response error:error slant:slant topic:topic];
                }];
            }
        }
    }
}

/**
Fetches articles by category, not topic.
Uses a different data structure to store sources and a different api call.
**/
-(void)fetchArticlesByCategory {
    NSDictionary *sourcesDictionary = [Utility getSavedSourcesDictionary];
    for (NSString *category in self.sectionsList) {
        NSDictionary *sideDictionary = sourcesDictionary[category]; //Dictionary with keys left, middle, and right
        for (NSString *slant in sideDictionary){
            NSArray *sourcesArray = sideDictionary[slant];
            for (NSString *source in sourcesArray){
                [[APIManager shared] getCategoryArticles:source completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    [self completionBlock:data response:response error:error slant:slant topic:category];
                }];
            }
        }
    }
}


#pragma mark - Article Filter Logic

- (NSArray *) filterArticles:(NSString *)categoryName articles:(NSArray *)articles{
    NSMutableArray *keepArticles = [NSMutableArray new];
    for (Article *article in articles) {
        if (keepArticles.count == 1) {
            break;
        }
        if ([[article.category lowercaseString] isEqualToString:categoryName]) {
            [keepArticles addObject:article];
        }
    }
    //TODO: DEAL WITH THIS. Maybe re-call the API but skip over the ones we already got? Not sure how to do that.
    for (int i = 0; keepArticles.count < 1; i++) {
        [keepArticles addObject:[articles objectAtIndex:i]];
    }
    return keepArticles;
}

- (NSArray *) filterArticlesByTopic:(NSString *)topic articles:(NSArray *)articles {
    //For this one just take the first one.
    NSMutableArray *keepArticles = [NSMutableArray new];
    [keepArticles addObject:[articles objectAtIndex:0]];
    //[keepArticles addObject:[articles objectAtIndex:1]];
    return keepArticles;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Segue into webview.
    if ([segue.identifier isEqualToString:@"toWeb"]) {
        
        ArticleCell *tappedCell = sender;
        Article *article = tappedCell.article;
        
        WebViewController *viewController = [segue destinationViewController];
        viewController.url = article.link;
        
    }
    
}

- (void)didUpdateSources {
    if (self.tabBarController.selectedIndex == 0) { //Main feed page
        self.sectionsList = [Utility fetchCategoriesList];
    } else  { //Following topics page
        self.sectionsList = [Utility getSelectedTopics];
    }
    
    //Need to see which ones weren't there before.
    NSArray *allKeys = [self.articlesDictionary allKeys];
    for (NSString *title in self.sectionsList) {
        if (![allKeys containsObject:title]) {
            self.articlesDictionary[title] = [NSMutableArray new];
        }
    }
    [self.categoryTableView reloadData];
    
    //Switching to a different thread to start network call.
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf fetchArticles];
        
    });
}

#pragma mark - Search

- (IBAction)openSearchBar:(id)sender {
    self.categoryTableView.tableHeaderView = self.searchBar;
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    self.categoryTableView.tableHeaderView = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self performSegueWithIdentifier:@"toSearch" sender:nil];
}





@end
