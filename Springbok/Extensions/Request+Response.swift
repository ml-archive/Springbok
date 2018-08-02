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
            
            self.decode(data, completion: completion)
        }
        
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
    
    private func decode<T: Codable>(_ data: Data, completion: @escaping ((Result<T>) -> Void)) {
        if unwrapper == nil {
            decodeData(data, completion: completion)
        } else {
            unwrapAndDecode(data, completion: completion)
        }
    }
    
    private func decodeData<T: Codable>(_ data: Data, completion: @escaping ((Result<T>) -> Void)) {
        do {
            let decoded: T = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async { completion(.success(decoded)) }
            
            return
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
            
            return
        }
    }

    private func unwrapAndDecode<T: Codable>(_ data: Data, completion: @escaping ((Result<T>) -> Void)) {
        do {
            guard
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let unwrapped = unwrapper,
                let array = json[unwrapped],
                let arrayToString = jsonToString(from: array),
                let encodedData = arrayToString.data(using: .utf8)
            else {
                DispatchQueue.main.async { completion(.failure(SBError.failedToUnwrap)) }
                
                return
            }
            
            decodeData(encodedData, completion: completion)
            
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
            
            return
        }
    }
    
    func jsonToString(from object: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}
