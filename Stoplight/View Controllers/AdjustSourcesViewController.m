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
    self.tempUserChoices = self.user.preferred_sources;
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSave:(id)sender {
    /**
     TODO: SAVE USER DEFAULTS FOR WHAT SOURCES WERE CHOSEN.
     **/
    self.user.preferred_sources = self.tempUserChoices;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SourceCell *cellSelected = [self.sourcesTableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"This is the original list of objects: %@", self.tempUserChoices);
    if (cellSelected.isSelected) {
        NSLog(@"I got to point one");
        //if already checked, set to unchecked and remove source
        self.user.checkedSources[indexPath.row] = @(NO);
        
        //changes cell accessory to None
        cellSelected.accessoryType = UITableViewCellAccessoryNone;
        
        //adds source to user sources list
        [self.tempUserChoices removeObject:cellSelected.source_name];
    } else {
        NSLog(@"I got to point two");
        //if not already checked, set to checked and add source
        self.user.checkedSources[indexPath.row] = @(YES);
        
        //changes cell acessory to checkmark
        cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //removes source from user sources list
        [self.tempUserChoices addObject:cellSelected.source_name];
    }
    NSLog(@"This is the updated list of objects: %@", self.tempUserChoices);
    //updates isSelected to reflect changes made
    cellSelected.isSelected = self.user.checkedSources[indexPath.row];
    
    
}

//request a cell and do this for each one reqs'd
- (SourceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do usual stuff here including getting the cell
    
    //get an empty cell
    SourceCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    
    //needs to be a cell user as clicked will get to later
    NSArray *sources = [self getNewsSources];
    NSString *source = sources[indexPath.row];
    
    //something is wrong with the line below
    cell.isSelected = self.user.checkedSources[indexPath.row];
    
    cell.position = (NSInteger)indexPath.row;
    
    cell.source_name = source;
    cell.sourceCellLabel.text = source;
    
    //allows user to select and deselect
    if (cell.isSelected)
    {
        //marks cell as checked
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        //marks cell as unchecked
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getNewsSources] count];
}

//

- (NSArray *)getNewsSources{
    //hard coded here for now; DONT ACTUALLLY LEAVE LIKE THIS
    return [[NSArray alloc] initWithObjects:@"CNN", @"CNBC", @"Economist", @"Bloomberg", @"Fox", @"Washington Examiner", @"WSJ", @"NBC", @"Reuters", @"AP News", @"Time", @"NPR", nil];
    
    //return [[Utility shared] getAllPossibleSources];
}

@end
