//
//  ContentView.swift
//  MyPlayground
//
//  Created by roger.wang[王濬淇] on 2020/11/6.
//

import SwiftUI
import Alamofire
import SwiftCoroutine

struct ContentView: View {
    
    init() {
        APIs.fetchAPICoroutine()
        APIs.fetchAPI()
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

struct Joke: Codable {
    var id: Int
    var joke: String
    var categories: [String]
    
}

struct JokeResponse: Codable {
    var type: String
    var value: [Joke]
}

class APIs {
    static func fetchAPICoroutine() {
        //    URLSession.shared.dataTaskFuture(for: "")
        //    AF.request("")
        let url = "http://api.icndb.com/jokes/random/1"
        DispatchQueue.main.startCoroutine {
            print("=== start Coroutine === \(Date())")
            for i in 0 ... 2 {
                print(i)
                let obj = try Coroutine.await{ callback in
                    //AF.request(url).responseDecodable(of: JokeResponse.self, completionHandler: callback)
                    AF.request(url).responseDecodable(of: JokeResponse.self) { (response) in
                        callback(response.value, response.error)
                    }
                }
                print(obj.0 ?? "obj is nil")
            }
            
            
            print("=== end Coroutine === \(Date())")
        }
    }
    
    
    static func fetchAPI() {
        //    URLSession.shared.dataTaskFuture(for: "")
        //    AF.request("")
        let url = "http://api.icndb.com/jokes/random/1"
        print("=== start === \(Date())")
        for i in 0 ... 2 {
            print(i)
            AF.request(url).responseDecodable(of: JokeResponse.self) { (response) in
                print(response.value ?? "value is nil")
                print(Date())
            }
//            print(obj.0 ?? "obj is nil")
        }
        
        
        print("=== end === \(Date())")
    }
}

