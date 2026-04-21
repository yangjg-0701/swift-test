import SwiftUI
import Charts

// MARK: - モデル
struct Expense: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let category: String
}

// MARK: - カテゴリ集計用モデル
struct CategoryTotal: Identifiable {
    let id = UUID()
    let category: String
    let total: Double
}

struct ContentView: View {

    // 入力値
    @State private var title = ""
    @State private var amount = ""
    @State private var category = "食費"

    // データ
    @State private var expenses: [Expense] = []

    let categories = ["食費", "交通費", "娯楽", "その他"]

    // 合計金額
    var total: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    // カテゴリ別集計
    var categoryTotals: [CategoryTotal] {
        Dictionary(grouping: expenses, by: { $0.category })
            .map { (key, value) in
                CategoryTotal(
                    category: key,
                    total: value.reduce(0) { $0 + $1.amount }
                )
            }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {

                Text("💰 家計簿アプリ")
                    .font(.title)
                    .bold()

                // 入力欄
                TextField("項目（例：コーヒー）", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                TextField("金額", text: $amount)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .keyboardType(.decimalPad)

                // カテゴリ選択
                Picker("カテゴリ", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // 追加ボタン
                Button(action: {
                    if let value = Double(amount), !title.isEmpty {
                        expenses.append(
                            Expense(title: title, amount: value, category: category)
                        )
                        title = ""
                        amount = ""
                    }
                }) {
                    Text("追加")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // 合計表示
                Text("合計支出: ¥\(total, specifier: "%.0f")")
                    .font(.headline)

                // 📊 グラフ
                Chart(categoryTotals) { item in
                    BarMark(
                        x: .value("カテゴリ", item.category),
                        y: .value("金額", item.total)
                    )
                }
                .frame(height: 200)
                .padding()

                // リスト表示
                List {
                    ForEach(expenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.category)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Text("¥\(item.amount, specifier: "%.0f")")
                        }
                    }
                    .onDelete { indexSet in
                        expenses.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("家計簿")
        }
    }
}