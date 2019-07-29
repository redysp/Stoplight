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

#pragma mark - Navigation

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
