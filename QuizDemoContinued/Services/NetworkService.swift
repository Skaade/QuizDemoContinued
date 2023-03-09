//
//  NetworkService.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import Foundation

class NetworkService {
    
    static func getData(_ url: URL) async -> Data? {
        //Lidt fyfy kode
        let session = URLSession.shared
        let (data, response) = try! await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { return nil}
        if httpResponse.statusCode != 200 {
            fatalError("Error")
        }
        return data
    }
}
