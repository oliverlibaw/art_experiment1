import SwiftUI

//  Testing GitHub


struct ContentView: View {
    @State var textBlocks = [String]()
    @State var currentIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // Timer every 2 minutes
    
    func loadTextBlocks() {
        // Load text blocks file
        let path = Bundle.main.path(forResource: "textBlocks", ofType: "txt")
        if let textURL = path {
            do {
                let text = try String(contentsOf: URL(fileURLWithPath: textURL))
                textBlocks = text.components(separatedBy: "\n\n")
            } catch {
                print("Error loading text blocks: \(error)")
            }
        }
        // Set initial index
        currentIndex = 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Display current text block if currentIndex is valid
            if currentIndex < textBlocks.count {
                let lines = textBlocks[currentIndex].components(separatedBy: "\n")
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(lines.indices, id: \.self) { index in
                        Spacer().frame(height: index == 0 ? 0 : 10)
                        Text(lines[index])
                            .font(index == 0 ? .largeTitle.bold() : .body)
                            .padding(.leading)
                    }
                }
            }
        }
        .onAppear {
            loadTextBlocks()
        }
        .onReceive(timer) { _ in
            currentIndex += 1
            if currentIndex == textBlocks.count {
                currentIndex = 0
            }
        }
        .padding()
    }
}

