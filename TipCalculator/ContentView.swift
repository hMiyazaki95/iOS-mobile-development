//
//  ContentView.swift
//  TipCalculator
//
//  Created by Hajime Miyazaki on 2/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var tipText: String = ""
    @State var tip: Double? = nil
    @State var calculator: TipCalculator = TipCalculator()
    
    // Replace NumberFormatter instance with your custom Formatter instance
    let formatter = Formatter() // Use your custom Formatter struct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tip")
            TextField("%", text: $tipText)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onAppear {
                    tipText = "\(calculator.tipPercent)"
                }
                .onChange(of: tipText, initial: false) {
                    if let newTipPercent = Double(tipText) {
                        calculator.tipRatio = newTipPercent / 100
                    }
                }
            
            Text("Amount")
            TextField("in \(formatter.currencySymbol())", text: $text) // Adjust for currency symbol
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Spacer()
                Button("Calculate (\(formatter.formatPercent(for: calculator.tipRatio * 100)))") {
                    if let userInput = Double(text) {
                        tip = calculator.calculateTip(for: userInput)
                    } else {
                        print("Not a valid number")
                    }
                }
                Spacer()
            }
            
            if let tip = tip {
                HStack {
                    Text("Tip:")
//                    Spacer()
                    // Use formattedCurrency method to format the tip amount
                    Text(formatter.formattedCurrency(for: tip))
                    Spacer()
                    Button("Clear") {
                        self.tip = nil
                        text = ""
                        tipText = "\(calculator.tipPercent)"
                    }
                }
            } else {
                Text("No tip calculated yet.")
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
