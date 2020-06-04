//
//  SearchBar.swift
//  Clock
//
//  Created by Lazyos on 6/3/20.
//  Copyright © 2020 Applichic. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 4.0)
                TextField("Search", text: $text, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                Image(systemName: "mic.fill")
                    .padding(.trailing, 8.0)
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            Button(action: {
                self.text = ""
            }) {
                Text("Cancel")
            }
            .foregroundColor(.orange)
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("")).environment(\.colorScheme, .dark)
    }
}
