import SwiftUI

struct ContentView: View {

    @State private var notes: [Note] = []
    @State private var inputText: String = ""

    let saveKey = "notes_key"

    var body: some View {
        NavigationView {
            VStack {

                // 입력 영역
                HStack {
                    TextField("메모 입력", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("추가") {
                        addNote()
                    }
                    .padding(.horizontal)
                }
                .padding()

                // 리스트
                List {
                    ForEach(notes) { note in
                        Text(note.text)
                    }
                    .onDelete(perform: deleteNote)
                }
            }
            .navigationTitle("메모 앱")
        }
        .onAppear {
            loadNotes()
        }
    }


    func addNote() {
        guard !inputText.isEmpty else { return }
        notes.append(Note(text: inputText))
        inputText = ""
        saveNotes()
    }


    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }

 
    func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }


    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        }
    }
}