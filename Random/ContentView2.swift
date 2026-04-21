import SwiftUI

struct ContentView: View {

    @State private var city: String = ""
    @State private var result: String = "都市を入力してください"

    // 간단한 가짜 날씨 데이터
    let weatherData: [String: String] = [
        "tokyo": "☀️ 맑음 / 25℃",
        "seoul": "🌤 흐림 / 22℃",
        "busan": "🌧 비 / 18℃",
        "osaka": "☀️ 맑음 / 26℃"
    ]

    var body: some View {
        VStack(spacing: 20) {

            Text("🌤 Weather App")
                .font(.largeTitle)
                .bold()

            TextField("도시 이름 입력 (tokyo, seoul...)", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                let key = city.lowercased()
                result = weatherData[key] ?? "❌ 해당 도시 데이터 없음"
            }) {
                Text("날씨 검색")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text(result)
                .font(.title2)
                .padding()

            Spacer()
        }
        .padding()
    }
}