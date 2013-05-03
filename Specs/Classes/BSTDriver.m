//
//  BSTDriver.m
//  Bestow
//
//  Created by Ryan Davies on 03/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "BSTDriver.h"

@interface BSTDriver ()
@property (strong, nonatomic) NSString *name;
@end

@implementation BSTDriver

- (id)initWithName:(NSString *)name
{
    if (self = [self init]) {
        self.name = name;
    }
    return self;
}

@end
