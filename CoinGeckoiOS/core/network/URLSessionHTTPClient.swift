//
//  URLSessionHTTPClient.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

/*
 
 Archivo que contiene los detalles de implementación de un framework
 */

class URLSessionHTTPClient: HTTPClient {
    
    let session: URLSession
    let requestMaker: URLSessionRequestMaker
    let sessionErrorResolver: URLSessionErrorResolver
    
    init(session: URLSession = .shared, requestMaker: URLSessionRequestMaker, sessionErrorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.sessionErrorResolver = sessionErrorResolver
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        
        guard let url = requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else {
            return .failure(.badURL)
        }
        
        do {
            // load data using URL
            let result = try await session.data(from: url)
            
            /*
             0 = data de la respuesta
             1 = información de la response
             */
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(sessionErrorResolver.resolve(statusCode: response.statusCode))
            }
            
            return .success(result.0)
        } catch {
            return .failure(sessionErrorResolver.resolve(error: error))
        }
        
    }
    
    
}
