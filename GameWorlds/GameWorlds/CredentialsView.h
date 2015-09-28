//
//  CredentialsView.h
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CredentialsView : UIView

@property(nonatomic, strong) IBOutlet UITextField *usernameInput;
@property(nonatomic, strong) IBOutlet UITextField *passwordInput;
@property(nonatomic, strong) IBOutlet UILabel *welcomeLabel;
@property(nonatomic, strong) IBOutlet UIButton *submitButton;

@end
