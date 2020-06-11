//
//  Clouds.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct Clouds {
  let all: Int
  
  init(all: Int) {
    self.all = all
  }
}

extension Clouds: JSONDecodable {
  init?(JSON: Any) {
    guard let JSON = JSON as? [String: AnyObject] else { return nil }
    guard let all = JSON["all"] as? Int else { return nil }
    
    self.all = all
  }
}

