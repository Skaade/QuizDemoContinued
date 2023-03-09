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
    
    
    
    var body: some View {
        VStack{
            Text(category.name)
            Text(String(category.id))
            Text(difficulty)
            Text("Next step quizing")
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(difficulty: "easy", category: Category(9, "General Knowledge"))
            .environmentObject(QuizController())
    }
}
