//
//  ListQueue.swift
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

protocol List {
    associatedtype Element
    var isEmpty: Bool { get }
    var head: Node<T>? { get }
    var tail: Node<T>? { get }
    //adding
    mutating func push(_ element: T)
    mutating func append(_ element: T)
    //remove
    mutating func pop() -> T?
    mutating func removeLast() -> Node<T>?
}

class Node<Element> {
    var value: T
    var next: Node?
    var prev: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct DoublyLinkedList<T>: List {
    var head: Node<T>?
    var tail: Node<T>?
    var isEmpty: Bool {
        head == nil
    }
    
    init() { }
    
    mutating func push(_ element: T) {
        guard let listHead = head else {
            head = Node(value: element)
            tail = head
            return
        }
        head = Node(value: element, next: listHead)
        if let nextHead = listHead.next {
            nextHead.prev = listHead
        }
    }
    
    mutating func append(_ element: T) {
        guard let tailNode = tail else {
            push(element)
            return
        }
        tail = Node(value: element)
        tail!.prev = tailNode
        tailNode.next = tail
    }
    
    
    mutating func pop() -> T? {
        guard let listHead = head else {
            return nil
        }
        head = listHead.next
        return listHead.value
    }
    
    mutating func removeLast() -> Node<T>? {
        guard let listTail = tail else {
            return nil
        }
        tail = listTail.prev
        return listTail
    }
}

struct ListQueue<T>: Queue {
    typealias T = T
    var isEmpty: Bool
    var peek: T?
    var storage = DoublyLinkedList<T>()
    
    mutating func enqueue(_ element: T) {
        storage.append(element)
    }
    
    mutating func dequeue() -> T? {
        storage.pop()
    }
    
}
