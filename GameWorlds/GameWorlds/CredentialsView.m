//
//  CredentialsView.m
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import "CredentialsView.h"

@implementation CredentialsView

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    CGFloat margin = 8;
    CGFloat top = 50;
    
    UIView *views[4] = {self.welcomeLabel, self.usernameInput, self.passwordInput, self.submitButton};
    
    for (unsigned int i = 0; i < 4; ++i) {
        CGRect frame = views[i].frame;
        frame.origin.x = bounds.origin.x + margin;
        frame.origin.y = bounds.origin.y + top;
        frame.size.width = bounds.size.width - 2 * margin;
        views[i].frame = frame;
        
        top += frame.size.height + margin;
    }
}

@end
