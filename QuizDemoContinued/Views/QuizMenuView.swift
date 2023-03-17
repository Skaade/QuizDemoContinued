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
            
            //            if quizController.categories.isEmpty {
            //                ProgressView()
            //            } else {
            
            ZStack{
                Color(red: 10/100, green: 10/100, blue: 10/100)
                    .frame(height: 175)
                    .cornerRadius(5)
                VStack{
                    
                    // Todo: Bonus 1
                    //                        if  quizController.categoriesCount.count != quizController.categories.count {
                    //                            ProgressView()
                    //                        } else {
                    Picker("Select a category:",selection: $selectedOption) {
                        ForEach(quizController.categories) { cate in
                            Text("\(cate.name):")
//                            Todo: Bonus 1
//                                 \(quizController.getCategoryCountByDifficulty(selectedDifficulty.rawValue, categoryId: cate.id))")
                        }
                    }
                    .pickerStyle(.menu)
                    Divider()
                    
                    //                        }
                    
                    
                    HStack{
                        Text("Difficulty:")
                            .padding(.horizontal)
                        Picker("Select a difficulty", selection: $selectedDifficulty) {
                            ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                Text(difficulty.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .frame(alignment: .center)
                    }
                    Divider()
                    Button(action: {
                        Task{
                            
                        }
                        
                        
                    }) {
                        NavigationLink(destination: QuizView(difficulty: selectedDifficulty.rawValue, category: quizController.getCategoryById(selectedOption))
                                       
                        )
                        {
                            Text("Start Quiz")
                                .frame(height: 10)

                        }
                    }
                    .padding(15)
                    .foregroundColor(Color.white)
                    .background(Color.accentColor)
                    .cornerRadius(5)
            
                    
                }
                
            }
            .frame(height: 10.0)
            
            
        }
        //    Todo: Bonus 1
        
        //                        .onAppear{
        //                            if (quizController.categories.count > 0){
        //                                quizController.fetchCategoriesCount()
        //                            }
        //                        }
        
    }
    
    
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizMenuView().environmentObject(QuizController())
            .preferredColorScheme(.dark)
    }
}
