// The MIT License
// 
// Copyright (c) 2013 Ryan Davies
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
