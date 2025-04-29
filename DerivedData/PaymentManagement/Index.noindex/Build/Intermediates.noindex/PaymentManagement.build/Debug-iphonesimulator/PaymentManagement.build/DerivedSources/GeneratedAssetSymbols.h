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

/// The "add" asset catalog image resource.
static NSString * const ACImageNameAdd AC_SWIFT_PRIVATE = @"add";

/// The "airplay" asset catalog image resource.
static NSString * const ACImageNameAirplay AC_SWIFT_PRIVATE = @"airplay";

/// The "compose" asset catalog image resource.
static NSString * const ACImageNameCompose AC_SWIFT_PRIVATE = @"compose";

/// The "dload" asset catalog image resource.
static NSString * const ACImageNameDload AC_SWIFT_PRIVATE = @"dload";

/// The "download" asset catalog image resource.
static NSString * const ACImageNameDownload AC_SWIFT_PRIVATE = @"download";

/// The "logoMain" asset catalog image resource.
static NSString * const ACImageNameLogoMain AC_SWIFT_PRIVATE = @"logoMain";

/// The "logoSample" asset catalog image resource.
static NSString * const ACImageNameLogoSample AC_SWIFT_PRIVATE = @"logoSample";

/// The "percent" asset catalog image resource.
static NSString * const ACImageNamePercent AC_SWIFT_PRIVATE = @"percent";

/// The "printer" asset catalog image resource.
static NSString * const ACImageNamePrinter AC_SWIFT_PRIVATE = @"printer";

/// The "trash" asset catalog image resource.
static NSString * const ACImageNameTrash AC_SWIFT_PRIVATE = @"trash";

/// The "trash-bin" asset catalog image resource.
static NSString * const ACImageNameTrashBin AC_SWIFT_PRIVATE = @"trash-bin";

/// The "upload" asset catalog image resource.
static NSString * const ACImageNameUpload AC_SWIFT_PRIVATE = @"upload";

/// The "user" asset catalog image resource.
static NSString * const ACImageNameUser AC_SWIFT_PRIVATE = @"user";

/// The "wallet" asset catalog image resource.
static NSString * const ACImageNameWallet AC_SWIFT_PRIVATE = @"wallet";

#undef AC_SWIFT_PRIVATE
