//
//  HeaderView.swift
//  Notes WatchKit Extension
//
//  Created by Adriancys Jesus Villegas Toro on 7/9/23.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    
    var title: String = ""
    
    var body: some View {
        VStack {
            //title
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            //separetor
            
            
            HStack{
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }//HStack
            .foregroundColor(.accentColor)
        }//:VStack
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Credits")
            
            HeaderView()
        }
    }
}
