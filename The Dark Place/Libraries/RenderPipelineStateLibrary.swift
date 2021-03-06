import MetalKit

enum RenderPipelineStateTypes {
    case Basic
}

class RenderPipelineStateLibrary {
    
    private static var renderPipelineStates: [RenderPipelineStateTypes: RenderPipelineState] = [:]
    
    public static func Initialize(){
        createDefaultRenderPipelineStates()
    }
    
    private static func createDefaultRenderPipelineStates(){
        renderPipelineStates.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
    }
    
    public static func PipelineState(_ renderPipelineStateType: RenderPipelineStateTypes)->MTLRenderPipelineState{
        return (renderPipelineStates[renderPipelineStateType]?.renderPipelineState)!
    }
    
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

public struct Basic_RenderPipelineState: RenderPipelineState {
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.Basic)
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        do{
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}
