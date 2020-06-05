//
//  AlarmModel.swift
//  Clock
//
//  Created by Lazyos on 6/5/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

struct AlarmModel: Hashable, Codable, Identifiable {
    var id: Int
    var hour: Int
    var minute: Int
    var repeatString: String
    var label: String
    var sound: String
    var snooze: Bool
    var isActive: Bool
    
    init(id: Int, hour: Int, minute: Int, repeatString: String, label: String, sound: String, snooze: Bool, isActive: Bool) {
        self.id = id
        self.hour = hour
        self.minute = minute
        self.repeatString = repeatString
        self.label = label
        self.sound = sound
        self.snooze = snooze
        self.isActive = isActive
    }
}
