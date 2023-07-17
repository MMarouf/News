//
//  FilterViewController.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit

private enum Constants {
    static let filterAccessibilityIdentifier = "FilterView"
    static let selectCategory = "SELECT CATEGORY"
    static let selectCountry = "SELECT COUNTRY"
}

protocol FilterDelegate: AnyObject {
    func updateFilterInformation (category: Category, country: Country)
}

private enum Section: Int, CaseIterable {
    case category, country
}

final class FilterViewController: UIViewController {
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    private let filterViewModel = FilterViewModel()
    weak var  delegate: FilterDelegate?

    override func viewDidLoad() {
        self.view.accessibilityIdentifier = Constants.filterAccessibilityIdentifier
        filterTable.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.resueIdentifier)
        filterViewModel.fetchDataList()
    }
    @IBAction func selectFilterItems () {
        delegate?.updateFilterInformation(category: filterViewModel.getSelectedCategory(), country: filterViewModel.getSelectedCountry())
        self.dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section) == .category ? filterViewModel.categoryList.count: filterViewModel.countryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTable.dequeueReusableCell(withIdentifier: UITableViewCell.resueIdentifier, for: indexPath)
        let row = indexPath.row
        let section = Section(rawValue: indexPath.section)
        cell.textLabel?.text  = ( section == .category ) ? filterViewModel.categoryList[row].name: filterViewModel.countryList[row].name
        switch section {
        case .category:
            cell.accessoryType =  ( filterViewModel.selectedCategoryIndex == row ) ? .checkmark: .none

        case .country:
            cell.accessoryType =  ( filterViewModel.selectedCountryIndex == row ) ? .checkmark: .none

        default: break
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section) == .category ? Constants.selectCategory: Constants.selectCountry
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .category:
            filterViewModel.selectedCategoryIndex = indexPath.row

        case .country:
            filterViewModel.selectedCountryIndex = indexPath.row

        default:
            break
        }
        filterTable.reloadData()
    }
}
