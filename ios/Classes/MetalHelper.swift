import Metal
import Foundation

@objc public class MetalHelper: NSObject {
    private static var metalDevice: MTLDevice?
    
    @objc public static func isMetalSupported() -> Bool {
        return getMetalDevice() != nil
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
        
        return [
            "name": device.name,
            "maxThreadgroupMemoryLength": device.maxThreadgroupMemoryLength,
            "maxThreadsPerThreadgroup": [
                "width": device.maxThreadsPerThreadgroup.width,
                "height": device.maxThreadsPerThreadgroup.height,
                "depth": device.maxThreadsPerThreadgroup.depth
            ]
        ]
    }
    
    @objc public static func initializeGPU() -> Bool {
        return getMetalDevice() != nil
    }
    
    @objc public static func cleanupGPU() {
        metalDevice = nil
    }
} 