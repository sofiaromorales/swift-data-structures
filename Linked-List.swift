class Node<Element> {
    var value: Element
    var next: Node?
    init(_ value: Element, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<Element> {
    var head: Node<Element>?
    var tail: Node<Element>?
    var isEmpty: Bool {
        head == nil
    }
    //adding operations
    mutating func push(_ value: Element) {
        copyNodes()
        head = Node(value, next: head)
        if tail == nil {
            tail = head
        }
    }
    mutating func append(_ value: Element) {
        copyNodes()
        guard !isEmpty else {
            return push(value)
        }
        tail!.next = Node(value)
        tail = tail!.next
    }
    func node(at index: Int) -> Node<Element>? {
        guard !isEmpty else {
            return nil
        }
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index{
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    @discardableResult
    mutating func insert(_ value: Element, after node: Node<Element>) -> Node<Element> {
        copyNodes()
        if node === tail {
            append(value)
             return tail!
        }
        node.next = Node(value, next: node.next)
        return node.next!
    }
    //removing operations
    @discardableResult
    mutating func pop() -> Element? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    mutating func removeLast() -> Element? {
        copyNodes()
        guard !isEmpty else {
            return nil
        }
        if head?.next != nil {
           return pop()
        }
        var currentNode = head
        while currentNode?.next?.next != nil {
            currentNode = currentNode?.next
        }
        currentNode?.next = nil
        tail = currentNode
        return currentNode?.next?.value
    }
    @discardableResult
    mutating func remove(after node: Node<Element>) -> Element? {
        copyNodes()
        defer {
            if node.next?.next == nil {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    public mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        head = Node(oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return("\(value)")
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Element>?
        static func ==(rhs: Index, lhs: Index) -> Bool {
            switch (rhs.node, lhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        public static func < (lhs: LinkedList<Element>.Index, rhs: LinkedList<Element>.Index) -> Bool {
            guard  lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
      Index(node: head)
    }

    public var endIndex: Index {
      Index(node: tail?.next)
    }

    public func index(after i: Index) -> Index {
      Index(node: i.node?.next)
    }

    public subscript(position: Index) -> Element {
      position.node!.value
    }
}
