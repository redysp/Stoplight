//
//  SettingsViewController.m
//  Stoplight
//
//  Created by arleneigwe on 7/19/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //in future, probably won't be the same
    //@property (strong, nonatomic) NSArray *categoriesList;
    
    //dictionary --> (key) pol aff. to (val) list of sources
    NSSet *leftSet = [[NSSet alloc] initWithObjects:@"Vox", @"NBC", @"CNBC", @"The Economist", @"CNN", nil];
    NSSet *centerSet = [[NSSet alloc] initWithObjects:@"WSJ", @"Bloomberg", @"Reuters", @"AP News", nil];
    NSSet *rightSet = [[NSSet alloc] initWithObjects:@"Fox Business", "Fox News", "New York Post", nil];
    NSDictionary *sourcesDict = [[NSDictionary alloc] initWithObjectsAndKeys:leftSet, "left", centerSet, "center", rightSet, "right", nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sourcesDict forKey:@"sourcesDict"];
    
    NSArray *categoriesList = [[NSArray alloc] initWithObjects:@"politics", @"business", @"us", @"world", nil];
    [defaults setObject:categoriesList forKey:@"categoriesArray"];
    [defaults synchronize];
    
    
    
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
