//
//  WebViewController.m
//  Stoplight
//
//  Created by emily13hsiao on 7/26/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.url);
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webKitView loadRequest:request];
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
