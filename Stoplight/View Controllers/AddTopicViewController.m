//
//  AddTopicViewController.m
//  Stoplight
//
//  Created by arleneigwe on 8/5/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AddTopicViewController.h"
#import "AdjustCategoriesViewController.h"
#import "User.h"

@interface AddTopicViewController ()

@end

@implementation AddTopicViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)isPressed:(id)sender {
    //use utilities to edit preferred topics of user
    [self.delegate didTapFollowWithText:self.userInputTextView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
    //reload the view
}
@end
