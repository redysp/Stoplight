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
    [self.user setStuff];
    
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
    
    //if already checked, set to unchecked and remove source
    if (cellSelected.isSelected) {
        //change checkedSources value to 0
        self.user.checkedSources[indexPath.row] = @(0);
        
        //changes cell accessory to None
        cellSelected.accessoryType = UITableViewCellAccessoryNone;
        
        //adds source to user sources list
        [self.tempUserChoices removeObject:cellSelected.source_name];
    }
    //if not already checked, set to checked and add source
    else {
        //change checkedSources value to 1
        self.user.checkedSources[indexPath.row] = @(1);
        
        //changes cell acessory to checkmark
        cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //removes source from user sources list
        [self.tempUserChoices addObject:cellSelected.source_name];
    }
    //updates isSelected to reflect changes made
    cellSelected.isSelected = [self.user.checkedSources[indexPath.row] boolValue];
}

//request a cell and run the following code for each one
- (SourceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //get an empty cell
    SourceCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    
    //needs to be a cell user as clicked will get to later
    NSArray *sources = [self getNewsSources];
    NSString *source = sources[indexPath.row];
    
    
    int sourceIndex = (int)[sources indexOfObject:source];
    
    cell.isSelected = [self.user.checkedSources[sourceIndex] boolValue];
    
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

//retrieve default list of all sources available
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getNewsSources] count];
}

- (NSArray *)getNewsSources{
    //hard coded here for now; DONT ACTUALLLY LEAVE LIKE THIS
    return [[NSArray alloc] initWithObjects:@"CNN", @"CNBC", @"Economist", @"Bloomberg", @"Fox", @"Washington Examiner", @"WSJ", @"NBC", @"Reuters", @"AP News", @"Time", @"NPR", nil];
}

@end
