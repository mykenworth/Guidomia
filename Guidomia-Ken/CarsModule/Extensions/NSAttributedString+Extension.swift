//
//  NSAttributedString+Extension.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import Foundation
import UIKit

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
