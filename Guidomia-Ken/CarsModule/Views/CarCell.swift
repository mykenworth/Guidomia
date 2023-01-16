//
//  CarCell.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelProsCons: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageThumb.image = UIImage()
        labelTitle.text = ""
        labelPrice.text = ""
        labelRating.text = ""
        labelProsCons.text = ""
        
        self.showSeparator()
    }
    
    func configure(car: Car, selected: Bool) {
        imageThumb.image = UIImage(named: "\(car.model)") ?? UIImage()
        labelTitle.text = "\(car.make) \(car.model)"
        labelPrice.text = "Price: \(Int((car.marketPrice/1000)))k"
        labelRating.text = (1...car.rating).map({ _ in return "★" }).joined(separator:" ")
        labelProsCons.attributedText = selected ? generateProsConsAttributedString(for: car.prosList, consList: car.consList) : NSAttributedString()
        
        if selected {
            labelProsCons.isHidden = false
        } else {
            labelProsCons.isHidden = true
        }
    }
    
    private func generateProsConsAttributedString(for prosList: [String], consList: [String]) -> NSAttributedString {
        var prosText = NSAttributedString()
        let pros = prosList.filter({ !$0.isEmpty })
        if (pros.count > 0) {
            prosText = NSAttributedString().sectionText(for: "Pros:", inputArray: pros)
        }
        
        var consText = NSAttributedString()
        let cons = consList.filter({ !$0.isEmpty })
        if (cons.count > 0) {
            consText = NSAttributedString().sectionText(for: "Cons:", inputArray: cons)
        }
        
        return NSAttributedString().combine(attributedStrings: [prosText, consText])
    }
}


