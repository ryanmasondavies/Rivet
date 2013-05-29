Rivet
=====

Bolt your application together with dependency injection for iOS.

Motivation
==========

iOS makes heavy use of the master-detail paradigm, resulting in the common instance where a child of a child object requires something from the parent, but the middleman doesn't have a reference to it e.g:

```
A -> B -> C

x is required by A
y is required by B
x is required by C
```

In the above example, without using dependency injection, there are three possible solutions.

The first is that B has a reference to x and passes it to y, even though it never directly uses x. This introduces unnecessary dependencies to objects that don't care about them, which quickly results in objects that hold references to everything in the system.

```
@interface A : NSObject; @end
@interface B : NSObject
- (id)initWithX:(id)x y:(id)y;
@end
@interface C : NSObject
- (id)initWithY:(id)y;
@end
```

In the example, A is responsible for constructing x and y and passing them on:

```
x = [[X alloc] init];
y = [[Y alloc] init];
b = [[B alloc] initWithX:x y:y];
```

B needs to maintain a reference to y, because it is needed to construct C:

```
c = [[C alloc] initWithY:[self y]];
```

This works, but in a real world system introduces plenty of unneeded references. It is also sometimes difficult to notice the references slipping in, thinking that they're necessary and that's that. Gradually, the system becomes more and more complex, and the third variable z is needed for C to do its work. B now needs a reference to z in order to pass it on:

```
// in A:
b = [[B alloc] initWithX:x y:y z:z];

// in B:
c = [[C alloc] initWithX:[self x] z:[self z]];
```

Notice that B is not making use of either x or z at this point, as it only needs y.

Usually when more and more references are introduced (without using [singletons](http://www.youtube.com/watch?v=-FRm3VPhseI)), a new class is added that keeps references to the whole world, and makes them available through accessors:

```
@interface D : NSObject
- (id)initWithX:(id)x y:(id)y z:(id)z;
@property (readonly) id x;
@property (readonly) id y;
@property (readonly) id z;
@end
```

A creates D, then B, and C hold references to D and retrieve what they need from it:

```
// B and C hold references to D:
@interface B : NSObject
- (id)initWithD:(D)d;
@end
@interface C : NSObject
- (id)initWithD:(D)d;
@end

// A builds D and passes it on:
d = [[D alloc] initWithX:x y:y z:z];
b = [[B alloc] initWithD:d];

// B then looks up y in d when it is needed
// C looks up x and z when needed
```

Works great! This is known as the service locator pattern, and while it's preferable to the first solution, it has one major drawback: B and C must look for their dependencies in D. This violates the [Hollywood Principle](http://en.wikipedia.org/wiki/Hollywood_principle): _don't call us, we'll call you_, and breaks the [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter). Additionally, this solution _hides the true dependencies_ of the object, which hides its intent and makes it difficult to see what the class is doing when only looking at its interface.

B and C become more complicated than necessary, and setup and testing become difficult as tests for B and C must construct an instance of D and pass it in. More complications arise when faced with a scenario that requires dynamic construction of objects. Should the service locator know how to build them, or should the client object use build the instance using dependencies in the service locator, and then store the instance in the locator for other objects to find it?

The simplest solution is simply to pass in the references as needed:

```
@interface A : NSObject
- (id)initWithX:(id)x;
@end
@interface B : NSObject
- (id)initWithY:(id)y;
@end
@interface C : NSObject
- (id)initWithX:(id)x z:(id)z;
@end
```

To achieve this, we can create the objects in advance, and make use of local variables to pass in objects as needed:

```
x = ...;
y = ...;
z = ...;
a = [[A alloc] initWithX:x];
b = [[B alloc] initWithY:y];
c = [[C alloc] initWithX:x z:z];
```

Much easier to write, no lookups, and easier to test. However, this is difficult to scale, and difficult to handle dynamic creation of objects and using them for given lifecycles. Rivet aims to alleviate these problems by configuring the structure of an application up front. See the usage for a better idea of how this works.

Further reading:

- [Motivation for Google Guice](http://code.google.com/p/google-guice/wiki/Motivation) (Wikipedia)
- [Don't Look for Things!](http://www.youtube.com/watch?v=RlfLCWKxHJ0) (Google Tech Talks, YouTube)
- [Intro to Objective-C TDD](http://qualitycoding.org/objective-c-tdd/) (Quality Coding, screencast)

Usage
=====

Rivet makes use of Objective-C blocks and subscript accessors to define the structure of a system:

```
@implementation RVTCarModule

- (void)configure
{
    RVTEnvironment *env = [self environment];
    
    [self define:@"Car" in:[RVTSingletonScope scope] as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTCar alloc] initWithEngine:factory[@"Engine"] radio:factory[@"Radio"] wheels:factory[@"Wheels"]];
    }];
    
    [self define:@"Engine" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTEngine alloc] init];
    }];
    
    [self define:@"Radio" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTRadio alloc] initWithFrequency:env[@"Frequency"]];
    }];
    
    [self define:@"Wheels" as:^id(RVTObjectGraphFactory *factory) {
        return @[factory[@"Wheel"], factory[@"Wheel"], factory[@"Wheel"], factory[@"Wheel"]];
    }];
    
    [self define:@"Wheel" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTWheel alloc] init];
    }];
}

@end
```

Environment variables are available through `[self environment]`, configured at a higher level.
Scopes are used to control the lifetime of an object, with two default scopes provided: prototype and singleton. Singleton indicates that the object is one of a kind, and for every request made the same instance will be returned. Prototype indicates that a new instance be created for each request.

Modules are loaded into an `RVTAssembly`, configured with an `RVTEnvironment`:

```
RVTAssembly *assembly = [RVTAssembly assembly];
RVTEnvironment *environment = [RVTEnvironment environmentWithName:@"Production" variables:@{@"Frequency": @102.8}];
[[RVTCarModule moduleWithAssembly:assembly environment:environment] configure];
```

Then loaded into an `RVTObjectGraphFactory`, which will handle the construction of objects and their dependencies:

```
RVTObjectGraphFactory *factory = [RVTObjectGraphFactory objectGraphFactoryWithAssembly:assembly];
factory[@"Car"]; // a car with an engine, radio (set to 102.8 Hz), and wheels
factory[@"Car"]; // calling it again returns the same instance as it's in the singleton scope
```

`[factory objectForName:@""]` is also available for those who prefer it.

Modules are configured through setting factories and requiring submodules:

```
// applying a particular scope
[self define:@"Car" in:[RVTSingletonScope scope] as:^id(RVTObjectGraphFactory *factory) { ... }];

// using the default (prototype) scope
[self define:@"Car" as:^id(RVTObjectGraphFactory *factory) { ... }];

// load another module
[self require:[RVTTestDummyModule class]];
```

It's often necessary to build objects at run time, such as the `view` property on `UIViewController` being loaded/unloaded as needed. Providers are used for this purpose, available by suffixing the object's name with 'Provider':

```
RVTObjectProvider wheelProvider = [factory objectForName:@"Wheel Provider"];
x = wheelProvider(); // a new instance of RVTWheel
y = wheelProvider(); // another instance of RVTWheel, as it is in the prototype scope
```

Installation
============

Rivet can be installed with CocoaPods by adding the following line to your Podfile:

    pod `Rivet`, '~> 0.0.5'

License
=======

    Copyright (c) 2013 Ryan Davies

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
