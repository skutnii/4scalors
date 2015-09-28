//
//  GameWorld.m
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import "GameWorld.h"

@implementation GameWorld

- (void)updateWithValuesFromDictionary:(NSDictionary*)values {
    self.name = values[@"name"];
    self.link = values[@"url"];
}

@end
