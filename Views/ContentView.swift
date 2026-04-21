import SwiftUI

struct ContentView: View {
    @StateObject var vm = TaskViewModel()
    @State private var showAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.tasks) { task in
                    TaskRowView(task: task) {
                        vm.toggle(task: task)
                    }
                }
                .onDelete(perform: vm.delete)
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                Button("+") {
                    showAdd = true
                }
            }
            .sheet(isPresented: $showAdd) {
                AddTaskView(vm: vm)
            }
        }
    }
}