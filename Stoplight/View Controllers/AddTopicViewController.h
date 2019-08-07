//
//  AddTopicViewController.h
//  Stoplight
//

//  Created by arleneigwe on 8/5/19.

//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddTopicViewControllerDelegate
- (void) didTapFollowWithText:(NSString *)text;
@end

@interface AddTopicViewController : UIViewController
@property (nonatomic, assign) id<AddTopicViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *userInputTextView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
- (IBAction)isPressed:(id)sender;
@end

NS_ASSUME_NONNULL_END
