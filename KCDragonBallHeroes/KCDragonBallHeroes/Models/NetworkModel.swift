//
//  NetworkModel.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/20/24.
//

import Foundation

final class NetworkModel{
    
    // Singleton NetworkModel
    static let shared = NetworkModel()
    
    private var token: String? {
        get {
            if let token = LocalDataModel.getToken(){
                return token
            }
            return nil
        }
        set {
            if let token = newValue {
                LocalDataModel.save(token:token)
            }
        }
    }
    
    private var baseComponents: URLComponents{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    
    // Private to avoid that this class be call from outside
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func login(
        user:String,
        password: String,
        completion: @escaping (Result <String, DragonBallError>) -> Void
    ){
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user,password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.encodingFailed))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        client.jwt(urlRequest){ [weak self]
            result in
            switch result {
                case let .success(token):
                    self?.token = token
                    completion(.success(token))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    func getHeroes(
        completion: @escaping (Result<[DragonBallHero], DragonBallError>) -> Void
    ){
        var components = baseComponents
        components.path = "/api/heros/all"

        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let token else {
            completion(.failure(.errorToken))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:"name", value:"")]
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        client.request(urlRequest,using: [DragonBallHero].self, completion: completion)
        
    }
    
    func getTransformations(
        id: String,
        completion: @escaping (Result<[HeroTransformation], DragonBallError>) -> Void
    ){
        var components = baseComponents
        components.path = "/api/heros/tranformations"

        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let token else {
            completion(.failure(.errorToken))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:"id", value:id)]
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        client.request(urlRequest,using: [HeroTransformation].self, completion: completion)
        
    }
}

