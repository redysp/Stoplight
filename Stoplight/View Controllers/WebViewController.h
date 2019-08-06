//
//  WebViewController.h
//  Stoplight
//
//  Created by emily13hsiao on 7/26/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSURL *url;
@property (weak, nonatomic) IBOutlet WKWebView *webKitView;

@end

NS_ASSUME_NONNULL_END
