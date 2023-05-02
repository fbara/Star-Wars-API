//
//  NetworkController.swift
//  Star Wars API
//
//  Created by Frank Bara on 5/2/23.
//

import Combine
import Foundation

class NetworkController: ObservableObject {
    @Published private(set) var person = Person(name: "", films: [String]())
    private var cancellables = Set<AnyCancellable>()
    
    let url = URL(string: "https://swapi.dev/api/people/1")
    
    func fetchPerson() {
        guard let url = url else { return  }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Person.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] personObject in
                guard let self = self else { return }
                person = personObject
            }
            .store(in: &cancellables)
        
    }
}
