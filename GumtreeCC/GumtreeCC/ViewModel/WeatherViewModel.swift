//
//  WeatherViewModel.swift
//  GumtreeCC
//
//  Created by Jing LUO on 19/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation
import MapKit

class WeatherViewModel {

    var updatedUI: ((_ weatherDetail: WeatherDetailViewObject?, _ error: RequestError?) -> Void)?
    private var apiService: APIService!
    private var searchHistory = [String]()
    private var locManager = CLLocationManager()
    private var currentLocation: CLLocation!
    init(_ apiService: APIService) {
        self.apiService = apiService
    }

    func queryWeatherDetailByGPS() {
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                self.updatedUI?(nil, RequestError("Can't get your current location."))
                return
            }
            fetchWeatherBy(WeatherByType.gps((currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)))
        }
    }

    func queryWeatherDetailsByText(_ text: String?) {
        guard let text = text else {
            self.updatedUI?(nil, RequestError("No search text entered."))
            return
        }
        let type = text.doStringContainsNumber() ? WeatherByType.zipcode(text) : WeatherByType.name(text)
        fetchWeatherBy(type)
    }

    private func fetchWeatherBy(_ type: WeatherByType) {
        apiService.fetchWeatherDetail(EndPoint.weather(type)) { [weak self] status in
            guard let self = self else { return }
            guard let status = status else {
                return
            }
            switch status {
            case .success(let weather):
                if let weather = weather as? Weather {
                    self.updatedUI?(self.getWeatherDetailViewObject(weather), nil)
                } else {
                    self.updatedUI?(nil, RequestError("No weather data"))
                }

            case .fail(let error):
                self.updatedUI?(nil, RequestError(error.errorDescription ?? "Unknown Error"))
            }
        }
    }
}

extension WeatherViewModel {
    func getWeatherDetailViewObject(_ weather: Weather) -> WeatherDetailViewObject {
        var viewObject = WeatherDetailViewObject()
        viewObject.nameText = weather.name
        viewObject.descriptionText = weather.weatherDetails.first?.description ?? "No description"
        viewObject.tempText = "\(weather.temp) ºF"
        viewObject.iconImage = URL(string: "http://openweathermap.org/img/w/\(weather.weatherDetails.first?.icon ?? "").png")
        return viewObject
    }
}

extension WeatherViewModel {
    func numberOfRows() -> Int {
        return searchHistory.count
    }

    func getCellModelForIndex(at index: IndexPath) -> String? {
        return searchHistory[index.row]
    }

    func deleteCellModelFromHistory(at index: IndexPath) {
        searchHistory.remove(at: index.row)
    }

    func addCellModelToHistory(_ searchText: String) {
        if !searchHistory.contains(searchText) {
            // Add the text to the top of the array, so it can be seen by user at first
            searchHistory.insert(searchText, at: 0)
        }
    }
}
