//
//  BookController.swift
//  ReadingMist
//
//  Created by Ilgar Ilyasov on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    
    private(set) var books = [Book]()
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = dir.appendingPathComponent("realingList.plist")
        
        return url
    }
    
    // MARK: - Functions
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error encoding books array to data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL,
            FileManager.default.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            NSLog("Error decoding data to books array: \(error)")
        }
        
    }
    
}
