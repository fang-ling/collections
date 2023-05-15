## DoublyLinkedList

A collection implementing a doubly linked list.

## Overview

A **linked list** is a data structure in which the objects are arranged in a linear order. Unlike an array, however, in which the linear order is determined by the array indices, the order in a linked list is determined by pointers in each object.

```swift
var bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
```

Like all variable-size collections on the standard library, `DoublyLinkedList` implements value semantics: each list has an independent value that includes the values of its elements. Modifying one list does not affect any others:

```swift
var copy = bugs
copy.remove_last()
print(copy) // ["Aphid", "Bumblebee", "Cicada", "Damselfly"]
print(bugs) // ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]  
```

This is implemented with copy-on-write optimization since the nodes are stored in a `Array`, with array indexes serving as pointers. Multiple copies of a doubly linked list share the same underlying nodes until you modify one of the copies. When that happens, the doubly linked list being modified replaces its nodes with a uniquely owned copy of itself, which is then modified in place.
