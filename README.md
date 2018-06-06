# AMRouter

[![Build Status](https://www.bitrise.io/app/f293404a3ac37be3/status.svg?token=HSXXAmv8Pz9ccecLfnCDwQ)](https://www.bitrise.io/app/f293404a3ac37be3)
[![codecov](https://codecov.io/gh/archmagees/AMRouter/branch/master/graph/badge.svg)](https://codecov.io/gh/archmagees/AMRouter)
[![Version](https://img.shields.io/cocoapods/v/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)
[![License](https://img.shields.io/cocoapods/l/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)
[![Platform](https://img.shields.io/cocoapods/p/AMRouter.svg?style=flat)](https://cocoapods.org/pods/AMRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

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

   Now let the class you created in step 1 conform the protocol you just created, then it should be like this now:

   ```objc
   #import <Foundation/Foundation.h>
   #import "MessageComponentInterface.h"
   @interface MessageComponent : NSObject <MessageComponentInterface>
   @end
   ```

3. Now, here comes to step 3, the very important one. Create a category file which class is `AMComponent` . And create a public class method, like this:

   ```objc
   #import <AMRouter/AMRouter.h>
   #import "MessageComponentInterface.h"
   @interface AMComponent (Message)
   + (id<MessageComponentInterface>)message;
   @end
       
   #import "AMComponent+Message.h"
   static NSString * const kTargetName = @"Message";
   @implementation AMComponent (Message)
   + (id<MessageComponentInterface>)message {
       return [[self sharedInstance] targetWithName:kTargetName];
   }
   @end
   ```

4. Now create TWO pods:

   1. One pod, it's name is `XxxComponentInterface`, it should contain these 3 files:

      `XxxComponentInterface.h`(it is also a protocol file), `AMComponent+Xxx.h` and`AMComponent+Xxx.m` . And let this pods be dependent on `AMRouter` .

   2. Second one is `XxxComponent` , it should contain `XxxComponent.h` and `XxxComponent.m` and  any other necessary files which is in the component. And let this pod be dependent on `XxxComponentInterface` .

5. :tada:Finished!  Now you can import the function in another module now, import way is like this:

   ```objc
   BOOL enabled = [[AMComponent message] notificationEnabled];
   ```
   It is only need to be dependent on 1 pod in `Podfile` , that is:

   ```ruby
   pod 'XxxComponentInterface'
   ```

   

## Author

archmagees, archmagees.dev@gmail.com

## License

AMRouter is available under the MIT license. See the LICENSE file for more info.
