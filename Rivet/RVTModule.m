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

#import "RVTModule.h"
#import "RVTAssembly.h"
#import "RVTEnvironment.h"
#import "RVTPrototypeScope.h"
#import "RVTSingletonScope.h"

@interface RVTModule ()
@property (strong, nonatomic, readwrite) RVTAssembly *assembly;
@property (strong, nonatomic, readwrite) RVTEnvironment *environment;
@end

@implementation RVTModule

+ (id)moduleWithAssembly:(RVTAssembly *)assembly environment:(RVTEnvironment *)environment
{
    return [[self alloc] initWithAssembly:assembly environment:environment];
}

- (id)initWithAssembly:(RVTAssembly *)assembly environment:(RVTEnvironment *)environment
{
    if (self = [self init]) {
        self.assembly = assembly;
        self.environment = environment;
    }
    return self;
}

- (void)configure
{
}

- (void)define:(NSString *)name as:(RVTObjectFactory)factory
{
    [self define:name in:[RVTPrototypeScope scope] as:factory];
}

- (void)define:(NSString *)name in:(RVTScope *)scope as:(RVTObjectFactory)factory
{
    [[self assembly] setFactory:factory forName:name];
    [[self assembly] setScope:scope forName:name];
}

- (void)require:(Class)moduleClass
{
    [[[moduleClass alloc] initWithAssembly:[self assembly] environment:[self environment]] configure];
}

@end
