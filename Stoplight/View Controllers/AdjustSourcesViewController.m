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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourcesTableView.dataSource = self;
    self.sourcesTableView.delegate = self;
    self.user = [User new];
    [self.user setStuff];
    self.tempUserChoices = [self.user.selectedSources mutableCopy];
    self.sectionNames = @[@"Politics", @"Business", @"US", @"World"];
    
    //list of dictionaries where key is pol. aff and vals dict where key is source and val is checked status
    self.sectionItems = @[
  //Politics
                          @{@"left":@{@"vox.com":@YES, @"nbcnews.com":@YES},@"center":@{@"reuters.com":@YES, @"apnews.com":@YES},@"right":@{@"foxnews.com":@YES, @"nypost.com":@YES}},
  //Business
                          @{@"left":@{@"cnbc.com":@YES, @"economist.com":@YES},@"center":@{@"wsj.com":@YES, @"bloomberg.com":@YES},@"right":@{@"foxbusiness.com":@YES, @"washingtonexaminer.com/business":@YES}},
  //US
                          @{@"left":@{@"cnn.com":@YES, @"time.com":@YES},@"center":@{@"npr.org":@YES, @"usatoday.com":@YES},@"right":@{@"foxnews.com":@YES, @"spectator.org":@YES}},
  //World
                          @{@"left":@{@"cnn.com/world":@YES, @"theguardian.com":@YES},@"center":@{@"reuters.com":@YES, @"bbc.com":@YES},@"right":@{@"foxnews.com/world":@YES, @"dailymail.co.uk":@YES}}];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
- (NSArray *) getAllSources: (NSArray *) sourceArray ofTag: (int) tag{
    NSMutableDictionary *tagDict = [sourceArray objectAtIndex:tag];
    
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SourceCell *cellSelected = [self.sourcesTableView cellForRowAtIndexPath:indexPath];;
    //if already checked, set to unchecked and remove source
    if (cellSelected.isSelected) {
        //change checkedSources value to False
        
        //changes cell accessory to None
        cellSelected.accessoryType = UITableViewCellAccessoryNone;
        
        //adds source to user sources list
        int count = 0;
        while (TRUE){
        if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"left"] allKeys] containsObject:cellSelected.source_name]){
            [[[self.sectionItems objectAtIndex:count] objectForKey:@"left"] setValue:@(NO) forKey:cellSelected.source_name];
            break;
        }
        else if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"center"] allKeys] containsObject:cellSelected.source_name]){
            [[[self.sectionItems objectAtIndex:count] objectForKey:@"center"] setValue:@(NO) forKey:cellSelected.source_name];
            break;
        }
        else if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"right"] allKeys] containsObject:cellSelected.source_name]){
            [[[self.sectionItems objectAtIndex:count] objectForKey:@"right"] setValue:@(NO) forKey:cellSelected.source_name];
            break;
        }
        else{
            count++;
        }
             }
        //updates isSelected to reflect changes made
        cellSelected.isSelected = @(NO);
    }
    //if not already checked, set to checked and add source
    else {
        //change checkedSources value to 1
        
        //changes cell acessory to checkmark
        cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //removes source from user sources list
        int count = 0;
        while (TRUE){
            NSLog(@"%@", [self.sectionItems objectAtIndex:count]);
            NSLog(@"%@",[[self.sectionItems objectAtIndex:count] objectForKey:@"left"]);
            NSLog(@"Cell name: %@", cellSelected.source_name);
            if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"left"] allKeys] containsObject:cellSelected.source_name]){
                [[[self.sectionItems objectAtIndex:count] objectForKey:@"left"] setValue:@(YES) forKey:cellSelected.source_name];
                break;
            }
            else if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"center"] allKeys] containsObject:cellSelected.source_name]){
                [[[self.sectionItems objectAtIndex:count] objectForKey:@"center"] setValue:@(YES) forKey:cellSelected.source_name];
                break;
            }
            else if ([[[[self.sectionItems objectAtIndex:count] objectForKey:@"right"] allKeys] containsObject:cellSelected.source_name]){
                [[[self.sectionItems objectAtIndex:count] objectForKey:@"right"] setValue:@(YES) forKey:cellSelected.source_name];
                break;
            }
            else{
                NSLog(@"%d", count);
                count++;
            }
        }
        //updates isSelected to reflect changes made
        cellSelected.isSelected = @(YES);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//request a cell and run the following code for each one
- (SourceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //get an empty cell
    SourceCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    //NSLog(@"%@",indexPath);
    //needs to be a cell user as clicked will get to later
    //cell.source_name = self.sectionItems[currentHeaderTag]
    
    //cell.isSelected = [self.tempUserChoices[source] boolValue];
    /*
    cell.source_name = section;
    cell.sourceCellLabel.text = section;
     */
    //cell.sourceCellLabel.textColor = [sections objectAtIndex:indexPath.row];
    NSArray *left_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"left"] allKeys];
    NSArray *center_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"center"] allKeys];
    NSArray *right_sources = [[self.sectionItems[currentHeaderTag] objectForKey:@"right"] allKeys];
    
    //all sources in self.sectionItems
    NSArray *sources = [[left_sources arrayByAddingObjectsFromArray:center_sources] arrayByAddingObjectsFromArray:right_sources];
    cell.source_name = sources[sourceIndex];
    cell.sourceCellLabel.text = sources[sourceIndex];
    sourceIndex++;
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
        //NSMutableArray *arrayOfItems = [self.sectionItems objectAtIndex:section];
        return sources.count;
    } else {
        return 0;
    }
    //return [self.tempUserChoices count];
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
        return [self.sectionNames objectAtIndex:section];
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 44.0;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    // recast your view as a UITableViewHeaderFooterView
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [UIColor colorWithHexString:@"#408000"];
    header.textLabel.textColor = [UIColor whiteColor];
    UIImageView *viewWithTag = [self.view viewWithTag:kHeaderSectionTag + section];
    if (viewWithTag) {
        [viewWithTag removeFromSuperview];
    }
    // add the arrow image
    CGSize headerFrame = self.view.frame.size;
    UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 32, 13, 18, 18)];
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

@end
