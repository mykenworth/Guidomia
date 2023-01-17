//
//  FilterCell.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import UIKit

protocol FilterCellDelegate: AnyObject {
    func didSearch(filter: FilterItem)
}

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var textfieldMake: DropDown!
    @IBOutlet weak var textfieldModel: DropDown!
    
    weak var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureFilter(with makes: [FilterItem], models: [FilterItem]) {
        textfieldMake.optionArray = makes.map({ $0.text })
        textfieldMake.didSelect { selectedText, index, id in
            self.delegate?.didSearch(filter: FilterItem(text: selectedText, type: .make))
        }
        
        textfieldModel.optionArray = models.map({ $0.text })
        textfieldModel.didSelect { selectedText, index, id in
            self.delegate?.didSearch(filter: FilterItem(text: selectedText, type: .model))
        }
    }
}

