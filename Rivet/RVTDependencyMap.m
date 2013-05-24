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

#import "RVTDependencyMap.h"
#import "RVTFactory.h"
#import "RVTDependency.h"

@interface RVTDependencyMap ()
@property (strong, nonatomic) NSMutableDictionary *dependencies;
@end

@implementation RVTDependencyMap

- (id)init
{
    if (self = [self init]) {
        self.dependencies = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setFactory:(RVTFactory *)factory forDependency:(RVTDependency *)dependency
{
    [[self dependencies] setObject:factory forKey:dependency];
}

- (RVTFactory *)factoryForDependency:(RVTDependency *)dependency
{
    RVTFactory *factory = nil;
    
    // look for one in the factory map
    for (RVTDependency *potential in [[self dependencies] allKeys]) {
        if ([potential isApplicableToDependency:dependency]) {
            factory = [[self dependencies] objectForKey:potential];
        }
    }
    
    return factory;
}

@end
