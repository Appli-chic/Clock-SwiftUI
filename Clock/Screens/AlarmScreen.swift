//
//  AlarmScreen.swift
//  Clock
//
//  Created by Lazyos on 6/5/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct AlarmScreen: View {
    @State private var alarms: [AlarmModel] = []
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "bed.double.fill").resizable()
                        .scaledToFit().foregroundColor(.gray).padding(.leading, 20.0).frame(width: 32.0, height: 12.0)
                    
                    Text("BEDTIME").foregroundColor(.gray).font(.system(size: 12))
                }
                
                AlarmItem(alarm: alarms[0])
                    .padding(.horizontal, 20.0)
                
                Text("OTHER ALARMS").foregroundColor(.gray).font(.system(size: 12)).padding([.top, .leading], 20.0)
                List() {
                    ForEach(alarms, id: \.self) { alarm in
                        AlarmItem(alarm: alarm)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: deleteItems)
                }
            }.onAppear() {
                let preferences = UserDefaults.standard
                self.alarms.append(AlarmModel(id: 0, hour: 8, minute: 10, repeatString: "", label: "label", sound: "sound", snooze: false, isActive: true))
                //                    let data = preferences.object(forKey: CLOCK_PREFERENCE_KEY)
                //                    let dataArray = try! JSONDecoder().decode([ClockModel].self, from: data! as! Data)
                //                    self.clockListSelected = dataArray
            }.environment(\.editMode, $editMode)
            .navigationBarTitle("Alarm")
            .navigationBarItems(leading:
                Button("Edit") {
                    if self.editMode == .active {
                        self.editMode = .inactive
                    } else {
                        self.editMode = .active
                    }
                }.foregroundColor(.orange),
                                trailing:
                NavigationLink(destination: AddClockScreen()) {
                    Image(systemName: "plus").imageScale(.large)
                }.foregroundColor(.orange)
            )
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        alarms.remove(atOffsets: offsets)
        //        saveClockListInPref()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        alarms.move(fromOffsets: source, toOffset: destination)
        //        saveClockListInPref()
    }
    
    func saveAlarmListInPref() {
        //        let preferences = UserDefaults.standard
        //               let clocksData = try! JSONEncoder().encode(clockListSelected)
        //               preferences.set(clocksData, forKey: CLOCK_PREFERENCE_KEY)
    }
}

struct AlarmScreen_Previews: PreviewProvider {
    static var previews: some View {
        AlarmScreen().environment(\.colorScheme, .dark)
    }
}
