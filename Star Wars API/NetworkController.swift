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
    @Published private(set) var film = Film(title: String(), openingCrawl: String(), releaseDate: String())
    private var cancellables = Set<AnyCancellable>()
    private var cancellableFilms = Set<AnyCancellable>()
    
    let url = URL(string: "https://swapi.dev/api/people/3")
    
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
                fetchFilm(url: URL(string: person.films[0])!)
            }
            .store(in: &cancellables)
        
    }
    
    func fetchFilm(url: URL)  {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Film.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] filmObject in
                guard let self = self else { return }
                film = filmObject
            }
            .store(in: &cancellableFilms)
                
    }
}
