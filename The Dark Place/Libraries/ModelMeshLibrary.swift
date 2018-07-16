import MetalKit

enum ModelMeshTypes {
    case Tent
    case TentWithPoles
    case Campfire
    case RedMushroom
    case LargeGreenOak
}

class ModelMeshLibrary {
    
    private static var _meshes: [ModelMeshTypes:Mesh] = [:]
    
    public static func Initialize(){
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes(){
        _meshes.updateValue(ModelMesh("Tent_01"), forKey: .Tent)
        _meshes.updateValue(ModelMesh("Tent_Poles_01"), forKey: .TentWithPoles)
        _meshes.updateValue(ModelMesh("Campfire_01"), forKey: .Campfire)
        _meshes.updateValue(ModelMesh("Mushroom_Red_01"), forKey: .RedMushroom)
        _meshes.updateValue(ModelMesh("Large_Oak_Green_01"), forKey: .LargeGreenOak)
    }
    
    public static func Mesh(_ meshType: ModelMeshTypes)->Mesh{
        return _meshes[meshType]!
    }
    
}

protocol Mesh {
    var meshes: [MDLMesh] { get }
}

public class ModelMesh: Mesh {
    var meshes: [MDLMesh] = []
    
    init(_ modelName: String) {
        meshes = ModelLoader.CreateMtkMeshArrayFromWavefront(modelName)
    }
}









