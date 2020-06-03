//
//  WorldClockItem.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct WorldClockItem: View {
    var clock: ClockModel
    var isEditing: Bool
    
    var timer = Timer.publish(every: 0.2, on: .current, in: .common).autoconnect()
    @State var time: String = ""
    @State var day: String = "Today"
    @State var hourDiff: String = "+0"
    
    init(clock: ClockModel, isEditing: Bool) {
        self.clock = clock
        self.isEditing = isEditing
        
        _ = getCityDate()
        updateDay()
        updateHourDiff()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(day) , \(hourDiff)HRS").font(.caption).foregroundColor(.gray).onReceive(timer) { input in
                        self.updateDay()
                        self.updateHourDiff()
                    }
                    Text("\(clock.city)").font(.title)
                }
                Spacer()
                if !isEditing {
                    Text("\(time)").font(.system(size: 45))
                        .onReceive(timer) { input in
                            _ = self.getCityDate()
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .padding(.vertical)
    }
    
    func getCityDate() -> Date {
        let cityDate = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone.init(abbreviation: clock.timeZone)!
        format.dateFormat = "HH:mm"
        self.time = format.string(from: cityDate)
        return cityDate
    }
    
    func getCityCal() -> Calendar {
        var cityCal = Calendar.current
        cityCal.timeZone = TimeZone.init(abbreviation: clock.timeZone)!
        return cityCal
    }
    
    func updateDay() {
        let currentDate = Date()
        let cityDate = getCityDate()
        let todayCal = Calendar.current
        let cityCal = getCityCal()
        
        if cityCal.component(.day, from: cityDate) == todayCal.component(.day, from: currentDate) {
            self.day = "Today"
        } else if cityCal.component(.day, from: cityDate) + 1 == todayCal.component(.day, from: currentDate) {
            self.day = "Tomorrow"
        } else {
            self.day = "Yesterday"
        }
    }
    
    func updateHourDiff() {
        let currentDate = Date()
        let cityDate = getCityDate()
        let todayCal = Calendar.current
        let cityCal = getCityCal()
        
        let todayHour = todayCal.component(.hour, from: currentDate)
        let cityHour = cityCal.component(.hour, from: cityDate)
        let hourDiff = cityHour - todayHour
        
        if hourDiff >= 0 {
            self.hourDiff = "+\(hourDiff)"
        } else {
            self.hourDiff = "\(hourDiff)"
        }
    }
}

struct WorldClockItem_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockItem(clock: ClockModel(id: 0, city: "New York", country: "USA", timeZone: "GMT-4"),isEditing: true)
    }
}
