//
//  QuizDemoApp.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import SwiftUI

@main
struct QuizDemoApp: App {
    
    @StateObject var quizController = QuizController()

    
    var body: some Scene {
        WindowGroup {
            QuizMenuView().environmentObject(quizController)
                .preferredColorScheme(.dark)
        }
    }
}
