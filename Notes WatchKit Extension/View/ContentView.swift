//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes = [Note]()
    @State private var text: String = ""
    
    // MARK: - Methods
    func save() {
//        dump(notes)
        do {
            //convert the notes array to data JSONEncoder
            let data = try JSONEncoder().encode(notes)
//            create a new url to save the file using getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
//            Write the data to teh given array
            try data.write(to: url)
        }catch {
            print("saving data has failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
    //            Get the notes urlpath
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
    //            create a new property for the data
                let data = try Data(contentsOf: url)
    //            decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch  {
                //Not data
            }
        }
    }
    
    func delete(offSets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offSets)
            save()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        return path[0]
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Note", text: $text)
                
                Button {
//                    STEPS
//                    1. ONLY ACTIVE THE BUTTON WHEN TEXTFIELD IS NOT EMPTY
                    guard text.isEmpty == false else { return }
//                    2. CREATE A NEW NOTE ITEM AND INITIALIZE WITH TEXT VALUE
                    let note = Note(id: UUID(), text: text)
//                    3. ADD note item to notes Array
                    notes.append(note)
//                    4. make the TextField empty
                    text = ""
//                    5. save the notes (function)
                    save()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                
//                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                
            }//:HStack
            
            Spacer()
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id:\.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }//:HSTack
                        }//:NavigationLink
                        
                    }//:Loop
                    .onDelete(perform: delete) //delete notes
                }//:List
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.green)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }
            
        }//:VStack
        .navigationTitle("Notes")
        .onAppear {
            load()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
