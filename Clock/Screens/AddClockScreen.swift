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
        VStack {
            SearchBar(text: self.$searchText)
            List() {
                ForEach(self.alphabet, id: \.self) { letter in
                    Section(header: Text(letter)) {
                        ForEach(self.clockList.filter{ $0.city.prefix(1) == letter }) { clock in
                            Text("\(clock.city), \(clock.country)").onTapGesture {
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Choose a city", displayMode: .inline)
        }
        .padding(.top)
    }
}

struct AddClockScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddClockScreen().environment(\.colorScheme, .dark)
    }
}
