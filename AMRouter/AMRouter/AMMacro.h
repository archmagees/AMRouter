//
//  AMMacro.h
//  AMRouter
//
//  Created by archmagees on 2018/06/11.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import <Foundation/Foundation.h>


//#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
//    #import <CocoaLumberjack/CocoaLumberjack.h>
//
//    #ifdef DEBUG
//
//        #undef LOG_LEVEL_DEF
//        #define LOG_LEVEL_DEF AMRouterLogLevel
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunused-const-variable"
//
//        #define AMSetDDLogLevel(debugDDLogLevel, noDebugDDLogLevel) \
//        static const DDLogLevel AMRouterLogLevel    = debugDDLogLevel; \
//        DDLogLevel AMRouterLogLevelUnused           = noDebugDDLogLevel;
//
//#pragma clang diagnostic pop
//
//    #else
//
//        #undef LOG_LEVEL_DEF
//        #define LOG_LEVEL_DEF AMRouterLogLevel
//
//        #define AMSetDDLogLevel(debugDDLogLevel, noDebugDDLogLevel) \
//        DDLogLevel AMRouterLogLevelUnused           = debugDDLogLevel; \
//        static const DDLogLevel AMRouterLogLevel    = noDebugDDLogLevel;
//
//    #endif
//
//#endif
//
//
//#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
//#else
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunused-const-variable"
//
//    #define AMSetDDLogLevel(debugDDLogLevelNoEffect, noDebugDDLogLevelNoEffect)
//
//#pragma clang diagnostic pop
//
//#endif
