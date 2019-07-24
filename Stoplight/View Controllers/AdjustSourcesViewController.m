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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do usual stuff here including getting the cell
    
    //get an empty cell
    UITableViewCell *cell = [self.sourcesTableView dequeueReusableCellWithIdentifier:@"sourceCell" forIndexPath:indexPath];
    
    //all line below needs to be moved as it wont work rn
    //needs to be a cell user as clicked will get to later
    NSArray *sources = [self getNewsSources];
    NSString *source = sources[indexPath.row];
    // determine the data from the IndexPath.row
    
    //allows user to select and deselect
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        //add code for including another source to user sources list
        [self.tempUserChoices addObject:source];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //add code for removing another source from user sources list
        [self.tempUserChoices removeObject:sources];
    }
    
    return cell;
}

//

- (NSArray *)getNewsSources{
    //hard coded here for now; DONT ACTUALLLY LEAVE LIKE THIS
    return [[NSArray alloc] initWithObjects:@"cnn", @"cnbc", @"economist", @"bloomberg", @"fox", @"washingtonexaminer", @"wsj", @"nbc", @"reuters", @"apnews", @"time", @"npr", nil];
    
    //return [[Utility shared] getAllPossibleSources];
}
//dequereusable cell
//cell for row at index path
@end
