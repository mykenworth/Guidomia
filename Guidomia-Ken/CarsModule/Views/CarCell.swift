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
    }
    
    func configure(car: Car) {
        imageThumb.image = UIImage(named: "\(car.model)") ?? UIImage()
        labelTitle.text = "\(car.make) \(car.model)"
        labelPrice.text = "Price: \(Int((car.marketPrice/1000)))k"
        labelRating.text = (1...car.rating).map({ _ in return "★" }).joined(separator:" ")
        labelProsCons.attributedText = generateProsConsAttributedString(for: car.prosList, consList: car.consList)
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

extension UITableViewCell {
  func hideSeparator() {
    self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
  }

  func showSeparator() {
    self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
  }
}


extension NSAttributedString {
    func sectionText(for title:String, inputArray:[String]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        // add title
        attributedString.append(sectionTitle(with: title))
        attributedString.append(NSAttributedString(string: "\n"))
        
        // add each item a bullet and description
        inputArray.forEach {
            attributedString.append(sectionBullet(with: "•"))
            attributedString.append(sectionItems(with: "\($0)"))
            attributedString.append(NSAttributedString(string: "\n"))
        }
        
        return attributedString
    }
    
    func combine(attributedStrings: [NSAttributedString]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for str in attributedStrings {
            attributedString.append(str)
        }
        return attributedString
    }
    
    private func sectionTitle(with title: String) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.systemGray
        attributes[.font] =  UIFont.systemFont(ofSize: 20, weight: .bold)
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    private func sectionBullet(with bullet: String) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.orange
        attributes[.font] = UIFont.systemFont(ofSize: 22, weight: .bold)
        return NSAttributedString(string: "\(bullet) ", attributes: attributes)
    }
    
    private func sectionItems(with description: String) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.black
        return NSAttributedString(string: description, attributes: attributes)
    }
}


