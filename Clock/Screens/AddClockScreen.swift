//
//  AddClockScreen.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct AddClockScreen: View {
    private var alphabet = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @State private var clockList = clocks
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentation
    
    init() {
        self.clockList = self.clockList.sorted { (clock1, clock2) -> Bool in
            let channelName1 = clock1.city
            let channelName2 = clock2.city
            return (channelName1.localizedCaseInsensitiveCompare(channelName2) == .orderedAscending)
        }
    }
    
    var body: some View {
        let searchBinding = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            self.onSearchChanging()
        })
        
        return VStack {
            SearchBar(text: searchBinding)
            ZStack {
                List() {
                    ForEach(self.alphabet, id: \.self) { letter in
                        Section(header: Text(letter)) {
                            ForEach(self.clockList.filter{ $0.city.prefix(1) == letter }) { clock in
                                Text("\(clock.city), \(clock.country)").onTapGesture {
                                    let preferences = UserDefaults.standard
                                    
                                    if preferences.object(forKey: CLOCK_PREFERENCE_KEY) == nil {
                                        //  Create a new list
                                        var data: [ClockModel] = []
                                        data.append(clock)
                                        let clocksData = try! JSONEncoder().encode(data)
                                        preferences.set(clocksData, forKey: CLOCK_PREFERENCE_KEY)
                                    } else {
                                        // Add to the existent list
                                        let data = preferences.object(forKey: CLOCK_PREFERENCE_KEY)
                                        var dataArray = try! JSONDecoder().decode([ClockModel].self, from: data! as! Data)
                                        
                                        if !dataArray.contains(clock) {
                                            dataArray.append(clock)
                                        }
                                        
                                        let clocksData = try! JSONEncoder().encode(dataArray)
                                        preferences.set(clocksData, forKey: CLOCK_PREFERENCE_KEY)
                                    }
                                    
                                    self.presentation.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Choose a city", displayMode: .inline)
                
                HStack {
                    Spacer()
                    VStack {
                        ForEach(self.alphabet, id: \.self) { letter in
                            Text(letter).foregroundColor(.orange).font(.system(size: 13))
                        }
                    }
                }
            }
        }
        .padding(.top)
    }
    
    func onSearchChanging() {
        if searchText.isEmpty {
            self.clockList = clocks
        } else {
            self.clockList = clocks.filter{ $0.city.contains(searchText) || $0.country.contains(searchText) }
        }
    }
}

struct AddClockScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddClockScreen().environment(\.colorScheme, .dark)
    }
}
