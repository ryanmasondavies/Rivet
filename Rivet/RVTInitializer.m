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

#import "RVTInitializer.h"
#import "RVTInjector.h"

@implementation RVTInitializer

- (id)initializeInstance:(id)object injector:(RVTInjector *)injector
{
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    for (Class argumentClass in [self argumentClasses]) {
        [arguments addObject:[injector getInstanceOf:argumentClass]];
    }
    
    NSMethodSignature *methodSignature = [[self klass] instanceMethodSignatureForSelector:[self selector]];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:[self selector]];
    for (NSUInteger index = 0; index < [arguments count]; index ++) {
        id argument = arguments[index];
        [invocation setArgument:&argument atIndex:index + 2];
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:object];
    
    __unsafe_unretained id initialized;
    [invocation getReturnValue:&initialized];
    
    return initialized;
}

@end
