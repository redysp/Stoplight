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
@property (weak, nonatomic) IBOutlet UITextView *userInputTextView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) AdjustCategoriesViewController *adjust;
@property (strong, nonatomic) NSObject *delegate;
@end
@protocol AddTopicViewControllerDelegate <NSObject>

- (bool) didTapFollowWithText:(NSString *) text;

@end

@implementation AddTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)isPressed:(id)sender {
    //use utilities to edit preferred topics of user
    /*[self.adjust.user.preferredTopics addObject:]*/
    
    [AddTopicViewController didTapFollowWithText:self.userInputTextView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
    //reload the view
}
@end
