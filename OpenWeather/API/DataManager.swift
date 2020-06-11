//
//  DataManager.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

enum DataManagerError: Error {
  case Unknown
  case FailedRequest
  case InvalidResponse
  case CityNotFound
}

class DataManager {
  
  typealias WeatherDataCompletion = (AnyObject?, DataManagerError?) -> ()
  
  let baseURL: URL
  
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  func weatherDataForLocation(city: String, completion: @escaping WeatherDataCompletion) {
    
    let url = URL(string: "\(baseURL)&q=\(city)")!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
    }.resume()
  }
  
  private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping WeatherDataCompletion) {
    if let _ = error {
      completion(nil, .FailedRequest)
    }
    else if let data = data, let response = response as? HTTPURLResponse {
      if response.statusCode == 200 {
        processWeatherData(data: data, completion: completion)
      }
      else if response.statusCode == 404 {
        completion(nil, .CityNotFound)
      }
      else {
        completion(nil, .InvalidResponse)
      }
    }
    else {
      completion(nil, .Unknown)
    }
  }
  
  private func processWeatherData(data: Data, completion: @escaping WeatherDataCompletion) {
    if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
      completion(JSON, nil)
    }
    else {
      completion(nil, .InvalidResponse)
    }
  }
}

struct API {
  static let BaseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
  static let APIKey = "0e0877237e3aa921319e1e984c87f89d"
  
  static var AuthenticatedBaseURL: URL {
    return URL(string: "\(BaseURL)?APPID=\(APIKey)")!
  }
}
