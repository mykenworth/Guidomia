//
//  CarsViewController.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation
import UIKit

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var sections: [SectionType] = []
    
    // default selected per requirement (1st car item)
    private var selectedIndexPath = IndexPath(row: 0, section: 3)
    
    private var viewModel = CarsViewModel(databaseService: DatabaseService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ["HeaderCell", "FilterCell", "ImageCell", "CarCell"].forEach({ tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0) })
        
        // load the tableView dataSource
        sections = viewModel.getUnfilteredSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: TableView DataSource Methods
extension CarsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .header, .image, .filter:
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
        case .filter:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return UITableViewCell() }
            cell.configureFilter(with: viewModel.getFilters(type: .make), models: viewModel.getFilters(type: .model))
            cell.delegate = self
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

// MARK: TableView Delegate Methods
extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.tableView.reloadSections(IndexSet(integer: selectedIndexPath.section), with: .automatic)
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

// MARK: FilterCellDelegate Methods
extension CarsViewController: FilterCellDelegate {
    func didSearch(filter: FilterItem) {
        self.sections = viewModel.getFilteredSections(filter: filter)
        self.tableView.reloadSections(IndexSet(integer: selectedIndexPath.section), with: .automatic)
    }
}


