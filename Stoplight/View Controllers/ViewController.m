//
//  ViewController.m
//  Stoplight
//
//  Created by powercarlos25 on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

//#import <NewsAPIClient/NewsAPIClient.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[APIManager shared] getAllArticles];
}


@end
