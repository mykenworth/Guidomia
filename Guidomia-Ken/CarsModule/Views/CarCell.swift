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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(car: Car) {
        imageThumb.image = UIImage(named: "\(car.model)") ?? UIImage()
        labelTitle.text = "\(car.make) \(car.model)"
        labelPrice.text = "Price: \(Int((car.marketPrice/1000)))k"
        labelRating.text = (1...car.rating).map({ _ in return "★" }).joined(separator:" ")
    }
}
