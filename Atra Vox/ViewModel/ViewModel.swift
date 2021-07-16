//
//  ViewModel.swift
//  Atra Vox
//
//  Created by Rex Karnufex on 5/22/21.
//  Copyright © 2021 GWEB. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    public var result: SongModel?
    func parseValues() {
        guard let url = Bundle.main.url(forResource: "atravoxdata", withExtension: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(SongModel.self, from: jsonData)
            
            if let result = result {
                print(result)
            } else { print("Failed To Pass...") }
            
        } catch { print("Error") }
    }
}

/* class ViewModel {
    
    init() { parseJSON() }
    
    func parseJSON() {
        print("Nada...")
        guard let path = Bundle.main.path(forResource: "atravoxdata.json", ofType: "json")
        else { return }
        debugPrint(path)
        let url = URL(fileURLWithPath: path)
        debugPrint(url)
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(SongModel.self, from: data)
            debugPrint(response)
        } catch {
            debugPrint(error)
        }
    }
} */

/* public var result: SongModel?
func load() {
    let path = Bundle.main.path(forResource: "atravoxdata", ofType: "json")
    let url = URL(fileURLWithPath: path!)
    
    URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
        do { if let dataData = data {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode( SongModel.self, from: jsonData)
            DispatchQueue.main.async {
                result = jsonData
            }
        } else { print("NO Data") }
        } catch { print("Error") }
    }.resume()
} */
