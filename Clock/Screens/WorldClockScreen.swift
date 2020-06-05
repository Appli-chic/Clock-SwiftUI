//
//  WorldClockScreen.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct WorldClockScreen: View {
    @State private var clockListSelected: [ClockModel] = []
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(clockListSelected, id: \.self) { clock in
                    WorldClockItem(clock: clock, isEditing: self.editMode == .active)
                }
                .onMove(perform: move)
                .onDelete(perform: deleteItems)
            }
            .environment(\.editMode, $editMode)
            .navigationBarTitle("World Clock")
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
                .onAppear() {
                    let preferences = UserDefaults.standard
                    let data = preferences.object(forKey: CLOCK_PREFERENCE_KEY)
                    
                    if data != nil {
                        let dataArray = try! JSONDecoder().decode([ClockModel].self, from: data! as! Data)
                        self.clockListSelected = dataArray
                    }
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        clockListSelected.remove(atOffsets: offsets)
        saveClockListInPref()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        clockListSelected.move(fromOffsets: source, toOffset: destination)
        saveClockListInPref()
    }
    
    func saveClockListInPref() {
        let preferences = UserDefaults.standard
        let clocksData = try! JSONEncoder().encode(clockListSelected)
        preferences.set(clocksData, forKey: CLOCK_PREFERENCE_KEY)
    }
}

struct WorldClockScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockScreen().environment(\.colorScheme, .dark)
    }
}
