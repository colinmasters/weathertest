//
//  WeatherSearchViewController.swift
//  WeatherSearch
//
//  Created by Colin Masters on 02/03/2019.
//  Copyright © 2019 Colin Masters. All rights reserved.
//

import UIKit

class WeatherSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherTableView: UITableView!
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private var weatherSearchService: WeatherSearchService?
    private var isSearching = false
    private var forecast: Forecast?
    private var forecaseList: [Overview] = [Overview]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.isHidden = true
        weatherSearchService = WeatherSearchService(delegate: self)
        activityIndicator.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        view.addSubview(activityIndicator)
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.weatherTableView.isHidden = strongSelf.isSearching
            strongSelf.activityIndicator.isHidden = !strongSelf.isSearching
            strongSelf.isSearching ? self?.activityIndicator.startAnimating() : self?.activityIndicator.startAnimating()
            strongSelf.weatherTableView.reloadData()
        }
        isSearching = !isSearching
    }
}

extension WeatherSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell
        if let forecast = forecast, let cityName = forecast.city.name {
            headerCell?.cityNameLabel.text = cityName
        }
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecaseList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? OverviewCell {
            let overview = forecaseList[indexPath.row]
            cell.configure(with: overview)
            return cell
        }
        return UITableViewCell()
    }
}

extension WeatherSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            DispatchQueue.main.async { [weak self] in
                self?.weatherTableView.isHidden = true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        updateView()
        weatherSearchService?.dailyForecast(searchCity: city, searchCountry: "CA", tempUnit: .metric, count: 16)
    }
}

extension WeatherSearchViewController: WeatherForecastDelegate {
    func searchCompleted(with forecast: Forecast) {
        if let list = forecast.list {
            self.forecast = forecast
            forecaseList = list
        }
        updateView()
    }
    
    func requestFailed(with error: Error) {
        updateView()
    }
}
