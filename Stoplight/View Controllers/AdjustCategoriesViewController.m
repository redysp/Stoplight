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
#import "Utility.h"

@interface AdjustCategoriesViewController () <UITableViewDelegate, UITableViewDataSource, AddTopicViewControllerDelegate>
@property User *user;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (nonatomic, retain) UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property AddTopicViewController *controller;
@property NSMutableArray *selectedTopics;
@end

@implementation AdjustCategoriesViewController
@synthesize userInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoriesTableView.dataSource = self;
    self.categoriesTableView.delegate = self;
    self.selectedTopics = [Utility getSelectedTopics];
}


- (IBAction)didTapBack:(id)sender {
    //Save in raw form.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.selectedTopics forKey:@"selectedTopics"];
    [defaults synchronize];
    
    //Save in form feed view controller uses.
    for (int i = 0; i < self.selectedTopics.count; i++) {
        [self.selectedTopics replaceObjectAtIndex:i withObject:[Utility topicToQuery:self.selectedTopics[i]]];
    }
    [defaults setObject:self.selectedTopics forKey:@"selectedTopicsQueryFormat"];
    [defaults synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Need to add text to the list of followed topics.
- (void)didTapFollowWithText:(NSString *)text{
    if (![text isEqualToString:@""] && ![self.selectedTopics containsObject:text]) {
        [self.selectedTopics addObject:text];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.categoriesTableView reloadData];
}

//Opens the view controller where you add the topic in.
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
    return self.selectedTopics.count;
}

//allows for the slide to delete thing
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.user.preferred_topics removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
