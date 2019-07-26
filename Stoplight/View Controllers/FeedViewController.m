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

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

//keys --> category; vals--> art list
@property (strong, nonatomic) NSMutableDictionary *articlesDictionary;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) NSMutableArray *categoriesList;

//Dictionary containing articles we want organized by source
@property (strong,nonatomic) NSMutableDictionary *displayDict;

//dictionary --> (key) pol aff. to (val) list of sources
@property (strong,nonatomic) NSDictionary *sortedSourcesDict;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [Utility init];
    
    self.articlesDictionary = [[NSMutableDictionary alloc]init];
    
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    
    // We will be getting this from the Utility file (which is set by the user in settings)
    self.categoriesList = [NSMutableArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];
    
    //Initialize the arrays in dictionaries to be empty
    for (NSString *category in self.categoriesList) {
        self.articlesDictionary[category] = [NSMutableArray new];
    }
    
    [self fetchArticlesByCategory];
}


#pragma mark - TableView management

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [self.categoryTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSString *category = self.categoriesList[indexPath.row];
    NSArray *categoryArticles = self.articlesDictionary[category];
    
    cell.articles = categoryArticles;
    cell.categoryNameLabel.text = [category capitalizedString];
    [cell.categoryCollectionView reloadData];
  
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoriesList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}




#pragma mark - Data Fetching

-(void)fetchArticlesByCategory {
    NSDictionary *sourcesDictionary = [Utility retrieveSourceDict];
    
    for (NSString *category in self.categoriesList) {
        NSDictionary *sideDictionary = sourcesDictionary[category]; //Dictionary with keys left, middle, and right
        for (NSString *side in sideDictionary){
            NSArray *sourcesArray = sideDictionary[side];
            for (NSString *source in sourcesArray){
                [NSThread sleepForTimeInterval:0.4];
                [[APIManager shared] getCategoryArticles:source completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    //Completion block.
                    if (error) {
                        NSLog(@"Error");
                        return;
                    }
                    
                    NSDictionary *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //array of unprocessed dictionaries
                    NSArray *articles = [Article articlesWithArray:articlesDictionary[@"value"]]; //array of Articles
                    //NSArray *filteredArticles = [self filterArticles:category articles:articles]; //filter so only articles we want stay
                
                    if (articles.count == 0) {
                        NSLog(@"Failed to fetch: %@, %@", source, category);
                        return;
                    }
                    
                    NSArray *filteredArticles = [self filterArticles:category articles:articles];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.articlesDictionary[category] addObjectsFromArray:filteredArticles];
                        [self.categoryTableView reloadData];
                    });
                }];
            }
        }
    }
}
        
// FOR REFERENCE.
//            need to create indexpath for that one, not sure how to do this
//            NSIndexPath *myIP = [NSIndexPath indexPathForRow:[self.categoriesList indexOfObjectIdenticalTo:categoryName] inSection:0];
//            NSArray *IPArray = [NSArray arrayWithObjects:myIP, nil];
//            NSLog(@"Got data");
//            [self.categoryTableView beginUpdates];
//            [self.categoryTableView reloadRowsAtIndexPaths:IPArray withRowAnimation:UITableViewRowAnimationNone];
//            [self.categoryTableView endUpdates];

#pragma mark - Article Filter Logic

- (NSArray *) filterArticles:(NSString *)categoryName articles:(NSArray *)articles{
    NSMutableArray *keepArticles = [NSMutableArray new];
    for (Article *article in articles) {
        if (keepArticles.count == 2) {
            break;
        }
        if ([[article.category lowercaseString] isEqualToString:categoryName]) {
            [keepArticles addObject:article];
        }
    }
    //TODO: DEAL WITH THIS. Maybe re-call the API but skip over the ones we already got? Not sure how to do that.
    for (int i = 0; keepArticles.count < 2; i++) {
        [keepArticles addObject:[articles objectAtIndex:i]];
    }
    return keepArticles;
}
@end
