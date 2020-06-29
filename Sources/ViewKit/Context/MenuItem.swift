import Foundation

public struct MenuItem : Encodable {
    
    public var title : String
    public var url : String
    public var position : Int
    
    public init(title: String, url: String, position : Int){
        self.title = title
        self.url = url
        self.position = position
    }
}
