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
@property (weak, nonatomic) NSMutableArray *tempUserChoices;
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

//request a cell and do this for each one reqs'd
- (SourceCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do usual stuff here including getting the cell
    
    //get an empty cell
    SourceCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    
    //needs to be a cell user as clicked will get to later
    NSArray *sources = [self getNewsSources];
    bool *isChecked = self.user.isCheckedS[indexPath.row];
    cell.checkStatus = isChecked;
    NSString *source = sources[indexPath.row];
    cell.sourceCellLabel.text = source; //capitalizedString];
    
    //all line below needs to be moved as it wont work rn
    //allows user to select and deselect
    if (isChecked)
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
//dequereusable cell
//cell for row at index path

@end
