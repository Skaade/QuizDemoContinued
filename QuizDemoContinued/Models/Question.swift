//
//  Question.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import Foundation

struct Question: Codable {
    let question: String
    let correctAnswer: String
    let incorrectAnswer: [String]
    
    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswer = "incorrect_answers"
    }
    
//    init(question: String, correctAnswer: String, incorrectAnswer: [String]) {
//        self.question = question
//        self.correctAnswer = correctAnswer
//        self.incorrectAnswer = incorrectAnswer
//    }
}
