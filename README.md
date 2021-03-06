# AMRouter

[![Build Status](https://travis-ci.org/archmagees/AMRouter.svg?branch=develop)](https://travis-ci.org/archmagees/AMRouter)
[![Coverage Status](https://coveralls.io/repos/github/archmagees/AMRouter/badge.svg?branch=develop)](https://coveralls.io/github/archmagees/AMRouter?branch=develop)
[![Version](https://img.shields.io/cocoapods/v/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)
[![License](https://img.shields.io/cocoapods/l/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)
[![Platform](https://img.shields.io/cocoapods/p/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 9.0

## Installation

AMRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AMRouter'
```

## Usage

1. Create a class, and it's name format should be like this: `ShareComponent` , `MessageComponent`. 

   If your module function is share, then you should create a file with name `ShareComponent`. 

   For example:

   ```objc
   #import <Foundation/Foundation.h>
   @interface MessageComponent : NSObject
   @end
   ```

2. Create a protocol file, and define the methods that you want the class(i.e. just created) exploded, for example:

   ```objc
   @protocol MessageComponentInterface <NSObject>
   @required
   - (BOOL)notificationEnabled;
   @end
   ```

   Now let the class you created in **step 1** conform the protocol you just created, and implement it, then it should be like this now:

   ```objc
   // MessageComponent.h
   #import <Foundation/Foundation.h>
   #import "MessageComponentInterface.h"
   @interface MessageComponent : NSObject <MessageComponentInterface>
   @end
   // MessageComponent.m
   #import "MessageComponent.h"
   @implementation MessageComponent
   - (BOOL)notificationEnabled {
       return YES;
   }
   ```

3. Now, here comes to step 3, the very important one. Create a category file which class is `AMComponent` . And create a public class method, like this:

   ```objc
   // AMComponent+Message.h
   #import <AMRouter/AMRouter.h>
   #import "MessageComponentInterface.h"
   @interface AMComponent (Message)
   + (id<MessageComponentInterface>)message;
   @end
   // AMComponent+Message.m    
   #import "AMComponent+Message.h"
   static NSString * const kTargetName = @"Message";
   @implementation AMComponent (Message)
   + (id<MessageComponentInterface>)message {
       return [self targetWithName:kTargetName
                       classPrefix:nil
               componentNameSuffix:nil
                       shouldCache:YES];
   }
   @end
   ```

4. Now create **TWO** *private* pods, in this example, it should be like these:

   - **`MessageComponentInterface`**
   - **`MessageComponent`**

   1. One pod, it's name is `XxxComponentInterface`, it should contain these 3 files:

      `XxxComponentInterface.h`(it is also a protocol file), `AMComponent+Xxx.h` and`AMComponent+Xxx.m` . And let this pods be dependent on `AMRouter` .

   2. Second one is `XxxComponent` , it should contain `XxxComponent.h` and `XxxComponent.m` and  any other necessary files which is in the component. **And make sure that `XxxComponentInterface` **is in it's `.podspec`  dependency list, e.g.

      ```ruby
      Pod::Spec.new do |s|
        s.name            = 'MessageComponent'
        s.dependency 'MessageComponentInterface'
        ...
      end
      ```

5. :tada:Finished!  Now you can import the function in another module now, import way is just like this:

   ```objc
   BOOL enabled = [[AMComponent message] notificationEnabled];
   ```
   And the `Podfile` in that module is only need **1** pod, that is:

   ```ruby
   pod 'MessageComponentInterface'
   ```

> **Don't forget to import both `MessageComponent` in your main project!**

## Author

archmagees, archmagees.dev@gmail.com

## License

AMRouter is available under the MIT license. See the LICENSE file for more info.
