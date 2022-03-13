//
//  ViewController.swift
//  MyOWN
//
//  Created by Ananya Vangoor on 3/1/22.
//

import UIKit

class ViewController: UIViewController, JokeManagerDelegate {
    func didUpdateJoke(joke: JokeModel) {
        DispatchQueue.main.async {
            self.jokeLabel.text = joke.question
            self.answerLabel.text = joke.answer
        }
    }
    
    
    var jokeManager = JokeManager()
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var Prompt: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeManager.delegate = self
    }

    @IBAction func jokePressed(_ sender: UIButton) {
        jokeManager.getJoke()
    }
    
}

