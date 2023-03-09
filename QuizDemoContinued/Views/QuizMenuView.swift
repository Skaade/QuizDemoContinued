//
//  ContentView.swift
//  QuizDemo
//
//  Created by dmu mac 25 on 08/03/2023.
//

import SwiftUI

struct QuizMenuView: View {
    
    @EnvironmentObject var quizController: QuizController
    
    @State private var selectedOption = 9
    
    enum Difficulty: String, CaseIterable {
        case easy = "easy"
        case medium = "medium"
        case hard = "hard"
    }
         
    @State private var selectedDifficulty = Difficulty.easy
    
    @State var isQuestionsFetched: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 10/100, green: 10/100, blue: 10/100)
                    .frame(height: 150)
                    .cornerRadius(5)
                VStack{
                    Picker("Select an categorie:",selection: $selectedOption) {
                        ForEach(quizController.categories) { cate in
                            Text(cate.name)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack{
                        Text("Difficulty:")
                        Picker("Select a Difficulty", selection: $selectedDifficulty) {
                            ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                Text(difficulty.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .frame(alignment: .center)
                    }
                    Button(action: {
                        Task{
                            await quizController.fetchQuitions(categoryNr: String(selectedOption) , difficulty: selectedDifficulty.rawValue)
                        }
                    }) {
                        NavigationLink(destination: QuizView(difficulty: selectedDifficulty.rawValue, category: quizController.getCategoryById(selectedOption))
//                                       , isActive: $isQuestionsFetched != nil
                        )
                        {
                            Text("Start Quiz")
                        }
                    }
                    .padding(15)
                    .foregroundColor(Color.white)
                    .background(Color.accentColor)
                    .cornerRadius(5)
                    //                    Button{
                    //                        isSubmitted = true
                    //                        NavigationLink{
                    //                            testview()td)
                    //                        }
                    //                    } label: {
                    //                        Text("Submit")
                    //                            .font(.headline)
                    //                            .foregroundColor(.white)
                    //                            .padding()
                    //                            .background(Color.blue)
                    //                            .cornerRadius(10)
                    //                    }
                    //                    .frame(width: 900, height:  20, alignment: .center)
                    //                    .padding()
                    
                }
                
            }
            .frame(height: 10.0)
            
            
        }
        
        //    Todo
    }
}

    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            QuizMenuView().environmentObject(QuizController())
                .preferredColorScheme(.dark)
        }
    }
