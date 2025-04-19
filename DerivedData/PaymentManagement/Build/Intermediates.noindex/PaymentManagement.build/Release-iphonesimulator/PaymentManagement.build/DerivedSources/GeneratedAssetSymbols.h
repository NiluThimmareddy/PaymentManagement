#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.nilu.PaymentManagement";

/// The "MainColor" asset catalog color resource.
static NSString * const ACColorNameMainColor AC_SWIFT_PRIVATE = @"MainColor";

#undef AC_SWIFT_PRIVATE
