//
//  WeatherSearchService.swift
//  WeatherSearch
//
//  Created by Colin Masters on 02/04/2019.
//  Copyright © 2019 Colin Masters. All rights reserved.
//

enum TempUnit: String {
    case metric = "metric"
}

import Foundation

protocol WeatherSearchServiceDelegate: class {
    func requestFailed(with error: Error)
}

protocol WeatherForecastDelegate: WeatherSearchServiceDelegate {
    func searchCompleted(with forecast: Forecast)
}

final class WeatherSearchService {
    
    private weak var delegate: WeatherSearchServiceDelegate?
    private let client = APIClient()
    
    init(delegate: WeatherSearchServiceDelegate) {
        self.delegate = delegate
    }
    
    func dailyForecast(searchCity: String, searchCountry: String, tempUnit: TempUnit, count: Int) {
        let request = APIRequest(method: .get, path: "forecast")
        
        request.queryItems = [
            URLQueryItem(name: "q", value: "\(searchCity),\(searchCountry)"),
            URLQueryItem(name: "units", value: tempUnit.rawValue),
        ]
        
        request.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
        
        APIClient().request(request) { [weak self] (response, data, error) in
            guard error == nil else {
                self?.delegate?.requestFailed(with: error!)
                return
            }
            
            if let data = data, error == nil {
                if let weatherForecast = try? JSONDecoder().decode(Forecast.self, from: data), let delegate = self?.delegate as? WeatherForecastDelegate {
                    delegate.searchCompleted(with: weatherForecast)
                }
            } else {
                self?.delegate?.requestFailed(with: APIError.requestFailed)
            }
        }
        
    }
}
