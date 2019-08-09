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
#import "TrendingTopicsCell.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *articles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *trendingLabel;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) NSDictionary *sourcesDictionary;
@property NSInteger loadCount;
@property NSInteger searchContent;
@property NSMutableArray *trendingTopics;
@property NSMutableArray *trendingTopicsCopy;

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
    
    self.loadCount = 0;
    
    self.searchContent = 0;
    
    self.sourcesDictionary = [Utility fetchGeneralSourceDictionary];
    
    self.trendingTopics = [[NSMutableArray alloc] init];
    self.trendingTopicsCopy = [self.trendingTopics mutableCopy];
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        [strongSelf getTrendingTopics];
        
    });
    
    [self initializeTrendingLabel];
    self.tableView.tableHeaderView = self.trendingLabel;
}

- (void) initializeTrendingLabel {
    self.trendingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 60.0)];
    self.trendingLabel.text = @"Today's trending topics...";
    self.trendingLabel.font = [UIFont systemFontOfSize:30.0 weight:UIFontWeightThin];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.searchContent) {
        if ([segue.identifier isEqualToString:@"SearchToWeb"]) {
            
            SearchArticleCell *tappedCell = sender;
            Article *article = tappedCell.article;
            
            WebViewController *viewController = [segue destinationViewController];
            viewController.url = article.link;
            
            [sender setSelected:NO];
        }
    }
}

#pragma mark - TableView Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.searchContent) {
        SearchArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchArticleCell" forIndexPath:indexPath];
        @try {
            Article *article = self.articles[indexPath.row];
            cell.article = article;
            if (article.title){
                cell.titleLabel.text = article.title;
            }
            if (article.imageLink) {
                cell.articleImageView.layer.cornerRadius = 10;
                cell.articleImageView.clipsToBounds = YES;
                [cell.articleImageView setImageWithURL:article.imageLink];
            }
            return cell;
        } @catch (NSException *exception){
            return cell;
        }
    } else {
        TrendingTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendingTopicsCell" forIndexPath:indexPath];
        cell.trendingTopicLabel.text = self.trendingTopics[indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchContent) {
        return self.articles.count;
    } else {
        return self.trendingTopics.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchContent) {
        [self performSegueWithIdentifier:@"SearchToWeb" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    } else {
        self.searchContent = 1;
        self.searchBar.text = self.trendingTopics[indexPath.row];
        [self.articles removeAllObjects];
        [self clearTrendingTopics];
        self.loadCount = 0;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{self.trendingLabel.alpha = 0;}
                         completion:nil];
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            [strongSelf queryForText:self.trendingTopicsCopy[indexPath.row]];
        });
    }
}

- (void) clearTrendingTopics {
    [self.trendingTopics removeAllObjects];
    //[self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - Search Bar Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchContent = 1;
    
    //Animate disappearance.
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{self.trendingLabel.alpha = 0;}
                     completion:nil];
    
    [self.view endEditing:YES];
    NSString *searchBarText = self.searchBar.text;
    
    [self clearTrendingTopics];
    
    [self.articles removeAllObjects];
    self.loadCount = 0;
    
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
    self.searchContent = 0;
    self.trendingLabel.alpha = 1;
    self.tableView.tableHeaderView = self.trendingLabel;
    self.trendingTopics = [self.trendingTopicsCopy mutableCopy];
    [self.articles removeAllObjects];
    //[self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Network Call

-(void)queryForText:(NSString *)searchBarText {
    for (NSString *slant in self.sourcesDictionary) {
        NSArray *sources = self.sourcesDictionary[slant];
        for (NSString *source in sources) {
            [[APIManager shared] getTopicArticlesWithCountAndOffset:[Utility topicToQuery:searchBarText] source:source count:1 offset:self.articles.count/6 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
                self.loadCount += 1;
                
                self.isMoreDataLoading = false;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.tableView.tableHeaderView = nil;
                    if (self.loadCount == 6) {
                        //[self.tableView reloadData];
                        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                        self.loadCount = 0;
                    }
                });
            }];
        }
    }
}

-(void)getTrendingTopics {
    [[APIManager shared] getTrendingTopicsWithCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.trendingTopics = [Utility parseTrendingTopics:data response:response error:error];
        self.trendingTopicsCopy = [self.trendingTopics mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.tableView reloadData];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
}

#pragma mark - Scroll View

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        float reload_distance = 10;
        if(y > h + reload_distance && ![self.searchBar.text isEqualToString:@""] ) {
            NSLog(@"load more rows");
            self.isMoreDataLoading = true;
            [self queryForText:self.searchBar.text];
        }
    }
}

@end
