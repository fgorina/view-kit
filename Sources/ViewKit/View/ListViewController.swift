//
//  ListViewController.swift
//  ViewKit
//
//  Created by Tibor Bodecs on 2020. 04. 26..
//

public protocol ListViewController: ViewController {
    /// the name of the list view template
    var listView: String { get }
    /// builds the query in order to list objects in the admin interface
    func beforeList(req: Request, queryBuilder: QueryBuilder<Model>) throws -> QueryBuilder<Model>
 
    func listView(req: Request) throws -> EventLoopFuture<View>

    func setupListRoute(routes: RoutesBuilder)
}

public extension ListViewController {

    func beforeList(req: Request, queryBuilder: QueryBuilder<Model>) throws -> QueryBuilder<Model> {
        queryBuilder
    }

    func listView(req: Request) throws -> EventLoopFuture<View> {
        //TODO: pagination support
        return try self.beforeList(req: req, queryBuilder: Model.query(on: req.db)).all()
            .mapEach(\.viewContext)
            .flatMap { items in
                if let menuGetter = req as? MenuBuilder {
                    do {
                        return try menuGetter.getMenus().flatMap { (menu)  in
                            return req.view.render(self.listView, ListContext(items, menu: menu))
                        }
                    }catch {
                            return req.view.render(self.listView, ListContext(items))
                        }
                } else {
                    return req.view.render(self.listView, ListContext(items))
                    
                }
        }
    }

    func setupListRoute(routes: RoutesBuilder) {
        routes.get(use: self.listView)
    }
}
