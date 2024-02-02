//
//  ContentView.swift
//  2.2_subcansum
//
//  Created by PHYS 440 Rachelle on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sumsModel = sums123()
    @State var Nstring = "0"
    
    var body: some View {
    
        VStack{
            Text("N value")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Enter 'N' value", text: $Nstring)
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
            
            HStack {  //equation 1 calculations
                VStack{
                    Text("Result of Summation 1:")
                        .padding(.bottom, 0)
                    Text("\(sumsModel.sum1, specifier: "%.16e")")
                        .padding(.horizontal)
                        .frame(width: 300)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                    Text("Results of Summation 2:")
                        .padding(.bottom, 0)
                    Text("\(sumsModel.sum2, specifier: "%.16e")")
                        .padding(.horizontal)
                        .frame(width: 300)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                    Text("Results of Summation 3:")
                        .padding(.bottom, 0)
                    Text("\(sumsModel.sum3, specifier: "%.16e")")
                        .padding(.horizontal)
                        .frame(width: 300)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                }
            }
            
            Button("Calculate", action: {self.calculate()})
                .padding(.bottom)
                .padding()
               // .disabled(circleModel.enableButton == false)
        }
            
    }
    
    /// calculates roots using equation 1 and 2 from chapter 2
        func calculate() {
            let getN = Int(Nstring)!
            let _ = sumsModel.initSums123(setN: getN)
        }
        
}

#Preview {
    ContentView()
}
