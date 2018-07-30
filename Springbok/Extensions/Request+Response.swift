//
//  Request+Response.swift
//  Springbok
//
//  Created by Maxime Maheo on 30/07/2018.
//  Copyright © 2018 Nodes. All rights reserved.
//

extension Request {
    
    public func responseCodable<T: Codable>(completion: @escaping ((Result<T>) -> Void)) {
        guard let request = request else {
            DispatchQueue.main.async { completion(.failure(SBError.invalidRequest)) }
            
            return
        }
        
        let task = SessionManager.default.session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(SBError.emptyData)) }
                
                return
            }
            
            do {
                let decoded: T = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
                
                return
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
                
                return
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }

}
