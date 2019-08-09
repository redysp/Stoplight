//
//  AdjustSourcesViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AdjustSourcesViewController.h"
#import "Utility.h"
#import "User.h"
#import "SourceCell.h"
#import "UIColor+AppColors.h"

static int const kHeaderSectionTag = 6900;
static int currentHeaderTag = 0;
static int sourceIndex = 0;

@interface AdjustSourcesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sourcesTableView;
@property (strong, nonatomic) User *user;
@end

@implementation AdjustSourcesViewController

#pragma mark - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourcesTableView.dataSource = self;
    self.sourcesTableView.delegate = self;
    
    self.sectionNames = [Utility fetchCategoriesList];
    [self initializeSectionItems];
}

- (void) initializeSectionItems {
    //Fetch from user defaults and make all nested layers mutable.
    self.sectionItems = [[Utility getSavedSources] mutableCopy];
    for (int i = 0; i < self.sectionItems.count; i++) {
        self.sectionItems[i] = [self.sectionItems[i] mutableCopy];
        NSArray *keys = [self.sectionItems[i] allKeys];
        for (NSString *slant in keys) {
            self.sectionItems[i][slant] = [self.sectionItems[i][slant] mutableCopy];
        }
    }
}


#pragma mark - TableView Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SourceCell *cellSelected = [self.sourcesTableView cellForRowAtIndexPath:indexPath];
    
    if (cellSelected.isSelected) {
        [self deselectSource:indexPath];
    } else {
        [self selectSource:indexPath];
    }
}

- (SourceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SourceCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    
    NSArray *left_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"left"] allKeys];
    NSArray *center_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"center"] allKeys];
    NSArray *right_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"right"] allKeys];
    
    
    NSArray *sources = [[left_sources arrayByAddingObjectsFromArray:center_sources] arrayByAddingObjectsFromArray:right_sources];
    
    //there is a bug here watch out lmao
    cell.source_name = sources[indexPath.row];
    cell.sourceCellLabel.text = sources[indexPath.row];
    sourceIndex++; //literally what even is this?
    
    //SET SELECTED STATE
    NSString *affiliation;
    for (NSString *key in self.sectionItems[indexPath.section]) { //self.sectionItems[indexPath.section] will be like "politics dictionary", so keys are "left", "center", "right"
        //Get nested dictionary where key:source, value:YES/NO
        NSMutableDictionary *dict = self.sectionItems[indexPath.section][key];
        //Get keys of that dictionary, which should be source names
        NSArray *sourceNames = [dict allKeys];
        if ([sourceNames containsObject:cell.source_name]) {
            affiliation = key;
            cell.isSelected = [self.sectionItems[indexPath.section][key][cell.source_name] boolValue];
            break;
        }
    }
    //set marker color
    if ([affiliation isEqualToString:@"left"]) {
        cell.markerLabel.backgroundColor = [UIColor blueColor];
    } else if ([affiliation isEqualToString:@"center"]) {
        cell.markerLabel.backgroundColor = [UIColor grayColor];
    } else {
        cell.markerLabel.backgroundColor = [UIColor redColor];
    }
    
    //Set checkmark or no checkmark.
    if (cell.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


//retrieve default list of all sources available
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.expandedSectionNumber == section) {
        NSArray *left_sources = [[self.sectionItems[section] objectForKey:@"left"] allKeys];
        NSArray *center_sources = [[self.sectionItems[section] objectForKey:@"center"] allKeys];
        NSArray *right_sources = [[self.sectionItems[section] objectForKey:@"right"] allKeys];
        
        //all sources in self.sectionItems
        NSArray *sources = [[left_sources arrayByAddingObjectsFromArray:center_sources] arrayByAddingObjectsFromArray:right_sources];
        return sources.count;
    } else {
        return 0;
    }
}

//number of sections to be displayed
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sectionNames.count > 0) {
        self.sourcesTableView.backgroundView = nil;
        return self.sectionNames.count;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"Retrieving data.\nPlease wait.";
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        [messageLabel sizeToFit];
        self.sourcesTableView.backgroundView = messageLabel;
        return 0;
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.sectionNames.count){
        //only way to properly capitalize
        if ([[self.sectionNames objectAtIndex:section] isEqualToString:@"us"]){
            return @"US";
        }
        return [[self.sectionNames objectAtIndex:section] capitalizedString];
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 80.0;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    // recast your view as a UITableViewHeaderFooterView
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [UIColor colorWithHexString:@"#313131"];
    header.textLabel.textColor = [UIColor whiteColor];
    UIImageView *viewWithTag = [self.view viewWithTag:kHeaderSectionTag + section];
    if (viewWithTag) {
        [viewWithTag removeFromSuperview];
    }
    // add the arrow image
    CGSize headerFrame = self.view.frame.size;
    UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 50, 25, 25, 25)];
    theImageView.image = [UIImage imageNamed:@"Chevron-Dn-Wht"];
    theImageView.tag = kHeaderSectionTag + section;
    [header addSubview:theImageView];
    // make headers touchable
    header.tag = section;
    UITapGestureRecognizer *headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderWasTouched:)];
    [header addGestureRecognizer:headerTapGesture];
}
- (void)tableViewCollapeSection:(NSInteger)section withImage:(UIImageView *)imageView {
    sourceIndex = 0;
    NSArray *left_sources = [[self.sectionItems[section] objectForKey:@"left"] allKeys];
    NSArray *center_sources = [[self.sectionItems[section] objectForKey:@"center"] allKeys];
    NSArray *right_sources = [[self.sectionItems[section] objectForKey:@"right"] allKeys];
    
    //all sources in self.sectionItems
    NSArray *sources = [[left_sources arrayByAddingObjectsFromArray:center_sources] arrayByAddingObjectsFromArray:right_sources];
    
    //NSArray *sectionData = [self.sectionItems objectAtIndex:section];
    self.expandedSectionNumber = -1;
    if (sources.count == 0) {
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((0.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sources.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        [self.sourcesTableView beginUpdates];
        [self.sourcesTableView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.sourcesTableView endUpdates];
    }
}

- (void)tableViewExpandSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *left_sources = [[self.sectionItems[section] objectForKey:@"left"] allKeys];
    NSArray *center_sources = [[self.sectionItems[section] objectForKey:@"center"] allKeys];
    NSArray *right_sources = [[self.sectionItems[section] objectForKey:@"right"] allKeys];
    
    //all sources in self.sectionItems
    NSArray *sources = [[left_sources arrayByAddingObjectsFromArray:center_sources] arrayByAddingObjectsFromArray:right_sources];
    //NSArray *sectionData = [self.sectionItems objectAtIndex:section];
    
    if (sources.count == 0) {
        self.expandedSectionNumber = -1;
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((180.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sources.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        self.expandedSectionNumber = section;
        [self.sourcesTableView beginUpdates];
        [self.sourcesTableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.sourcesTableView endUpdates];
    }
}

- (void)sectionHeaderWasTouched:(UITapGestureRecognizer *)sender {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)sender.view;
    NSInteger section = headerView.tag;
    currentHeaderTag = section;
    //identifier for each header
    
    UIImageView *eImageView = (UIImageView *)[headerView viewWithTag:kHeaderSectionTag + section];
    self.expandedSectionHeader = headerView;
    if (self.expandedSectionNumber == -1) {
        self.expandedSectionNumber = section;
        [self tableViewExpandSection:section withImage: eImageView];
    } else {
        if (self.expandedSectionNumber == section) {
            [self tableViewCollapeSection:section withImage: eImageView];
            self.expandedSectionHeader = nil;
        } else {
            UIImageView *cImageView  = (UIImageView *)[self.view viewWithTag:kHeaderSectionTag + self.expandedSectionNumber];
            [self tableViewCollapeSection:self.expandedSectionNumber withImage: cImageView];
            [self tableViewExpandSection:section withImage: eImageView];
        }
    }
}


#pragma mark - User Selection Methods

-(void) selectSource:(NSIndexPath *)indexPath {
    //Retrieve header string.
    NSString *headerTitle = [[self.sourcesTableView headerViewForSection:indexPath.section].textLabel.text lowercaseString];
    //Retrieve selected cell
    SourceCell *cellSelected = [self.sourcesTableView cellForRowAtIndexPath:indexPath];
    
    //change nested dictionary value to NO.
    NSInteger headerIndex = [self.sectionNames indexOfObject:headerTitle];
    //This gets a dictionary with keys left/right/center
    NSDictionary *sourcesDictionary = self.sectionItems[headerIndex];
    
    //Iterate through dictionary keys ("left", "right", "center") to find the item
    for (NSString *key in sourcesDictionary) {
        //Get nested dictionary where key:source, value:YES/NO
        NSMutableDictionary *dict = sourcesDictionary[key];
        //Get keys of that dictionary, which should be source names
        NSArray *sourceNames = [dict allKeys];
        if ([sourceNames containsObject:cellSelected.source_name]) {
            self.sectionItems[headerIndex][key][cellSelected.source_name] = @(YES);
            break;
        }
    }
    
    //changes cell accessory to None
    cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //updates isSelected to reflect changes made
    cellSelected.isSelected = YES;
}

- (void) deselectSource:(NSIndexPath *)indexPath {
    //Retrieve header string.
    NSString *headerTitle = [[self.sourcesTableView headerViewForSection:indexPath.section].textLabel.text lowercaseString];
    //Retrieve selected cell
    SourceCell *cellSelected = [self.sourcesTableView cellForRowAtIndexPath:indexPath];
    
    //change nested dictionary value to NO.
    NSInteger headerIndex = [self.sectionNames indexOfObject:headerTitle];
    //This gets a dictionary with keys left/right/center
    NSDictionary *sourcesDictionary = self.sectionItems[headerIndex];
    
    //Iterate through dictionary keys ("left", "right", "center") to find the item
    for (NSString *key in sourcesDictionary) {
        //Get nested dictionary where key:source, value:YES/NO
        NSMutableDictionary *dict = sourcesDictionary[key];
        //Get keys of that dictionary, which should be source names
        NSArray *sourceNames = [dict allKeys];
        if ([sourceNames containsObject:cellSelected.source_name]) {
            self.sectionItems[headerIndex][key][cellSelected.source_name] = @(NO);
            break;
        }
    }
    
    //changes cell accessory to None
    cellSelected.accessoryType = UITableViewCellAccessoryNone;
    
    //updates isSelected to reflect changes made
    cellSelected.isSelected = NO;
}

#pragma mark - Saving Data

/**
 Save to User defaults the array of dictionaries in raw form.
 **/
-(void) saveSelectedItems {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.sectionItems forKey:@"savedSources"];
    [defaults synchronize];
}

/**
 Process to format compatible with feed view controller, save to user defaults.
 **/
-(NSMutableDictionary *) createSelectedItemsDictionary {
    NSMutableDictionary *feedDictionary = [[NSMutableDictionary alloc] init];
    NSArray *slantList = [NSArray arrayWithObjects:@"left", @"center", @"right", nil];
    
    for (int i = 0; i < self.sectionNames.count; i++) { //This level of iteration is for categories on both.
        NSString *categoryName = self.sectionNames[i];
        NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *slant in slantList) {
            NSArray *sourcesBySlant = [self sourcesBySlant:i slant:slant];
            [categoryDictionary setObject:sourcesBySlant forKey:slant];
        }
        [feedDictionary setObject:categoryDictionary forKey:categoryName];
    }
    return feedDictionary;
}

-(void) saveSelectedItemsDictionary:(NSMutableDictionary *)feedDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:feedDictionary forKey:@"savedSourcesDictionary"];
    [defaults synchronize];
}

-(NSMutableArray *)sourcesBySlant:(NSInteger)categoryIndex slant:(NSString *)slant {
    NSMutableDictionary *leftDict = self.sectionItems[categoryIndex][slant]; //gets dictionary of yes no for all sources in particular category.slant
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *source in leftDict) {
        if ([leftDict[source] boolValue]) {
            [arr addObject:source];
        }
    }
    return arr;
}

#pragma mark - Navigation

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 1. Make the right format.
 2. Check to see if it is ok.
 a. If ok then save both
 b. If not ok then alert user.
 **/
- (IBAction)didTapSave:(id)sender {
    
    NSMutableDictionary *feedDictionary = [self createSelectedItemsDictionary];
    
    if ([self checkSourceRatio:feedDictionary]) {
        [self saveSelectedItems];
        [self saveSelectedItemsDictionary:feedDictionary];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Selection"
                                                                       message:@"In order to maintain a balanced mix of liberal, moderate, and conservative news sources, we ask that users choose 2 providers from each political bias. Please check your selections and try again."
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL) checkSourceRatio:(NSMutableDictionary *)categoryDictionary {
    for (NSString *category in categoryDictionary) {
        for (NSString *slant in categoryDictionary[category]) {
            if ([categoryDictionary[category][slant] count] != 2) {
                return NO;
            }
        }
    }
    return YES;
}



@end

