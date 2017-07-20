//
//  main.swift
//  Lagrange
//
//  Created by Jiachen Ren on 7/19/17.
//  Copyright © 2017 Jiachen. All rights reserved.
//

import Foundation

public class Lagrange {
    private var solutions: [Int]
    private var hashMap: Dictionary<Int,Int>
    private let numSquares: Int
    
    required public init(numSquares: Int, numInputs: Int) {
        hashMap = Dictionary()
        solutions = [Int](repeatElement(0, count: numSquares))
        self.numSquares = numSquares
    }
    
    /**
     * Wrapper method.
     *
     * @param num the number to be factored
     */
    public func findSumRB(num: Int) -> [Int] {
        solutions = [Int](repeatElement(0, count: numSquares))
        let _ = findSumRB(for: num, maxTerms: solutions.count)
        return solutions
    }
    
    /**
     * Designed by Jiachen Ren. All Rights Reserved.
     *
     * @param num      the number to be decomposed into squared numbers.
     * @param maxTerms the max number of terms allowed.
     * @return whether or not the solution is found.
     * @since July 19th.
     */
    private func findSumRB(for num: Int, maxTerms: Int) -> Bool {
        var sum = 0, index = solutions.count - maxTerms
        for i in index..<solutions.count {
            sum += solutions[i]
        }
        if (sum == num) {return true}
        else if (maxTerms == 0) {return false}
        let shortcut = hashMap[num]
        if let extracted = shortcut {
            solutions[index] = extracted * extracted;
            return findSumRB(for: num - solutions[index], maxTerms: maxTerms - 1)
        } else {
            for i in (0...Int(sqrt(CGFloat(num)))).reversed() {
                solutions[index] = i * i
                if (findSumRB(for: num - solutions[index], maxTerms: maxTerms - 1)) {
                    hashMap[num] = i
                    return true
                }
            }
        }
        return false
    }
}

let lagrange = Lagrange(numSquares: 4, numInputs: 10000)
print("Start: ")
let start = Int(readLine()!)!
print("Stop: ")
let stop = Int(readLine()!)!
(start...stop).forEach{
    print("\($0) >> ", terminator: "")
    lagrange.findSumRB(num: $0).forEach{
        print("[\($0)] ", terminator: "")
    }
    print("")
}

