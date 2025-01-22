#import "WhisperFlutterNewPlugin.h"
#if __has_include(<whisper_flutter_new/whisper_flutter_new-Swift.h>)
#import <whisper_flutter_new/whisper_flutter_new-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "whisper_flutter_new-Swift.h"
#endif

@implementation WhisperFlutterNewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWhisperFlutterNewPlugin registerWithRegistrar:registrar];
}
@end 