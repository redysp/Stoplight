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

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *articlesDictionary;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) NSMutableArray *categoriesList; //in future, probably won't be the same

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articlesDictionary = [[NSMutableDictionary alloc]init];
    
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    
    self.categoriesList = [NSMutableArray arrayWithObjects:@"general", @"business", @"tech", @"science", nil];
    
    [self fetchAllArticles];
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

-(void)fetchCategoryArticles: (NSString *)categoryName{
    //@"category=general&"
    
    NSString *queryString = [NSString stringWithFormat:@"category=%@&", categoryName];
    [[APIManager shared] getCategoryArticles:queryString completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSLog(@"Got data");
        
        if (error) {
            NSLog(@"Error");
            return;
        }
        
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [self.articlesDictionary setValue:generalArticles forKey:categoryName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.categoryTableView reloadData];
            
            //need to create indexpath for that one, not sure how to do this
//            NSIndexPath *myIP = [NSIndexPath indexPathForRow:[self.categoriesList indexOfObjectIdenticalTo:categoryName] inSection:0];
//            NSArray *IPArray = [NSArray arrayWithObjects:myIP, nil];
//            NSLog(@"Got data");
//            [self.categoryTableView beginUpdates];
//            [self.categoryTableView reloadRowsAtIndexPaths:IPArray withRowAnimation:UITableViewRowAnimationNone];
//            [self.categoryTableView endUpdates];
        });
    }];
}


-(void)fetchAllArticles {
    
    for (NSString *category in self.categoriesList) {
        [self fetchCategoryArticles:category];
    }
}

@end
