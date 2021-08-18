//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andres on 2021-06-18.
//

import SwiftUI

struct ContentView: View {
    // Possible moves
    @State private var moves = ["Rock", "Paper", "Scissors"]
    //Value picked by app within moves
    @State private var machineVal = Int.random(in: 0..<3)
    // Bool to store whether you should win (true) or loose
    @State private var outcome = Bool.random()
    // Game status true to show alert
    @State private var gameStatus = false
    // Ensures no draws
    @State private var draw = false
    // Match result
    @State private var matchResult = ""
    //Store player score
    @State private var score = 0
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.black, Color.white, Color.black, Color.white]), center: .top).ignoresSafeArea()
            VStack {
                //Main title
                Text("Rock, Paper & Scissors")
                    .font(.largeTitle)
                    .padding()
                //Display desired outcome
                if outcome == true {
                    Text("Player Should Win")
                        .font(.title2)
                        .padding()
                } else {
                    Text("Player Should Loose")
                        .font(.title2)
                        .padding()
                }
                
                
                //Display Player options
                ForEach(0..<moves.count) { number in Button(action: {
                        if number == machineVal {
                            draw = true
                        }
                        else {
                            self.battle(number)
                        }
                    },
                    label: {
                        Text("\(moves[number])")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .padding()
                    }
                )}
                .alert(isPresented: $draw, content: {
                    Alert(title: Text("Draw!"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                        self.restart()
                    })
                })
                
                
                Text("Current Score: \(score)")
                    .font(.title2)
                    .padding()

                .alert(isPresented: $gameStatus, content: {
                    Alert(title: Text(matchResult), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                        self.restart()
                    })
                })
            }
        }
    }
    //Function returns true if player won and false if lost
    func battle(_ number: Int) {
        if outcome == true {
            if (machineVal > number && number != 0) || (number == 2 && machineVal == 0) {
                score -= 1
                matchResult = "Failure"
                gameStatus = true
            } else {
                score += 1
                matchResult = "Success!"
                gameStatus = true
            }
        }
        else {
            if (machineVal > number && number != 0) || (number == 2 && machineVal == 0) {
                score += 1
                matchResult = "Success!"
                gameStatus = true
            } else {
                score -= 1
                matchResult = "Failure"
                gameStatus = true
            }
        }
    }
    //Function to restart the game
    func restart() {
        machineVal = Int.random(in: 0..<3)
        outcome = Bool.random()
        gameStatus = false
        draw = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
