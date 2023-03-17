//
//  QuizController.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import Foundation

//QuizController fordi vi er gået fra MVVM til MV

class QuizController: ObservableObject{
    @Published var categories: [Category] = [Category(0,"")]
    @Published var categoriesCount: [CategoryCount] = []
    @Published var questions: [Question] = []
    
    
    init() {
//        fetchCategoriesCount2()
        fetchCategories()
    }
    
    func getCategoryById(_ id: Int)-> Category{
        var temCategory = Category(9,"findes ikke")
        var index = 0
        while (temCategory.name=="findes ikke" && index < categories.count){
            if categories[index].id == id {
                temCategory = categories[index]
            }
            else {index+=1}
        }
        return temCategory
    }
    
    
    func fetchCategories(){
        Task(priority: .high){
            guard let url = URL(string: "https://opentdb.com/api_category.php") else {return}
            guard let rawCategoryData = await NetworkService.getData(url) else {return}
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode(CategoryList.self, from: rawCategoryData)
                categories = result.results
            } catch {
                fatalError("Error")
            }
        }
    }
    
    func fetchCategoriesCount(){
        if categories.count>0{
                Task(priority: .high){
                    for c in categories{

                        guard let url = URL(string: "https://opentdb.com/api_count.php?category=\(c.id)") else {return}
                        guard let rawCategoryCountData = await NetworkService.getData(url) else {return}
                        let decoder = JSONDecoder()
                    do{
                        let result = try decoder.decode(CategoryCount.self, from: rawCategoryCountData)
                            categoriesCount.append(result)
                        
                    } catch let error{
                        print("\(String(decoding: rawCategoryCountData, as: UTF8.self))")
                        print(rawCategoryCountData.description)
                        
                        fatalError("\(error)")
                    }
                }
                print("c\(categories.count)")
                print("cc\(categoriesCount.count)")
            }
        }
    }
    
//
//    func fetchCategoriesCount2(){
//        Task(priority: .high){
//            do{
//                guard let url = URL(string: "https://opentdb.com/api_count.php?category=10") else {return}
//		                guard let rawCategoryCountData = await NetworkService.getData(url) else {return}
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(CategoryCount.self, from: rawCategoryCountData)
//                categoriesCount.append(result)
//                print(result)
//            } catch let error {
////                fatalError("Error")
//                print(error)
//            }
//        }
//        print("c\(categories.count)")
//        print("cc\(categoriesCount.count)")
//
//
//    }
    
    
    func getCategoryCountByDifficulty(_ diff: String, categoryId: Int) -> Int {
        var count: Int = 0
        let categoryIndex: Int = categoriesCount.firstIndex(where: {$0.id == categoryId})!
        if diff == "easy"{count = categoriesCount[categoryIndex].questionCount.easy ?? 0}
        else if diff == "medium"{count = categoriesCount[categoryIndex].questionCount.medium ?? 0}
        else {count = categoriesCount[categoryIndex].questionCount.hard ?? 0}
        return count
    }
    
    
    func fetchQuitions(categoryNr: String, difficulty: String) {
        Task(priority: .high){
            do {
                guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(categoryNr)&difficulty=\(difficulty)") else {return}
                guard let rawQuestionData = await NetworkService.getData(url) else {return}
                let decoder = JSONDecoder()
                let result = try decoder.decode(QuestionList.self, from: rawQuestionData)
                questions = result.results
            } catch {
                fatalError("Error")
            }
        }
        print(questions)
    }
    
    func getAnswersFromIndex(_ index: Int) -> [String] {
        var questionsList: [String] = questions[index].incorrectAnswer
        questionsList.append(questions[index].correctAnswer)
        questionsList.shuffle()
        return questionsList
    }
    
    func checkIfThisAnswerIsCorrect(_ answer: String, _ index: Int) -> Bool {
        return questions[index].correctAnswer==answer
    }
    
    func getQuestion(_ index: Int) -> String {
        return questions[index].question
    }
    
    func getRightsNumberOf(_ rights: [Bool]) -> Int {
        var count: Int = 0
        for r in rights{
            if r {count += 1}
        }
        return count
    }
    
    
    
    
}
