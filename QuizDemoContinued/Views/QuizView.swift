//
//  QuizView.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import SwiftUI

struct QuizView: View {
    
    @EnvironmentObject var quizController: QuizController
    
    @State var difficulty: String
    @State var category: Category
    
    @State private var outputString: String = ""
    
    @State var rights: [Int] = [0,0,0,0,0,0,0,0,0,0]
    @State var currentQuestion = 0
    @State var isAnswerShown = false
    @State var question: String = ""
    
    init(difficulty: String, category: Category, currentQuestion: Int = 0, isAnswerShown: Bool = false) {
        self.difficulty = difficulty
        self.category = category
        self.currentQuestion = currentQuestion
        self.isAnswerShown = isAnswerShown
        
        
    }
    
    
    var body: some View {
        
        VStack{
            //            Text(category.name)
            //            Text(String(category.id))
            //            Text(difficulty)
            //            Text("Next step quizing")
            HStack{
                Text("Question \(currentQuestion+1): \(question)")
                        .font(.title)
                        .padding()
            }
            
            HStack{
                Button(){
                    currentQuestion += 1
                    
                }label: {
                    Text("1:")
                }
                .buttonStyle(.bordered)
                Button(){
                    currentQuestion += 1
                    
                }label: {
                    Text("2:")
                }
                .buttonStyle(.bordered)
            }
            HStack{
                Button(){
                    currentQuestion += 1
                }label: {
                    
                    Text("3:")
                }
                .buttonStyle(.bordered)
                Button(){
                    currentQuestion += 1
                }label: {
                    Text("4:")
                }
                .buttonStyle(.bordered)
                
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
       QuizView(difficulty: "easy", category: Category(9, "General Knowledge"))
            .environmentObject(QuizController()).preferredColorScheme(.dark)
    }
}
