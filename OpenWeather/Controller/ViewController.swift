//
//  ViewController.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/10/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var cloudsLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  var cityName: String = "Da Nang"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    loadData(city: "DaNang")
    
    let viewIsTap = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
    view.addGestureRecognizer(viewIsTap)
    self.cityTextField.delegate = self
  }
  
  @objc func viewIsTapped() {
    view.endEditing(true)
  }
  
  func loadData(city: String) {
    
    let datamanager = DataManager(baseURL: API.AuthenticatedBaseURL)
    datamanager.weatherDataForLocation(city: city) { (response, error) in
      if let _ = error {
        DispatchQueue.main.async {
          self.showMessage(error: error!)
        }
      }
      else if let weatherData = WeatherData(JSON: response!) {
        print(response!)
        DispatchQueue.main.async {
          self.cityLabel.text = self.cityName
          self.tempLabel.text = String(Int(weatherData.main.temp) - 273)
          self.descriptionLabel.text = String(weatherData.weather[0].description)
          self.windLabel.text = String(weatherData.wind.speed)
          self.cloudsLabel.text = String(weatherData.clouds.all)
          self.humidityLabel.text = String(weatherData.main.humidity)
          self.iconImageView.image = UIImage(named: weatherData.weather[0].icon)
        }
      }
    }
  }
  
  func showMessage(error: DataManagerError) {
    switch error {
    case .InvalidResponse:
      showAlert(message: "Invalid Response")
    case .FailedRequest:
      showAlert(message: "Failed Request")
    case .CityNotFound:
      showAlert(message: "City Not Found")
    default:
      showAlert(message: "Unknown Error")
    }
  }
  
  func showAlert(message: String) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func fetchData(with city: String) {
    cityName = city
    var city = city
    while city.contains(" ") {
      city.removeAll { (char) -> Bool in
        char == " "
      }
    }
    loadData(city: city)
    cityTextField.text = ""
  }
  
  @IBAction func okTapped(_ sender: Any) {
    let city = cityTextField.text!
    fetchData(with: city)
    view.endEditing(true)
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let city = cityTextField.text!
    fetchData(with: city)
    self.view.endEditing(true)
    return false
  }
}
