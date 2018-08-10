//
//  Persistable.swift
//  Rappi
//
//  Created by Arnaldo on 8/10/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import RealmSwift

/// Represents a type that can be persisted using Realm.
public protocol Persistable {
    associatedtype ManagedObject: Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
