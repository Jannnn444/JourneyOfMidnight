//
//  NetworkManager.swift
//  PawerfurNoteApp
//
//  Created by Janus on 2025/2/1.
//

import Foundation

// Custom error types to handle various scenarios
enum NetworkError: Error {
    case urlError
    case decodingError(String)
    case serverError(String)
    case unknownError
}

// API Error
struct ApiError: Decodable, Error {
    let statusCode: Int
    let message: String
    let error: String
}

class NetworkManager {
    // instantiate singleton instance
    static var shared = NetworkManager()
    
    // MARK: - GET REQUEST HELPER
    func getRequest<T: Decodable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        // convert url endpoint to URL object

        guard let urlObject = URL(string: "http://\(apiDomain):\(url)") else {
            completion(.failure(NetworkError.urlError))
            return
        }
        // http://206.189.40.30/api/notes
        // http://206.189.40.30:4040/api/product
        print("DECODE Url: \(urlObject)")
        
        // start data task for GET request with URL object
        let task = URLSession.shared.dataTask(with: urlObject) { data, response, error in
            if let error = error {
                print("DEBUG: Error occured during GET request.")
                completion(.failure(error))
                return
            }
            // check for valid data
            guard let data = data else {
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            // MARK: JsonData DEBUG Print
                do {
                    // attempt to decode the data
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    
                    print("decodedDataJsonData1 : \(decodedData)")
                    
                    DispatchQueue.main.async {
                        print("decodedDataJsonData2 : \(decodedData)")
                        // return data after asynchronous operation
                        completion(.success(decodedData))
                        print("decodedDataJsonData3 : \(decodedData)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.decodingError(error.localizedDescription)))
                    }
                }
        }
        // initiate async request
        task.resume()
        
    }
    
    
    // MARK: - POST REQUEST HELPER
    func postRequest<T: Encodable, U: Decodable>(url: String, payload: T, completion: @escaping (Result<U, Error>) -> Void) {
        
        // T is dynamic type, product type, title: string and price: float(decimal)
        // guard against any unaccepted url strings and create URL object
        guard let urlObj = URL(string: "http://\(apiDomain):\(url)") else {
            completion(.failure(NetworkError.urlError))
            return
        }
        print("DECODE Url: \(urlObj)")
        
        // create a URLRequest object
        var request = URLRequest(url: urlObj)
        
        // set http method to POST
        request.httpMethod = "POST"
        
        // set Content-Type headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // attempt to encode JSON
        do {
            let jsonData = try JSONEncoder().encode(payload)
            print("[postRequest helper] encoded jsonData: \(jsonData)")
            request.httpBody = jsonData // set body of request with json data
            
        } catch {
            print("DEBUG error when encoding: \(error)")
            completion(.failure(error))
            return
        }
        
        // make post request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            // check for errors
            if let error = error  {
                print("DEBUG error when making request: \(error)")
                completion(.failure(error))
                return
            }
            
            // attempt to unwrap data, guarding against nil data
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was nil."])))
                return
            }
            
            // use the http status code to determine whether or not completion was a success
            switch httpResponse.statusCode {
            case 200, 201:
                // do-catch in attempt to decode data
                do {
                    let responseData = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(NetworkError.decodingError("Error decoding successful response")))
                }
            default:
                do {
                    let errorData = try JSONDecoder().decode(ApiError.self, from: data)
                    completion(.failure(NetworkError.serverError(errorData.message)))
                } catch {
                    completion(.failure(NetworkError.decodingError("Error decoding error response")))
                }
            }
        }
        
        // initialize task
        task.resume()
    }
    
    // MARK: DELETE REQUEST HELPER
    func deleteRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        print("Delete request with: \(url)")
        
        // guard against any unaccepted url strings and create URL object
        guard let url = URL(string: "http://\(apiDomain):3000\(url)") else { return }
        
        // create a URLRequest object
        var request = URLRequest(url: url)
        
        // set http method to POST
        request.httpMethod = "DELETE"
        
        // set Content-Type headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // make post request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for errors
            if let error = error  {
                completion(.failure(error))
                return
            }
            // check for any data response
            if let data = data {
                completion(.success(data))
            }
        }
        
        // initialize task
        task.resume()
        
    }
}
