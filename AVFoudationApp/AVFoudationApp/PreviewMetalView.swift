/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains view code for Metal.
*/

import CoreMedia
import Metal
import MetalKit

class PreviewMetalView: MTKView {
    
    enum Rotation: Int {
        case rotate0Degrees
        case rotate90Degrees
        case rotate180Degrees
        case rotate270Degrees
    }
    
    var mirroring = false {
        didSet {
            syncQueue.sync {
                internalMirroring = mirroring
            }
        }
    }
    
    private var internalMirroring: Bool = false
    
    var rotation: Rotation = .rotate0Degrees {
        didSet {
            syncQueue.sync {
                internalRotation = rotation
            }
        }
    }
    
    private var internalRotation: Rotation = .rotate0Degrees
    
    var pixelBuffer: CVPixelBuffer? {
        didSet {
            syncQueue.sync {
                internalPixelBuffer = pixelBuffer
            }
        }
    }
    
    private var internalPixelBuffer: CVPixelBuffer?
    
    private let syncQueue = DispatchQueue(label: "Preview View Sync Queue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    private var textureCache: CVMetalTextureCache?
    
    private var textureWidth: Int = 0
    
    private var textureHeight: Int = 0
    
    private var textureMirroring = false
    
    private var textureRotation: Rotation = .rotate0Degrees
    
    private var sampler: MTLSamplerState!
    
    private var renderPipelineState: MTLRenderPipelineState!
    
    private var commandQueue: MTLCommandQueue?
    
    private var vertexCoordBuffer: MTLBuffer!
    
    private var textCoordBuffer: MTLBuffer!
    
    private var internalBounds: CGRect!
    
    private var textureTranform: CGAffineTransform?
    
    #if MATTE_CTRL
    var _cameraViewController: CameraViewController?
    var cameraViewController: CameraViewController {
        get {
            return _cameraViewController!
        }
        set {
            _cameraViewController = newValue
        }
    }
    #endif
    
    #if _____PHOTHO_ORIANTATION
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            //return AVCaptureVideoPreviewLayer.self
            return self//videoPreviewLayer.self
        }
    }
    #endif
    
    
    #if DRAW_CROSS
    private var crossVertices = [simd_float2]()
    private var vertexBuffer : MTLBuffer!
           
    var clickPoint_: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var clickPoint: CGPoint {
        get {
            return clickPoint_
        }
        set {
            clickPoint_ = newValue
        }
    }
    #endif
    
    func texturePointForView(point: CGPoint) -> CGPoint? {
        var result: CGPoint?
        guard let transform = textureTranform else {
            return result
        }
        let transformPoint = point.applying(transform)
        
        if CGRect(origin: .zero, size: CGSize(width: textureWidth, height: textureHeight)).contains(transformPoint) {
            result = transformPoint
        } else {
            print("Invalid point \(point) result point \(transformPoint)")
        }
        
        #if DEPTH_INFO
        if .rotate90Degrees == textureRotation || .rotate270Degrees == textureRotation {
            result = CGPoint(x: CGFloat(textureWidth) - transformPoint.x, y: CGFloat(textureHeight) - transformPoint.y)
        }
        #endif
        
        return result
    }
    
    func cameraViewController(point: CGPoint) -> CGPoint? {
        var result: CGPoint?
        guard let transform = textureTranform?.inverted() else {
            return result
        }
        let transformPoint = point.applying(transform)
        
        if internalBounds.contains(transformPoint) {
            result = transformPoint
        } else {
            print("Invalid point \(point) result point \(transformPoint) viewPointForTexture")
        }
        
        return result
    }
    
    func flushTextureCache() {
        textureCache = nil
    }
    
    private func setupTransform(width: Int, height: Int, mirroring: Bool, rotation: Rotation) {
        var scaleX: Float = 1.0
        var scaleY: Float = 1.0
        var resizeAspect: Float = 1.0
        
        internalBounds = self.bounds
        textureWidth = width
        textureHeight = height
        textureMirroring = mirroring
        textureRotation = rotation
        
        if textureWidth > 0 && textureHeight > 0 {
            switch textureRotation {
            case .rotate0Degrees, .rotate180Degrees:
                scaleX = Float(internalBounds.width / CGFloat(textureWidth))
                scaleY = Float(internalBounds.height / CGFloat(textureHeight))
                
            case .rotate90Degrees, .rotate270Degrees:
                scaleX = Float(internalBounds.width / CGFloat(textureHeight))
                scaleY = Float(internalBounds.height / CGFloat(textureWidth))
            }
        }
        // Resize aspect
        resizeAspect = min(scaleX, scaleY)
        if scaleX < scaleY {
            scaleY = scaleX / scaleY
            scaleX = 1.0
        } else {
            scaleX = scaleY / scaleX
            scaleY = 1.0
        }
        
        if textureMirroring {
            scaleX *= -1.0
        }
        
        // Vertex coordinate takes the gravity into account
        let vertexData: [Float] = [
            -scaleX, -scaleY, 0.0, 1.0,
            scaleX, -scaleY, 0.0, 1.0,
            -scaleX, scaleY, 0.0, 1.0,
            scaleX, scaleY, 0.0, 1.0
        ]
        vertexCoordBuffer = device!.makeBuffer(bytes: vertexData, length: vertexData.count * MemoryLayout<Float>.size, options: [])
        
        // Texture coordinate takes the rotation into account
        var textData: [Float]
        switch textureRotation {
        case .rotate0Degrees:
            textData = [
                0.0, 1.0,
                1.0, 1.0,
                0.0, 0.0,
                1.0, 0.0
            ]
            
        case .rotate180Degrees:
            textData = [
                1.0, 0.0,
                0.0, 0.0,
                1.0, 1.0,
                0.0, 1.0
            ]
            
        case .rotate90Degrees:
            textData = [
                1.0, 1.0,
                1.0, 0.0,
                0.0, 1.0,
                0.0, 0.0
            ]
            
        case .rotate270Degrees:
            textData = [
                0.0, 0.0,
                0.0, 1.0,
                1.0, 0.0,
                1.0, 1.0
            ]
        }
        textCoordBuffer = device?.makeBuffer(bytes: textData, length: textData.count * MemoryLayout<Float>.size, options: [])
        
        // Calculate the transform from texture coordinates to view coordinates
        var transform = CGAffineTransform.identity
        if textureMirroring {
            transform = transform.concatenating(CGAffineTransform(scaleX: -1, y: 1))
            transform = transform.concatenating(CGAffineTransform(translationX: CGFloat(textureWidth), y: 0))
        }
        
        switch textureRotation {
        case .rotate0Degrees:
            transform = transform.concatenating(CGAffineTransform(rotationAngle: CGFloat(0)))
            
        case .rotate180Degrees:
            transform = transform.concatenating(CGAffineTransform(rotationAngle: CGFloat(Double.pi)))
            transform = transform.concatenating(CGAffineTransform(translationX: CGFloat(textureWidth), y: CGFloat(textureHeight)))
            
        case .rotate90Degrees:
            transform = transform.concatenating(CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 2))
            transform = transform.concatenating(CGAffineTransform(translationX: CGFloat(textureHeight), y: 0))
            
        case .rotate270Degrees:
            transform = transform.concatenating(CGAffineTransform(rotationAngle: 3 * CGFloat(Double.pi) / 2))
            transform = transform.concatenating(CGAffineTransform(translationX: 0, y: CGFloat(textureWidth)))
        }
        
        transform = transform.concatenating(CGAffineTransform(scaleX: CGFloat(resizeAspect), y: CGFloat(resizeAspect)))
        let tranformRect = CGRect(origin: .zero, size: CGSize(width: textureWidth, height: textureHeight)).applying(transform)
        let transX = (internalBounds.size.width - tranformRect.size.width) / 2
        let transY = (internalBounds.size.height - tranformRect.size.height) / 2
        transform = transform.concatenating(CGAffineTransform(translationX: transX, y: transY))
        textureTranform = transform.inverted()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        #if DRAW_CROSS
        crossVertices = [simd_float2]()
        var position : simd_float2 = simd_float2(x: 0.0, y: 0.0)
        crossVertices.append(position)
        position = simd_float2(x: 0.0, y: 0.0)
        crossVertices.append(position)
        position = simd_float2(x: 0.0, y: 0.0)
        crossVertices.append(position)
        position = simd_float2(x: 0.0, y: 0.0)
        crossVertices.append(position)
        #endif
        
        device = MTLCreateSystemDefaultDevice()
        
        configureMetal()
        
        createTextureCache()
        
        colorPixelFormat = .bgra8Unorm
        
        //#if DRAW_CROSS
        //clickPoint_ = CGPoint(x: 0.0, y: 0.0)
        //#endif
    }
    
    func configureMetal() {
        let defaultLibrary = device!.makeDefaultLibrary()!
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.vertexFunction = defaultLibrary.makeFunction(name: "vertexPassThrough")
        pipelineDescriptor.fragmentFunction = defaultLibrary.makeFunction(name: "fragmentPassThrough")
        
        // To determine how our textures are sampled, we create a sampler descriptor, which
        // will be used to ask for a sampler state object from our device below.
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.sAddressMode = .clampToEdge
        samplerDescriptor.tAddressMode = .clampToEdge
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        sampler = device!.makeSamplerState(descriptor: samplerDescriptor)
        
        do {
            renderPipelineState = try device!.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Unable to create preview Metal view pipeline state. (\(error))")
        }
        
        commandQueue = device!.makeCommandQueue()
        
        #if DRAW_CROSS
        vertexBuffer = device!.makeBuffer(bytes: crossVertices, length: crossVertices.count * MemoryLayout<simd_float2>.stride, options: [])!
        #endif
    }
    
    func createTextureCache() {
        var newTextureCache: CVMetalTextureCache?
        if CVMetalTextureCacheCreate(kCFAllocatorDefault, nil, device!, nil, &newTextureCache) == kCVReturnSuccess {
            textureCache = newTextureCache
        } else {
            assertionFailure("Unable to allocate texture cache")
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var pixelBuffer: CVPixelBuffer?
        var mirroring = false
        var rotation: Rotation = .rotate0Degrees
        
        syncQueue.sync {
            pixelBuffer = internalPixelBuffer
            mirroring = internalMirroring
            rotation = internalRotation
        }
        
        guard let drawable = currentDrawable,
            let currentRenderPassDescriptor = currentRenderPassDescriptor,
            let previewPixelBuffer = pixelBuffer else {
                return
        }
        
        // Create a Metal texture from the image buffer
        let width = CVPixelBufferGetWidth(previewPixelBuffer)
        let height = CVPixelBufferGetHeight(previewPixelBuffer)
        
        if textureCache == nil {
            createTextureCache()
        }
        var cvTextureOut: CVMetalTexture?
        CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                  textureCache!,
                                                  previewPixelBuffer,
                                                  nil,
                                                  .bgra8Unorm,
                                                  width,
                                                  height,
                                                  0,
                                                  &cvTextureOut)
        guard let cvTexture = cvTextureOut, let texture = CVMetalTextureGetTexture(cvTexture) else {
            print("Failed to create preview texture")
            CVMetalTextureCacheFlush(textureCache!, 0)
            return
        }
        
        if texture.width != textureWidth ||
            texture.height != textureHeight ||
            self.bounds != internalBounds ||
            mirroring != textureMirroring ||
            rotation != textureRotation {
            setupTransform(width: texture.width, height: texture.height, mirroring: mirroring, rotation: rotation)
        }
        
        // Set up command buffer and encoder
        guard let commandQueue = commandQueue else {
            print("Failed to create Metal command queue")
            CVMetalTextureCacheFlush(textureCache!, 0)
            return
        }
        
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            print("Failed to create Metal command buffer")
            CVMetalTextureCacheFlush(textureCache!, 0)
            return
        }
        
        guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: currentRenderPassDescriptor) else {
            print("Failed to create Metal command encoder")
            CVMetalTextureCacheFlush(textureCache!, 0)
            return
        }
        
        
        
        commandEncoder.label = "Preview display"
        commandEncoder.setRenderPipelineState(renderPipelineState!)
        commandEncoder.setVertexBuffer(vertexCoordBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBuffer(textCoordBuffer, offset: 0, index: 1)
        
        #if DRAW_CROSS
        crossVertices = [simd_float2]()
        var position : simd_float2 = simd_float2(x: Float(clickPoint_.x), y: Float(clickPoint_.y) - 100)
        crossVertices.append(position)
        position = simd_float2(x: Float(clickPoint_.x), y: Float(clickPoint_.y) + 100)
        crossVertices.append(position)
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 1)
        
        commandEncoder.setVertexBuffer(textCoordBuffer, offset: 0, index: 1)
        commandEncoder.setVertexBuffer(textCoordBuffer, offset: 0, index: 1)
        #endif
        
        commandEncoder.setFragmentTexture(texture, index: 0)
        commandEncoder.setFragmentSamplerState(sampler, index: 0)
        commandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        commandEncoder.endEncoding()
        
        #if DRAW_CROSS
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: clickPoint_.x, y: clickPoint_.y - 10))
        aPath.addLine(to: CGPoint(x: clickPoint_.x, y: clickPoint_.y + 10))
        aPath.move(to: CGPoint(x: clickPoint_.x - 10, y: clickPoint_.y))
        aPath.addLine(to: CGPoint(x: clickPoint_.x + 10, y: clickPoint_.y))
        aPath.lineWidth = 3
        aPath.close()
        UIColor.yellow.set()
        aPath.stroke()
        /*
        if let context = UIGraphicsGetCurrentContext()
        {
            context.setStrokeColor(UIColor.gray.cgColor)
            context.setLineWidth(1)
            context.move(to: CGPoint(x: clickPoint_.x, y: clickPoint_.y - 10))
            context.addLine(to: CGPoint(x: clickPoint_.x, y: clickPoint_.y + 10))
            context.move(to: CGPoint(x: clickPoint_.x - 10, y: clickPoint_.y))
            context.addLine(to: CGPoint(x: clickPoint_.x + 10, y: clickPoint_.y))
            context.strokePath()
        }*/
        #endif
        
        commandBuffer.present(drawable) // Draw to the screen
        commandBuffer.commit()
        
        #if MATTE_CTRL
        cameraViewController.MatteController()
        #endif
    }
    
    public func getPixelColorAt(point:CGPoint) -> UIColor{
        #if IMAGE_CLICK_POS
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                    green: CGFloat(pixel[1])/255.0,
                                    blue: CGFloat(pixel[2])/255.0,
                                    alpha: CGFloat(pixel[3])/255.0)
        
        pixel.deallocate()//(capacity: 4)
        return color
        #endif
    }
}

/*
//PreviewMetalView: MTKView
extension MTKView {
    

}*/
