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

@interface FeedViewController ()

@property @property (strong, nonatomic) NSMutableDictionary *articlesDictionary;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)fetchAllArticles {
    [[APIManager shared] getAllArticles:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //Completion block.
        NSArray *articlesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"articles"]; //array of dictionaries
        NSArray *generalArticles = [Article articlesWithArray:articlesDictionary]; //array of Articles
        [results setObject:generalArticles forKey:@"general"];
    ];
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
