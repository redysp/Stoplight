//
//  AdjustSourcesViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "AdjustSourcesViewController.h"

@interface AdjustSourcesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sourcesTableView;

@end

@implementation AdjustSourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourcesTableView.dataSource = self;
    self.sourcesTableView.delegate = self;
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSave:(id)sender {
    /**
     TODO: SAVE USER DEFAULTS FOR WHAT SOURCES WERE CHOSEN.
     **/
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // do usual stuff here including getting the cell
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    // determine the data from the IndexPath.row
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:self.sourcesTableView cellForRowAtIndexPath:indexPath];
    //other stuff
    
    
    return cell;
}

- (NSArray *)getNewsSources{
    return @[@"ABC",@"MSNBC"];
}
//dequereusable cell
//cell for row at index path
@end
