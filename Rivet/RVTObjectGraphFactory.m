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

#import "RVTObjectGraphFactory.h"
#import "RVTAssembly.h"
#import "RVTScope.h"

NSString * const RVTObjectGraphMissingFactoryException = @"RVTObjectGraphMissingFactoryException";

@interface RVTObjectGraphFactory ()
@property (strong, nonatomic, readwrite) RVTAssembly *assembly;
@end

@implementation RVTObjectGraphFactory

+ (id)objectGraphFactoryWithAssembly:(RVTAssembly *)assembly
{
    return [[self alloc] initWithAssembly:assembly];
}

- (id)initWithAssembly:(RVTAssembly *)assembly
{
    if (self = [self init]) {
        self.assembly = assembly;
    }
    return self;
}

- (id)objectForName:(NSString *)name
{
    RVTObjectFactory factory = [[self assembly] factoryForName:name];
    RVTObjectProvider provider = ^id { return factory(self); };
    RVTScope *scope = [[self assembly] scopeForName:name];
    return [scope objectWithProvider:provider];
}

- (id)objectForKeyedSubscript:(NSString *)name
{
    return [self objectForName:name];
}

@end
