//
//  ModelSave.swift
//  Hoff-MVP
//
//  Created by Abduladzhi on 15.04.2022.
//

import Foundation
import RealmSwift

class ModelSave: Object {
    @Persisted var name: String
    @Persisted var price: String
    @Persisted var favorite: Bool
}
