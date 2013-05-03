//
//  BSTCar.h
//  Bestow
//
//  Created by Ryan Davies on 03/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSTDriver;
@class BSTEngine;

@interface BSTCar : NSObject

- (id)initWithDriver:(BSTDriver *)driver engine:(BSTEngine *)engine wheels:(NSArray *)wheels;

@property (readonly) BSTDriver *driver;
@property (readonly) BSTEngine *engine;
@property (readonly) NSArray *wheels;

@end
