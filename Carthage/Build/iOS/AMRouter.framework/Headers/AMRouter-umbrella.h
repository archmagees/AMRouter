#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AMComponent.h"
#import "AMRouter.h"

FOUNDATION_EXPORT double AMRouterVersionNumber;
FOUNDATION_EXPORT const unsigned char AMRouterVersionString[];

