import Foundation
import Vapor

/// Must add confotmance to this protocol to request to work ok
/// getMenus should get the request and return the menus
/// In its simplest form may be hardwired
/// Or may access a database for the permissions
protocol MenuBuilder {
    func getMenus() throws -> EventLoopFuture<[MenuItem]>
}
