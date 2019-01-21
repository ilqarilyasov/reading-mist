//
//  ReadingListTableViewController.swift
//  ReadingMist
//
//  Created by Ilgar Ilyasov on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // MARK: - Properties
    
    let bookController = BookController()

    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Helper Functions
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    // MARK: - BookTableViewCellDelegate
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData() // IMPORTANT
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        guard let bookTVCell = cell as? BookTableViewCell else { fatalError() }
        
        bookTVCell.book = bookFor(indexPath: indexPath)
        bookTVCell.delegate = self

        return bookTVCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return bookController.readBooks.isEmpty ? nil : "Read"
        } else {
            return bookController.unreadBooks.isEmpty ? nil : "Unread"
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // MAYBE LATER
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "CellSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.book = book
            destinationVC.bookController = bookController
        }
    }
}
