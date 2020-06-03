//
//  AddClockScreen.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct AddClockScreen: View {
    @State private var clockList = clocks
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: self.$searchText)
                List() {
                    ForEach(clockList, id: \.self) { clock in
                        WorldClockItem(clock: clock, isEditing: false)
                    }
                }
            }
            .navigationBarTitle("Choose a city", displayMode: .inline)
        }
    }
}

struct AddClockScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddClockScreen().environment(\.colorScheme, .dark)
    }
}
