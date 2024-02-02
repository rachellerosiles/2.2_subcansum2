//
//  sums123.swift
//  2.2_subcansum
//
//  Created by PHYS 440 Rachelle on 1/31/24.
//

import Foundation

@Observable class sums123 {
    
    var sum1 = 0.0
    var sum2 = 0.0
    var sum3 = 0.0
    var N = 0
    
    var sum1Text = ""
    var sum2Text = ""
    var sum3Text = ""
    var enableButton = true
    
    
    func initSums123(setN: Int) -> Bool {
        N = setN
        
        Task{
            
            await setButtonEnable(state: false)
            
            let returnedResults = await withTaskGroup(
                of: (Type: String, StringToDisplay: String, Value: Double).self, /* this is the return from the taskGroup*/
                returning: [(Type: String, StringToDisplay: String, Value: Double)].self, /* this is the return from the result collation */
                body: { taskGroup in  /*This is the body of the task*/
                    
                    // We can use `taskGroup` to spawn child tasks here.
                    
                    taskGroup.addTask { let sum1 = await self.getSum1()
                        
                        return sum1  /* this is the return from the taskGroup*/}
                    
                    taskGroup.addTask { let sum2 = await self.getSum2()
                        
                        return sum2  /* this is the return from the taskGroup*/}
                        
                    taskGroup.addTask { let sum3 = await self.getSum3()
                        return sum3 }
                    
                    
                    // Collate the results of all child tasks
                    var combinedTaskResults :[(Type: String, StringToDisplay: String, Value: Double)] = []
                    for await result in taskGroup {
                        
                        combinedTaskResults.append(result)
                    }
                    
                    return combinedTaskResults  /* this is the return from the result collation */
                    
                })
            
            //Do whatever processing that you need with the returned results of all of the child tasks here.
            
            // Sort the results based upon of the result so that the Area returns first
            
            let sortedCombinedResults = returnedResults.sorted(by: { $0.0 < $1.0 })
            
            print(returnedResults)
            print(sortedCombinedResults)
            
            await setButtonEnable(state: true)
            
        }
        
        return true
    }
    
    func getSum1() async -> (Type: String, StringToDisplay: String, Value: Double){
        for n in 1...2*N {
            sum1 = sum1 + pow((-1), Double(n)) * Double(n)/Double(n+1)
        }
        
        let sum1Text = "\(sum1.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Summation 1", StringToDisplay: sum1Text, Value: sum1)
    }
    
    func getSum2() async -> (Type: String, StringToDisplay: String, Value: Double){
        var sum2half1 = 0.0
        var sum2half2 = 0.0
        
        for n in 1...N {
            sum2half1 = sum2half1 + Double(2*n - 1)/Double(2*n)
            sum2half2 = sum2half2 + Double(2*n)/Double(2*n+1)
        }
        sum2 = sum2half2 - sum2half1
        
        let sum2Text = "\(sum2.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Summation 2", StringToDisplay: sum2Text, Value: sum2)
    }
    
    func getSum3() async -> (Type: String, StringToDisplay: String, Value: Double){
        for n in 1...N {
            sum3 = sum3 + 1/Double(2*n*(2*n + 1))
        }
        
        let sum3Text = "\(sum3.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Summation 3", StringToDisplay: sum3Text, Value: sum3)
    }
    
    
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    //setters??? when are they called tho and why do we not have getters as well??
    @MainActor func newSum1(sum1: Double){
        self.sum1 = sum1
    }
    
    @MainActor func newSum2(sum2: Double){
        self.sum2 = sum2
    }
    
    @MainActor func newSum3(sum3: Double){
        self.sum3 = sum3
    }
    
    // I think I don't need these? Idk what they were for in other code
    /*
    @MainActor func updateSum1(sum1Text:String){
        self.sum1Text = sum1Text
    }
    
    @MainActor func updateSum2(sum2Text:String){
        self.sum2Text = sum2Text
    }
    
    @MainActor func updateSum3(sum3Text:String){
        self.sum3Text = sum3Text
    }
    */
}
