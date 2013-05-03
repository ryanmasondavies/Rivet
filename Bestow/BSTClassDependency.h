//
//  BSTClassDependency.h
//  Bestow
//
//  Created by Ryan Davies on 03/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTDependency.h"

@interface BSTClassDependency : NSObject <BSTDependency>

- (id)initWithClass:(Class)klass initializer:(SEL)initializer argumentProviders:(NSArray *)argumentProviders;

@end
