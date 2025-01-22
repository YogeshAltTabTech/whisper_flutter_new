import Metal
import Foundation
import CoreML

@objc public class MetalHelper: NSObject {
    private static var metalDevice: MTLDevice?
    
    @objc public static func isMetalSupported() -> Bool {
        return getMetalDevice() != nil
    }
    
    @objc public static func isCoreMlSupported() -> Bool {
        if #available(iOS 12.0, *) {
            return true
        }
        return false
    }
    
    private static func getMetalDevice() -> MTLDevice? {
        if metalDevice == nil {
            metalDevice = MTLCreateSystemDefaultDevice()
        }
        return metalDevice
    }
    
    @objc public static func getMetalDeviceInfo() -> [String: Any] {
        guard let device = getMetalDevice() else {
            return ["error": "No Metal device available"]
        }
        
        var info: [String: Any] = [
            "name": device.name,
            "maxThreadgroupMemoryLength": device.maxThreadgroupMemoryLength,
            "maxThreadsPerThreadgroup": [
                "width": device.maxThreadsPerThreadgroup.width,
                "height": device.maxThreadsPerThreadgroup.height,
                "depth": device.maxThreadsPerThreadgroup.depth
            ],
            "hasUnifiedMemory": device.hasUnifiedMemory,
            "recommendedMaxWorkingSetSize": device.recommendedMaxWorkingSetSize
        ]
        
        if #available(iOS 12.0, *) {
            info["coreMlAvailable"] = true
            info["preferredMetalDevice"] = MLModel.preferredMetalDevice?.name ?? device.name
        }
        
        return info
    }
    
    @objc public static func initializeGPU() -> Bool {
        guard let device = getMetalDevice() else {
            return false
        }
        
        if #available(iOS 12.0, *) {
            MLModel.preferredMetalDevice = device
        }
        
        return true
    }
    
    @objc public static func cleanupGPU() {
        metalDevice = nil
    }
} 