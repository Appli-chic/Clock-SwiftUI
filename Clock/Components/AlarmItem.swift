//
//  AlarmItem.swift
//  Clock
//
//  Created by Lazyos on 6/5/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct AlarmItem: View {
    var alarm: AlarmModel
    @State var showFavoritesOnly = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(displayTimeParameter(param: alarm.hour)):\(displayTimeParameter(param:alarm.minute))").font(.system(size: 45)).foregroundColor(.gray)
                Text(alarm.repeatString).foregroundColor(.gray)
            }
            Spacer()
            Toggle("", isOn: $showFavoritesOnly)
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
    }
    
    func displayTimeParameter(param: Int) -> String {
        if param < 10 {
            return "0\(param)"
        } else {
            return "\(param)"
        }
    }
}

struct AlarmItem_Previews: PreviewProvider {
    static var previews: some View {
        AlarmItem(alarm: AlarmModel(id: 0, hour: 8, minute: 5, repeatString: "Every day", label: "label", sound: "sound", snooze: false, isActive: true))
            .environment(\.colorScheme, .dark)
    }
}
