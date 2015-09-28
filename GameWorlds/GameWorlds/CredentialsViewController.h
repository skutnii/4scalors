//
//  CredentialsViewController.h
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CredentialsViewController;

@protocol CredentialsDelegate <NSObject>

- (void)credentialsInput:(CredentialsViewController*)cntr
       didSubmitUsername:(NSString*)username password:(NSString*)password;

@end

@interface CredentialsViewController : UIViewController

@property(nonatomic, strong) IBOutlet UITextField *usernameInput;
@property(nonatomic, strong) IBOutlet UITextField *passwordInput;

@property(nonatomic, weak) id<CredentialsDelegate> delegate;

- (IBAction)submit:(id)sender;

@end
