//
//  FiltersCell.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import UIKit

protocol FiltersCellDelegate: AnyObject {
    func didSearchFor(make: String)
    func didSearchFor(model: String)
}

class FiltersCell: UITableViewCell {
    @IBOutlet weak var textfieldMake: UITextField!
    @IBOutlet weak var textfieldModel: UITextField!
    
    var delegate: FiltersCellDelegate?
    
    func configure() {
//        mainImageView.image = model.image
//        topLabel.text = "model.topLabelText"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textfieldMake.addTarget(self, action: #selector(FiltersCell.textFieldDidChange(_:)),
                              for: .editingChanged)
        
        textfieldModel.addTarget(self, action: #selector(FiltersCell.textFieldDidChange(_:)),
                               for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case textfieldMake: self.delegate?.didSearchFor(make: textField.text ?? "")
        case textfieldModel: self.delegate?.didSearchFor(model: textField.text ?? "")
        default: break
        }
    }
    
}
