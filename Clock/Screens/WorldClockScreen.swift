//
//  WorldClockScreen.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct WorldClockScreen: View {
    var body: some View {
        NavigationView {
            List(clocks) { clock in
                WorldClockItem(clock: clock)
            }
            .navigationBarTitle("World Clock")
            .navigationBarItems(leading:
                Button("Edit") {
                    print("Edit tapped!")
                }.foregroundColor(.orange),
                                trailing:
                Button(action: {
                    print("Plus icon pressed...")
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }.foregroundColor(.orange)
            )
        }
    }
}

struct WorldClockScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockScreen().environment(\.colorScheme, .dark)
    }
}
