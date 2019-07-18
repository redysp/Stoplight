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

@interface FeedViewController ()

@property (strong, nonatomic) NSMutableDictionary *articlesDictionary;
@property (strong, nonatomic) UITableView *categoryTableView;
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CategoryCell *cell = [self.categoryTableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSString *category = self.categoriesList[indexPath.row];
    NSArray *categoryArticles = self.articlesDictionary[category];
    
    cell.articles = categoryArticles;
    cell.categoryNameLabel.text = category;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of sections: , %i", [self.articlesDictionary count]);
    return [self.articlesDictionary count];
}

#pragma mark - Data Fetching

-(void)fetchAllArticles {
    [[APIManager shared] getCategoryArticles:@"category=general&" completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [self.articlesDictionary setValue:generalArticles forKey:@"general"];
        [self.categoryTableView reloadData];
    }];
    
    [[APIManager shared] getCategoryArticles:@"category=business&" completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [self.articlesDictionary setValue:generalArticles forKey:@"business"];
        [self.categoryTableView reloadData];
    }];
    
    [[APIManager shared] getCategoryArticles:@"category=technology&" completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [self.articlesDictionary setValue:generalArticles forKey:@"technology"];
        [self.categoryTableView reloadData];
    }];
    
    [[APIManager shared] getCategoryArticles:@"category=science&" completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [self.articlesDictionary setValue:generalArticles forKey:@"science"];
        [self.categoryTableView reloadData];
    }];
    NSLog(@"Hi");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
