//
//  BSTCar.m
//  Bestow
//
//  Created by Ryan Davies on 03/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "BSTCar.h"
#import "BSTDriver.h"
#import "BSTEngine.h"

@interface BSTCar ()
@property (strong, nonatomic) BSTDriver *driver;
@property (strong, nonatomic) BSTEngine *engine;
@property (strong, nonatomic) NSArray *wheels;
@end

@implementation BSTCar

- (id)initWithDriver:(BSTDriver *)driver engine:(BSTEngine *)engine wheels:(NSArray *)wheels
{
    if (self = [self init]) {
        self.driver = driver;
        self.engine = engine;
        self.wheels = wheels;
    }
    return self;
}

@end
