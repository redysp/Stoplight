//
//  AdjustCategoriesViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AdjustCategoriesViewController.h"
#import "SettingsCategoryCell.h"
#import "User.h"

@interface AdjustCategoriesViewController () <UITableViewDelegate, UITableViewDataSource>
@property User *user;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@end

@implementation AdjustCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoriesTableView.dataSource = self;
    self.categoriesTableView.delegate = self;
    self.user = [User new];
//    if (self.user.preferred_topics == nil){
//        [self.user setStuff];
//    }
}

- (IBAction)didTapBack:(id)sender {
    /**
     Save user defauls
    **/
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user.preferred_topics forKey:@"selectedCategories"];
    [defaults synchronize];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapAdd:(id)sender {
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SettingsCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCategoryCell" forIndexPath:indexPath];
    cell.settingsCategoryLabel.text = [self.user.preferred_topics[indexPath.row] capitalizedString];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.user.preferred_topics.count;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.user.preferred_topics removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
