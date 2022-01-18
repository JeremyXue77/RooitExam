//
//  Database.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import RealmSwift

class Database<Item: Object> {
    
    // MARK: Properties
    private let realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    // MARK: Initializers
    init() {
        _ = try? restore()
    }
    
    // MARK: Binding Action
    var onChanged: (([Item]) -> Void)?
    
    // MARK: Methods
    func save(items: [Item]) throws {
        try realm.write {
            realm.deleteAll()
            realm.add(items)
        }
    }
    
    func restore() throws -> [Item] {
        let objects = realm.objects(Item.self)
        let items = Array(objects)
        notificationToken?.invalidate()
        notificationToken = objects.observe { [weak self](change) in
            switch change {
            case .update:
                self?.onChanged?(items)
            default:
                break
            }
        }
        return items
    }
}
