//
//  RealmManager.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 15.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveInRealm(model: ModelSave) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}
