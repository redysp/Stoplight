//
//  AdjustCategoriesViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AdjustCategoriesViewController.h"

@interface AdjustCategoriesViewController ()

@end

@implementation AdjustCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSave:(id)sender {
    /**
     TODO: SAVE NSUSER DEFAULTS
    **/
    [self dismissViewControllerAnimated:YES completion:nil];
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
