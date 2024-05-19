//
//  ContentView.swift
//  WeSplit
//
//  Created by Irina Zherebtsova on 5/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        grandTotal / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) //открывает отдельный список
                }
                
                Section ("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent )
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section ("Total amount for the check") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }
                
                
                Section ("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                  //  let localCurrency = Locale.current.currency?.identifier ?? "USD"
                    // Text(grandTotal, format: localCurrency)
                    
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
