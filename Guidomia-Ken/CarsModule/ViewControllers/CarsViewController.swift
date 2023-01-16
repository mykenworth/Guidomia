//
//  CarsViewController.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation
import UIKit

enum CarsVCSectionTypes {
    case header
    case image
    case car
}

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var sections: [CarsVCSectionTypes] = []
    
    private var vm = CarsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let identifiers: [String] =  ["HeaderCell", "ImageCell", "CarCell"]
        identifiers.forEach({ tableView.register(UINib(nibName: $0, bundle: nil),
                                                 forCellReuseIdentifier: $0) })
        sections = vm.getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK : TableView DataSource Methods
extension CarsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .header, .image, .car:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
            case .header:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
                return cell
            case .image:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UITableViewCell() }
                return cell
            case .car:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarCell else { return UITableViewCell() }
                return cell
        }
    }
}


// MARK : TableView Delegate Methods
extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .header:
            return 45
        case .image:
            return 250
        case .car:
            return 90
        default:
            return UITableView.automaticDimension
        }
    }
}


