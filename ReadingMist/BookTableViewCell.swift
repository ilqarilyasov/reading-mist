//
//  BookTableViewCell.swift
//  ReadingMist
//
//  Created by Ilgar Ilyasov on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var book: Book? {
        didSet { updateViews() }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var unCheckButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func unCheckButtonTapped(_ sender: UIButton) {
        
    }
    
    private func updateViews() {
        if let book = book {
            bookTitleLabel.text = book.title
            
            let imageName = book.hasBeenRead ? "checked" : "unchecked"
            guard let image = UIImage(named: imageName) else { return }
            unCheckButton.setImage(image, for: .normal)
        }
    }
}
