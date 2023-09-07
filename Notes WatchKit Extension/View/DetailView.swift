//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Adriancys Jesus Villegas Toro on 7/9/23.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditPresented: Bool = false
    @State private var isSettingPresented: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 3) {
//            header
           HeaderView(title: "")
//            content
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
            }
            Spacer()
//            footer
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingPresented) {
                        SettingsView()
                    }
                
                Spacer()
                
                Text("\(count) / \(index+1)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditPresented) {
                        CreditsView()
                    }
            }// :HStack
            .foregroundColor(.accentColor)
        }//: VStack
        .padding(3)
    }
}

// MARK: - Preview

struct DetailView_Previews: PreviewProvider {
    static var sampleDate: Note = Note(id: UUID(), text: "Hello Word")
    
    static var previews: some View {
        DetailView(note: sampleDate, count: 5, index: 1)
    }
}
