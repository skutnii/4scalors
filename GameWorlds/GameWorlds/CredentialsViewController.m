//
//  CredentialsViewController.m
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import "CredentialsViewController.h"

@interface CredentialsViewController ()

@end

@implementation CredentialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
    [self.delegate credentialsInput:self
                  didSubmitUsername:self.usernameInput.text
                           password:self.passwordInput.text];
}

@end
