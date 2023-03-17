//
//  CategoryCount.swift
//  QuizDemoContinued
//
//  Created by dmu mac 25 on 16/03/2023.
//

import Foundation

struct CategoryCount: Codable {
    let id: Int
    let questionCount: CategoryQuestionCount

    enum CodingKeys: String, CodingKey {
        case id = "category_id"
        case questionCount = "category_question_count"
    }

    struct CategoryQuestionCount: Codable {
        let total: Int?
        let easy: Int?
        let medium: Int?
        let hard: Int?

        enum CodingKeys: String, CodingKey {
            case total = "total_question_count"
            case easy = "total_easy_question_count"
            case medium = "total_medium_question_count"
            case hard = "total_hard_question_count"
        }
    }
}

//struct CategoryCount: Codable {
//    let category_id: Int
//    let category_question_count: CategoryQuestionCount
//
//    struct CategoryQuestionCount: Codable {
//        let total_question_count: Int?
//        let total_easy_question_count: Int?
//        let total_medium_question_count: Int?
//        let total_hard_question_count: Int?
//
//    }
//}

//"category_id": 9,
//  "category_question_count": {
//    "total_question_count": 305,
//    "": 122,
//    "total_medium_question_count": 123,
//    "total_hard_question_count": 60
//  }
