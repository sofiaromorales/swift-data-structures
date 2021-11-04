//
//  Stack.swift
//  
//
//  Created by Sofia Rodriguez Morales on 31/10/21.
//

/*
     Time Complexity
  =======================
||    Action    || Time  ||
||=======================||
|| Pop at top   ||  O(1) ||
||--------------||-------||
|| Pop last     ||  O(n) ||
||--------------||-------||
|| Push         ||  O(1) ||
  =======================
*/

import Foundation

struct Stack<T> {
    var storage = [T]()
    
    public init() { }
    public init(_ elements: [T]) {
        self.storage = elements
    }
    
    var isEmpty: Bool {
        peek() == nil
    }
    func peek() -> T? {
        storage.last
    }
    mutating func push(_ element: T) {
        storage.append(T)
    }
    @discardableResult
    mutating func pop() -> T {
        storage.removeLast()
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        """
        ----top----
        \(storage.map { "\($0)"}.reversed().joined(separator: "\n"))
        ---end---
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
