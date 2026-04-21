import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
}

struct ContentView: View {

    @State private var title = ""
    @State private var amount = ""

    @State private var expenses: [Expense] = []

    var total: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(spacing: 20) {

            Text("💰 Expense Tracker")
                .font(.largeTitle)
                .bold()

            TextField("항목 (예: 커피)", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("금액", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.decimalPad)

            Button(action: {
                if let value = Double(amount), !title.isEmpty {
                    let newExpense = Expense(title: title, amount: value)
                    expenses.append(newExpense)

                    title = ""
                    amount = ""
                }
            }) {
                Text("추가")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text("총 지출: \(total, specifier: "%.0f")円")
                .font(.title2)
                .padding()

            List {
                ForEach(expenses) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        Text("¥\(item.amount, specifier: "%.0f")")
                    }
                }
                .onDelete { indexSet in
                    expenses.remove(atOffsets: indexSet)
                }
            }

            Spacer()
        }
    }
}