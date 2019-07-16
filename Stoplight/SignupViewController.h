//
//  SignupViewController.h
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *haveAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

NS_ASSUME_NONNULL_END
