import Flutter
import UIKit

public class SwiftWhisperFlutterNewPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "whisper_flutter_new", binaryMessenger: registrar.messenger())
        let instance = SwiftWhisperFlutterNewPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isMetalSupported":
            result(MetalHelper.isMetalSupported())
            
        case "getMetalDeviceInfo":
            result(MetalHelper.getMetalDeviceInfo())
            
        case "initializeGPU":
            result(MetalHelper.initializeGPU())
            
        case "cleanupGPU":
            MetalHelper.cleanupGPU()
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
} 