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
    
    var readBooks: [Book] {
        let readBooks = books.filter({ $0.hasBeenRead == true })
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter({ $0.hasBeenRead == false })
        return unreadBooks
    }
    
    // MARK: - Persistent Store Functions
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving data to persistent store: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        guard let url = readingListURL,
            FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            NSLog("Error loading data from persistent store: \(error)")
        }
    }
    
    // MARK: - CRUD methods
    
    func createBook(with title:String, reasonToRead: String) {
        let newBook = Book(with: title, reasonToRead: reasonToRead)
        books.append(newBook)
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
    }
    
}
