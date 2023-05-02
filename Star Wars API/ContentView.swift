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
        VStack(alignment: .leading) {
        
            Text("Hello, \(controller.person.name)!")
            
            Text(controller.film.title)
                .padding(.top)
            Text(controller.film.releaseDate)
            
            Text(controller.film.openingCrawl)
                .padding(.top)
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
