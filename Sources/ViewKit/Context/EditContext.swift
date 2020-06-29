//
//  EditContext.swift
//  ViewKit
//
//  Created by Tibor Bodecs on 2020. 04. 25..
//

/// a generic edit context for rendering forms
public struct EditContext<T: Encodable>: Encodable {
    
    public var menu : [MenuItem] 
    /// encodable edit property
    public var edit: T
    
    public init(_ edit: T, menu: [MenuItem] = []) {
        self.edit = edit
        self.menu = menu
    }
}


