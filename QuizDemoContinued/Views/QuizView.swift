//
//  QuizView.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import SwiftUI

struct QuizView: View {
    
    @EnvironmentObject var quizController: QuizController
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var difficulty: String
    @State var category: Category
        
    @State var rights: [Bool] = [false,false,false,false,false,false,false,false,false,false]
    @State var currentQuestion = 0
    @State var isAnswerShown = false
    @State var answers: [String] = ["","","",""]
    
    
    
    var body: some View {
        
        VStack{
            if quizController.questions.isEmpty {
                ProgressView()
            }
            else if quizController.questions.count <= currentQuestion {
                VStack{
                    Text("Congrats you got:")
                        .font(.title2)
                    Text("\(quizController.getRightsNumberOf(rights)) out of \(currentQuestion) right")
                        .font(.title)
                    HStack{
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        }
                    label:{
                        Text("Exit to menu")
                        
                    }
                    .padding(15)
                    .foregroundColor(Color.white)
                    .background(.red)
                    .cornerRadius(5)
                        Button{
                            rights = Array(repeating: false, count: 10)
                            answers = ["","","",""]
                            quizController.questions = []
                            quizController.fetchQuitions(categoryNr: String(category.id), difficulty: difficulty)
                            currentQuestion = 0

                        }
                    label:{
                        Text("More please")
                        
                    }
                    .padding(15)
                    .foregroundColor(Color.white)
                    .background(.green)
                    .cornerRadius(5)
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        withAnimation(.easeInOut(duration: 4)) {
//                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                
                
            }
            
            
            else {
                
                
                //            Text(category.name)
                //            Text(String(category.id))
                //            Text(difficulty)
                //            Text("Next step quizing")
                
                // kunne også løses med et foreach
                
                VStack{
                    VStack{
                        isAnswerShown ?  rights[currentQuestion] ? Text("Right").foregroundColor(.green) : Text("Wrong").foregroundColor(.red)  : Text ("")
                    }
                    .animation(
                        .easeInOut(duration: 0.5))
                    
                    Text("")
                    Text("Question \(currentQuestion+1): ")
                    Text("")
                    Text("\(quizController.getQuestion(currentQuestion))")
                        .multilineTextAlignment(.center)
                }
                .font(.title)
                .padding()
                
                HStack{
                    
                    Button(){
                        rights[currentQuestion] = quizController.checkIfThisAnswerIsCorrect(answers[0], currentQuestion)
                        
                        
                        
                            isAnswerShown = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isAnswerShown = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    
                                    currentQuestion += 1;
                                    if(currentQuestion != quizController.questions.count){
                                        answers =  quizController.getAnswersFromIndex(currentQuestion);
                                    }
                            }
                            
                            
                        }
                        
                    }label: {
                        Text("1: \(answers[0])")}
                    .buttonStyle(.bordered)
                    
                    
                    Button(){
                        rights[currentQuestion] = quizController.checkIfThisAnswerIsCorrect(answers[1], currentQuestion)
                        
                        
                        if currentQuestion < quizController.questions.count {
                            isAnswerShown = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isAnswerShown = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    
                                    currentQuestion += 1;
                                    
                                    
                                    
                                    if(currentQuestion != quizController.questions.count){
                                        answers =  quizController.getAnswersFromIndex(currentQuestion);
                                    }
                                }
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }label: {
                        Text("2: \(answers[1])")}
                    .buttonStyle(.bordered)
                }
                
                .task {
                    if currentQuestion < quizController.questions.count {
                        answers = quizController.getAnswersFromIndex(currentQuestion)
                    }
                }
                
                if(quizController.questions.isEmpty == false && quizController.questions[currentQuestion].incorrectAnswer.count > 1){
                    HStack{
                        
                        Button(){
                            rights[currentQuestion] = quizController.checkIfThisAnswerIsCorrect(answers[2], currentQuestion)
                            
                            
                            if currentQuestion < quizController.questions.count {
                                isAnswerShown = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isAnswerShown = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        
                                        currentQuestion += 1;
                                        if(currentQuestion != quizController.questions.count){
                                            answers =  quizController.getAnswersFromIndex(currentQuestion);
                                        }
                                    }
                                }
   
                            }
                        }label: {
                            Text("3: \(answers[2])")
                            
                            
                        }
                        .buttonStyle(.bordered)
                        Button(){
                            rights[currentQuestion] = quizController.checkIfThisAnswerIsCorrect(answers[3], currentQuestion)
                            
                            
                            if currentQuestion < quizController.questions.count {
                                isAnswerShown = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isAnswerShown = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        
                                        currentQuestion += 1;
                                        if(currentQuestion != quizController.questions.count){
                                            answers =  quizController.getAnswersFromIndex(currentQuestion);
                                        }
                                    }
                                }
                                
                                
                            }
                        }label: {
                            Text("4: \(answers[3])")                    }
                        .buttonStyle(.bordered)
                        
                    }
                    
                }
                
            }
            
        }
        .onAppear(perform:{ quizController.fetchQuitions(categoryNr: String(category.id), difficulty: difficulty)})
    }
}



struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(difficulty: "easy", category: Category(9, "General Knowledge"))
            .environmentObject(QuizController()).preferredColorScheme(.dark)
    }
}
