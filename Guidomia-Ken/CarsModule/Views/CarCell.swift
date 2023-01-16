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
        
    }
    
    func configure(car: Car) {
        imageThumb.image = UIImage(named: "\(car.model)") ?? UIImage()
        labelTitle.text = "\(car.make) \(car.model)"
        labelPrice.text = "Price: \(Int((car.marketPrice/1000)))k"
        labelRating.text = (1...car.rating).map({ _ in return "★" }).joined(separator:" ")
        labelProsCons.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
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
