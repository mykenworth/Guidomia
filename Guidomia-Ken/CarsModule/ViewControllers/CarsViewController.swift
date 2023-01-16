//
//  CarsViewController.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation
import UIKit

enum SectionTypes {
    case header
    case image
    case car(models: [Car])
}

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var sections: [SectionTypes] = []
    var selectedIndexPath = IndexPath(row: 0, section: 2) // default selected per requirement (1st car item)
    
    private var vm = CarsViewModel(databaseService: APIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let identifiers: [String] =  ["HeaderCell", "ImageCell", "CarCell"]
        identifiers.forEach({ tableView.register(UINib(nibName: $0, bundle: nil),
                                                 forCellReuseIdentifier: $0) })
        sections = vm.getItems()
        tableView.estimatedRowHeight = 120
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
        case .header, .image:
            return 1
        case .car(let model):
            return model.count
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
            case .car(let models):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarCell else { return UITableViewCell() }
                cell.configure(car: models[indexPath.row], selected: indexPath == selectedIndexPath)
                return cell
        }
    }
}


// MARK : TableView Delegate Methods
extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .header:
            return 45
        case .image:
            return 250
        default:
            return UITableView.automaticDimension
        }
    }
}


