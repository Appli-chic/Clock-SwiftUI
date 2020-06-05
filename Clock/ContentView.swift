//
//  ContentView.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WorldClockScreen()
                .tabItem {
                    Image(systemName: "globe").imageScale(.large)
                    Text("World Clock")
            }
            
            AlarmScreen()
                .tabItem {
                    Image(systemName: "alarm.fill").imageScale(.large)
                    Text("Alarm")
            }
            
            Text("The content of the third view")
                .tabItem {
                    Image(systemName: "bed.double.fill").imageScale(.large)
                    Text("Bedtime")
            }
            
            Text("The content of the Fourth view")
                .tabItem {
                    Image(systemName: "stopwatch.fill").imageScale(.large)
                    Text("Stopwatch")
            }
            
            Text("The content of the Fifth view")
                .tabItem {
                    Image(systemName: "timer").imageScale(.large)
                    Text("Timer")
            }
        }.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
