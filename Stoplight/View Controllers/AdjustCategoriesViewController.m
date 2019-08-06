//
//  AdjustCategoriesViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AdjustCategoriesViewController.h"
#import "AddTopicViewController.h"
#import "SettingsCategoryCell.h"
#import "User.h"

@interface AdjustCategoriesViewController () <UITableViewDelegate, UITableViewDataSource, AddTopicViewControllerDelegate>
@property User *user;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (nonatomic, retain) UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property AddTopicViewController *controller;
@property NSMutableArray *sortedTopics;
@property NSString *addedString;
@end

@implementation AdjustCategoriesViewController
@synthesize userInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoriesTableView.dataSource = self;
    self.categoriesTableView.delegate = self;
    self.user = [User new];
    self.addedString = @"";
    if (self.user.preferred_topics[0] == nil){
        //call utility class instead
        self.user.preferred_topics = [@[@"Gilroy", @"Dayton shooting", @"tarrifs", @"Hong Kong"] mutableCopy];
    }
    //makes sure array sorted alphabetically
    //self.sortedTopics = (NSMutableArray *)[self.user.preferred_topics sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
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

- (void)didTapFollowWithText:(NSString *)text{
    NSLog(@"didTapFollowCalled");
    self.addedString = text;
    if (![self.addedString isEqualToString:@""]){
    [self.user.preferred_topics addObject:self.addedString];
    }
    NSLog(@"Updated preferred topics:  %@",self.user.preferred_topics);
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.categoriesTableView reloadData];
}

- (IBAction)didTapAdd:(id)sender {
    // grab the view controller we want to show
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"addTopics"];
    self.controller.delegate = self;
    
    // present the controller
    self.controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:self.controller animated:YES completion:nil];
    
    // configure the Popover controller
    UIPopoverPresentationController *popController = [self.controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.addButton;
    popController.delegate = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SettingsCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCategoryCell" forIndexPath:indexPath];
    cell.settingsCategoryLabel.text = [self.user.preferred_topics[indexPath.row] capitalizedString];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.user.preferred_topics.count;
}

//allows for the slide to delete thing
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.user.preferred_topics removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
