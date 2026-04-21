import SwiftUI

struct ContentView: View {

    let quotes = [
        "継続は力なり",
        "今日の選択が明日を作る",
        "諦めない人が成功する",
        "小さな習慣が人生を変える",
        "始めることが一番大事",
        "失敗は成功の一部"
    ]

    @State private var currentQuote = "ボタンを押してください"

    var body: some View {
        VStack(spacing: 30) {

            Text("📖 ランダム名言アプリ")
                .font(.title)
                .bold()

            Text(currentQuote)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                currentQuote = quotes.randomElement() ?? ""
            }) {
                Text("名言を生成")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}