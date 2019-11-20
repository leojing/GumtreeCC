//
//  ViewController.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var weatherDetailView: WeatherDetailView!

    var viewModel: WeatherViewModel!

    // MARK: override funcations
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configViewModel()
    }

    // MARK: Setup UI
    private func setupUI() {
        title = "Nav.Title.AccountDetails".localizedValue()
        setupTableView()
        setupSearchBar()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchDetailTableViewCell.nib(), forCellReuseIdentifier: SearchDetailTableViewCell.reuseId())
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    // MARK: Config View Model
    private func configViewModel() {
        viewModel = WeatherViewModel(APIManager())
        viewModel.updatedUI = { [weak self] weatherDetail, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(nil, error.errorDescription)
            }
            if let weatherDetail = weatherDetail {
                DispatchQueue.main.async {
                    self.weatherDetailView.isHidden = false
                    self.weatherDetailView.configureViewWithViewObject(weatherDetail)
                }
            }
        }
    }

    // MARK: IBAction func
    @IBAction func gpsTapped(_ sender: UIButton) {
        viewModel.queryWeatherDetailByGPS()
    }

    @IBAction func tapToHidden(_ sender: UITapGestureRecognizer) {
        tableView.isHidden = true
    }
}

// MARK: - Conform to UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let searchText = viewModel.getCellModelForIndex(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewCell.reuseId(), for: indexPath) as? SearchDetailTableViewCell {
            cell.index = indexPath
            cell.configureCell(searchText) { [weak self] index in
                guard let self = self else { return }
                self.viewModel.deleteCellModelFromHistory(at: index)
                tableView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Conform to UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let searchText = viewModel.getCellModelForIndex(at: indexPath) {
            tableView.isHidden = true
            searchBar.text = searchText
            viewModel.queryWeatherDetailsByText(searchText)
            // Here is for make the selected string always on the top of the search history
            viewModel.deleteCellModelFromHistory(at: indexPath)
            viewModel.addCellModelToHistory(searchText)
        }
    }
}

// MARK: - Conform to UISearchBarDelegate
extension WeatherViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        #warning("TODO - Improvement: Here can introduce RxSwift debounce() to make sure not reload tableview for each change, as sometimes the searchText is meaningless and make reload is a waste")
        tableView.isHidden = viewModel.numberOfRows() == 0
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        guard let text = searchBar.text else {
            return
        }
        viewModel.addCellModelToHistory(text)
        viewModel.queryWeatherDetailsByText(text)
    }
}
