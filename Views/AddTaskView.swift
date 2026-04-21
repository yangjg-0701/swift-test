import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: TaskViewModel

    @State private var title = ""
    @State private var category = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("新しいタスク追加")
                .font(.title)

            TextField("タイトル", text: $title)
                .textFieldStyle(.roundedBorder)

            TextField("カテゴリ（仕事・学校など）", text: $category)
                .textFieldStyle(.roundedBorder)

            Button("追加") {
                vm.addTask(title: title, category: category)
                dismiss()
            }
        }
        .padding()
    }
}