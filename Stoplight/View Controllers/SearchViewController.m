//
//  SearchViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/30/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "SearchViewController.h"
#import "Utility.h"
#import "APIManager.h"
#import "Article.h"
#import "SearchArticleCell.h"
#import "UIImageView+AFNetworking.h"
#import "WebViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *articles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.articles = [[NSMutableArray alloc] init];
    
    //Set datasource and delegate for collection.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //Delegate for search bar.
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SearchToWeb"]) {
        
        SearchArticleCell *tappedCell = sender;
        Article *article = tappedCell.article;
        
        WebViewController *viewController = [segue destinationViewController];
        viewController.url = article.link;
    }
}

#pragma mark - TableView Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchArticleCell" forIndexPath:indexPath];
    
    @try {
        Article *article = self.articles[indexPath.row];
        cell.article = article;
        if (article.title){
            cell.titleLabel.text = article.title;
        }
        if (article.imageLink) {
            [cell.imageView setImageWithURL:article.imageLink];
        }
        return cell;
    } @catch (NSException *exception){
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SearchToWeb" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Search Bar Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    NSString *searchBarText = self.searchBar.text;
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf queryForText:searchBarText];
    });
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.text = @"";
    [self.view endEditing:YES];
}

#pragma mark - Network Call

-(void)queryForText:(NSString *)searchBarText {
    NSDictionary *sourcesDictionary = [Utility fetchGeneralSourceDictionary];
    for (NSString *slant in sourcesDictionary) {
        NSArray *sources = sourcesDictionary[slant];
        for (NSString *source in sources) {
            //[[APIManager shared] getTopicArticlesWith:searchBarText source:source completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [[APIManager shared] getTopicArticlesWithCountAndOffset:searchBarText source:source count:1 offset:self.articles.count/6 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    return;
                }
                NSDictionary *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSArray *articles = [Article articlesWithArray:articlesDictionary[@"value"]];
                
                if (articles.count == 0) {
                    return;
                }
                [[articles objectAtIndex:0] setAffiliation:slant];
                [self.articles addObject:[articles objectAtIndex:0]];
                
                self.isMoreDataLoading = false;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
        }
    }
}

#pragma mark - Scroll View

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            
            NSLog(@"Want to load more.");
            self.isMoreDataLoading = true;
            [self queryForText:self.searchBar.text];
        }
    }
}

@end