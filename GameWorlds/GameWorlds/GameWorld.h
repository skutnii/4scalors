//
//  GameWorld.h
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameWorld : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *link;

- (void)updateWithValuesFromDictionary:(NSDictionary*)values;

@end
