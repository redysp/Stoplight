//
//  SettingsViewController.m
//  Stoplight
//
//  Created by arleneigwe on 7/19/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "SettingsViewController.h"
#import "AdjustSourcesViewController.h"
#import "AdjustCategoriesViewController.h"
#import "Utility.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Utility saveDefaultSources];
}

- (IBAction)didTapSources:(id)sender {
    //Go to sources adjustment page.
    AdjustSourcesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AdjustSources"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)didTapCategories:(id)sender {
    AdjustCategoriesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AdjustCategories"];
    vc.delegate = self.tabBarController.viewControllers[1].childViewControllers[0]; //This is literally horrible
    [self presentViewController:vc animated:YES completion:nil];
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
