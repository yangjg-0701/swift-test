import SwiftUI

struct TaskRowView: View {
    var task: Task
    var toggleAction: () -> Void

    var body: some View {
        HStack {
            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    toggleAction()
                }

            VStack(alignment: .leading) {
                Text(task.title)
                Text(task.category)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}