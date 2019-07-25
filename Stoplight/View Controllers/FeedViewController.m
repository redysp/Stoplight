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
    
    
    self.categoriesList = [NSMutableArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];

    
    [self fetchArticlesByCategory];
}


#pragma mark - TableView management

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [self.categoryTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSString *category = self.categoriesList[indexPath.row];
    NSArray *categoryArticles = self.displayDict[category];
    
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
    NSMutableArray *sourcesList = [Utility decideSourcesList];
    for (NSMutableArray *list in sourcesList) {
        for (NSString *newsDomain in list){
            [[APIManager shared] getCategoryArticles:newsDomain completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                //Completion block.
                NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //array of dictionaries
                NSLog(@"%@", articlesDictionary);
                if (error) {
                    NSLog(@"Error");
                    return;
                }
            }];
        }
    }
}
    
    /* Here, you would call a function that will get the utility so it passes in the array of categories that the user has selected.
       For now, we have a static array called categoriesList */
  
    
    // Loop through this array, and make API calls for each of the selected categories
//    for (NSString *sources in self.sourcesList) {
//        //[self fetchCategoryArticles:category];
//        [[APIManager shared] getCategoryArticles:sources completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            //Completion block.
//            NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //array of dictionaries
//            NSLog(@"%@ New Call: ", articlesDictionary);
//        }];
    
        
//-(void)fetchCategoryArticles: (NSString *)categoryName{
//    NSString *queryString = ;
//    [[APIManager shared] getCategoryArticles:queryString completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
//
//        if (error) {
//            NSLog(@"Error");
//            return;
//        }
//
//        //array of dictionaries
//        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"];
//        //array of Articles
//        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary];
//        [self.articlesDictionary setValue:generalArticles forKey:categoryName];
//        [self filterArticles:categoryName];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.categoryTableView reloadData];
//
//            need to create indexpath for that one, not sure how to do this
//            NSIndexPath *myIP = [NSIndexPath indexPathForRow:[self.categoriesList indexOfObjectIdenticalTo:categoryName] inSection:0];
//            NSArray *IPArray = [NSArray arrayWithObjects:myIP, nil];
//            NSLog(@"Got data");
//            [self.categoryTableView beginUpdates];
//            [self.categoryTableView reloadRowsAtIndexPaths:IPArray withRowAnimation:UITableViewRowAnimationNone];
//            [self.categoryTableView endUpdates];
//        });
//    }];
//}

/**
 Calls function that pairs category and site for API call.
 **/

#pragma mark - Article Filter Logic

//-(void) filterArticles:(NSString *)categoryName{
//    bool haveLeft = NO;
//    bool haveCenter = NO;
//    bool haveRight = NO;
//
//    for (Article *article in self.articlesDictionary[categoryName]){
//
//        //if provider leans a certain way add article to display dictionary
//        if([self.sortedSourcesDict[@"left"] containsString:article.provider] && !haveLeft){
//            [self.displayDict[categoryName] addObject:article];
//            haveLeft = YES;
//        }
//        if([self.sortedSourcesDict[@"center"] containsString:article.provider] && !haveCenter){
//            [self.displayDict[categoryName] addObject:article];
//            haveCenter = YES;
//        }
//        if([self.sortedSourcesDict[@"right"] containsString:article.provider] && !haveRight){
//            [self.displayDict[categoryName] addObject:article];
//            haveRight = YES;
//        }
//    }
//    if (!haveLeft || !haveCenter || !haveRight){
//        //call api again
//        NSLog(@"We need to call the articles again");
//    }
//}
@end
