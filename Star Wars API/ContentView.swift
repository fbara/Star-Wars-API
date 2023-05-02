//
//  ContentView.swift
//  Star Wars API
//
//  Created by Frank Bara on 5/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = NetworkController()
    
    var body: some View {
        VStack {
        
            Text("Hello, \(controller.person.name)!")
        }
        .onAppear {
            controller.fetchPerson()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
