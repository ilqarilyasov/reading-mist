//
//  BookDetailViewController.swift
//  ReadingMist
//
//  Created by Ilgar Ilyasov on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book? {
        didSet { updateViews() }
    }
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let bookController = bookController,
            let title = bookTitleTextField.text, !title.isEmpty,
            let reason = reasonToReadTextView.text else { return }
        
        if let book = book {
            bookController.update(book: book, title: title, reasonToRead: reason)
        } else {
            bookController.createBook(with: title, reasonToRead: reason)
        }
    }
    
    private func updateViews() {
        if let book = book {
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }
}
