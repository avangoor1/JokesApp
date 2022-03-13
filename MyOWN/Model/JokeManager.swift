//
//  JokeData.swift
//  MyOWN
//
//  Created by Ananya Vangoor on 3/1/22.
//

import Foundation

protocol JokeManagerDelegate {
    func didUpdateJoke(joke: JokeModel)
    func didFailWithError(error: Error)
}

struct JokeManager {
    
    var delegate : JokeManagerDelegate?
    
    let baseURL = "https://stage.jokeapi.dev/joke/Any?safe-mode"
    
    func getJoke() {
        let finalURL = "\(baseURL)"
        if let url = URL(string: finalURL) {
            
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            
            //Create a new data task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    // before delgate print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                //Format the data we got back as a string to be able to print it.
//                let dataAsString = String(data: data!, encoding: .utf8)
//                print(dataAsString)
                if let safeData = data {
                    if let jokeText = self.parseJSON(jokeData : safeData) {
                        self.delegate?.didUpdateJoke(joke: jokeText)
                    }
                }
                
            }
            //Start task to fetch data from bitcoin average's servers.
            task.resume()
        }
    }
    
    func parseJSON(jokeData : Data) -> JokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JokeData.self, from: jokeData)
            let lastjoke = decodedData.setup
            let answer = decodedData.delivery
            
            let joke = JokeModel(question : lastjoke, answer: answer)
            return joke
        } catch {
            // before delegate print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
