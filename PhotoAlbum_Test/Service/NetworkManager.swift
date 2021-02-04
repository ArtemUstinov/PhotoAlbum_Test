//
//  NetworkManager.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 02.02.2021.
//

import Foundation

class NetworkManager {
    
    private enum ApiUrl: String {
        case users = "https://jsonplaceholder.typicode.com/users"
        case albums = "https://jsonplaceholder.typicode.com/albums"
        case photos = "https://jsonplaceholder.typicode.com/photos"
    }
    
    func fetchDataUser(completion: @escaping(Result<[User]?,
                                                    Error>) -> Void) {
        
        guard let url = URL(string: ApiUrl.users.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let userData = try JSONDecoder().decode([User].self,
                                                        from: data)
                DispatchQueue.main.async {
                    completion(.success(userData))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchDataAlbum(completion: @escaping([Album]?) -> Void) {
        
        guard let url = URL(string: ApiUrl.albums.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let albumData = try JSONDecoder().decode([Album].self,
                                                         from: data)
                DispatchQueue.main.async {
                    completion(albumData)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchDataPhoto(completion: @escaping([Photo]?) -> Void) {
        
        guard let url = URL(string: ApiUrl.photos.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let albumData = try JSONDecoder().decode([Photo].self,
                                                         from: data)
                DispatchQueue.main.async {
                    completion(albumData)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImageData(
        from url: URL,
        completion: @escaping(Data, URLResponse) -> Void
    ) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                  let response = response else {
                print(error?.localizedDescription ?? "Unknown error")
                return }
            completion(data, response)
        }.resume()
    }
}
