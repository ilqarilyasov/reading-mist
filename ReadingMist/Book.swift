//
//  Book.swift
//  ReadingMist
//
//  Created by Ilgar Ilyasov on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(with title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
