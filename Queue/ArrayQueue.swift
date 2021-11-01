//
//  ArrayQueue.swift
//  
//
//  Created by Sofia Rodriguez Morales on 31/10/21.
//

import Foundation

protocol Queue {
    associatedtype T
    var isEmpty: Bool { get }
    var peek: T { get }
    mutating func enqueue(_ elemnt: T)
    mutating func dequeue() -> T
}

struct ArrayQueue<T>: Queue {
    var storage = [T]()
    var isEmpty: Bool { storage.isEmpty }
    var peek: T { storage.first }
    
    init() { }
    
    mutating func enqueue(_ elemnt: T) {
        storage.append(T)
    }
    mutating func dequeue() -> T {
        storage.removeFirst()
    }
}

extension ArrayQueue: CustomStringConvertible {
    public var description: String {
        String.init(describing: storage)
    }
}


