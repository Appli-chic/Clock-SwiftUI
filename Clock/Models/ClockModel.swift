//
//  Clock.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

struct ClockModel: Hashable, Codable, Identifiable {
    var id: Int
    var city: String
    var country: String
    var timeZone: String
    
    init(id: Int, city: String, country: String, timeZone: String) {
        self.id = id
        self.city = city
        self.country = country
        self.timeZone = timeZone
    }
}

