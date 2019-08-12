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
@property (weak, nonatomic) IBOutlet UIImageView *settingsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *settingsImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *settingsImageView3;
@property (weak, nonatomic) IBOutlet UILabel *accentLabel1;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    CAGradientLayer *gradient3 = [CAGradientLayer layer];
    CAGradientLayer *gradient4 = [CAGradientLayer layer];
    
    gradient1.frame = self.accentLabel1.bounds;
    gradient2.frame = self.settingsImageView.bounds;
    gradient3.frame = self.settingsImageView2.bounds;
    gradient4.frame = self.settingsImageView3.bounds;
    
    gradient1.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    gradient2.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    gradient3.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    gradient4.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    
    [self.accentLabel1.layer insertSublayer:gradient1 atIndex:0];
    [self.settingsImageView.layer insertSublayer:gradient2 atIndex:0];
    [self.settingsImageView2.layer insertSublayer:gradient3 atIndex:0];
    [self.settingsImageView3.layer insertSublayer:gradient4 atIndex:0];
    
    gradient1.startPoint = CGPointMake(0.0, 0.5);
    gradient1.endPoint = CGPointMake(1.0, 0.5);
    gradient2.startPoint = CGPointMake(0.0, 0.5);
    gradient2.endPoint = CGPointMake(1.0, 0.5);
    gradient3.startPoint = CGPointMake(0.0, .5);
    gradient3.endPoint = CGPointMake(1.0, 0.5);
    gradient4.startPoint = CGPointMake(0.0, .5);
    gradient4.endPoint = CGPointMake(1.0, 0.5);
    
    self.accentLabel1.layer.masksToBounds = YES;
    self.accentLabel1.layer.cornerRadius = 3.0;
    self.settingsImageView.layer.masksToBounds = YES;
    self.settingsImageView.layer.cornerRadius = 25.0;
    self.settingsImageView2.layer.cornerRadius = 25.0;
    self.settingsImageView2.layer.masksToBounds = YES;
    self.settingsImageView3.layer.cornerRadius = 25.0;
    self.settingsImageView3.layer.masksToBounds = YES;
    
    //[Utility saveDefaultSources];
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
