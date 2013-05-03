//
//  BSTClassDependency.m
//  Bestow
//
//  Created by Ryan Davies on 03/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "BSTClassDependency.h"
#import "BSTProvider.h"

@interface BSTClassDependency ()
@property (strong, nonatomic) Class klass;
@property (assign, nonatomic) SEL initializer;
@property (strong, nonatomic) NSArray *argumentProviders;
@end

@implementation BSTClassDependency

- (id)initWithClass:(Class)klass initializer:(SEL)initializer argumentProviders:(NSArray *)argumentProviders
{
    if (self = [self init]) {
        self.klass       = klass;
        self.initializer = initializer;
        self.argumentProviders = argumentProviders;
    }
    return self;
}

- (id)resolve
{
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    for (id<BSTProvider> provider in [self argumentProviders]) {
        [arguments addObject:[provider get]];
    }
    
    NSMethodSignature *methodSignature = [[self klass] instanceMethodSignatureForSelector:[self initializer]];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:[self initializer]];
    for (NSUInteger index = 0; index < [arguments count]; index ++) {
        id argument = arguments[index];
        [invocation setArgument:&argument atIndex:index + 2];
    }
    [invocation retainArguments];
    
    id instance = [[self klass] alloc];
    [invocation invokeWithTarget:instance];
    
    __unsafe_unretained id returnValue = nil;
    [invocation getReturnValue:&returnValue];
    
    return returnValue;
}

@end
