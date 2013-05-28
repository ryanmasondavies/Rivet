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

#import "RVTAssembly.h"

NSString * const RVTAssemblyMissingFactoryException = @"RVTAssemblyMissingFactoryException";
NSString * const RVTAssemblyMissingScopeException = @"RVTAssemblyMissingScopeException";

@interface RVTAssembly ()
@property (strong, nonatomic, readwrite) NSMutableDictionary *factories;
@property (strong, nonatomic, readwrite) NSMutableDictionary *scopes;
@end

@implementation RVTAssembly

+ (id)assembly
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init]) {
        self.factories = [NSMutableDictionary dictionary];
        self.scopes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (RVTObjectFactory)factoryForName:(NSString *)name
{
    RVTObjectFactory factory = [[self factories] objectForKey:name];
    if (factory == nil) {
        @throw [NSException exceptionWithName:RVTAssemblyMissingFactoryException reason:[NSString stringWithFormat:@"No factory for '%@'", name] userInfo:nil];
    }
    return factory;
}

- (void)setFactory:(RVTObjectFactory)factory forName:(NSString *)name
{
    [[self factories] setObject:factory forKey:name];
}

- (RVTScope *)scopeForName:(NSString *)name
{
    RVTScope *scope = [[self scopes] objectForKey:name];
    if (scope == nil) {
        @throw [NSException exceptionWithName:RVTAssemblyMissingScopeException reason:[NSString stringWithFormat:@"No scope for '%@'", name] userInfo:nil];
    }
    return scope;
}

- (void)setScope:(RVTScope *)scope forName:(NSString *)name
{
    [[self scopes] setObject:scope forKey:name];
}

@end
