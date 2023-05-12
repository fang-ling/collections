//
//  DoublyLinkedList+Collection.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    /* Links e as first element. */
    mutating func link_first(_ e : Element) {
        let f = first_ptr
        let new_node_ptr = malloc(Node(prev: nil, item: e, next: f))
        first_ptr = new_node_ptr
        if f == nil {
            last_ptr = new_node_ptr
        } else {
            buffer[f!].prev = new_node_ptr
        }
        count += 1
    }
    
    /* Links e as last element. */
    mutating func link_last(_ e : Element) {
        let l = last_ptr
        let new_node_ptr = malloc(Node(prev: l, item: e, next: nil))
        last_ptr = new_node_ptr
        if l == nil {
            first_ptr = new_node_ptr
        } else {
            buffer[l!].next = new_node_ptr
        }
        count += 1
    }
    
    /* Inserts element e before non-nil Node successor. */
    mutating func link_before(_ e : Element, _ successor_ptr : Int?) {
        /// assert successor != nil
        let predecessor_ptr = buffer[successor_ptr!].prev
        let new_node_ptr = malloc(Node(prev: predecessor_ptr,
                                       item: e,
                                       next: successor_ptr))
        buffer[successor_ptr!].prev = new_node_ptr
        if predecessor_ptr == nil {
            first_ptr = new_node_ptr
        } else {
            buffer[predecessor_ptr!].next = new_node_ptr
        }
        count += 1
    }
    
    /* Unlinks non-null first node. */
    mutating func unlink_first() -> Element {
        /// assert first_ptr != nil
        let element = buffer[first_ptr!].item
        let next_ptr = buffer[first_ptr!].next
        free(first_ptr!)
        first_ptr = next_ptr
        if next_ptr == nil {
            last_ptr = nil
        } else {
            buffer[next_ptr!].prev = nil
        }
        count -= 1
        return element
    }
    
    /* Unlinks non-null last node. */
    mutating func unlink_last() -> Element {
        /// assert last_ptr != nil
        let element = buffer[last_ptr!].item
        let prev_ptr = buffer[last_ptr!].prev
        free(last_ptr!)
        last_ptr = prev_ptr
        if prev_ptr == nil {
            first_ptr = nil
        } else {
            buffer[prev_ptr!].next = nil
        }
        count -= 1
        return element
    }
    
    /* Unlinks non-null node x. */
    @discardableResult
    mutating func unlink(_ x_ptr : Int?) -> Element {
        /// assert x_ptr != nil
        let element = buffer[x_ptr!].item
        let next_ptr = buffer[x_ptr!].next
        let prev_ptr = buffer[x_ptr!].prev
        
        if prev_ptr == nil {
            first_ptr = next_ptr
        } else {
            buffer[prev_ptr!].next = next_ptr
        }
        
        if next_ptr == nil {
            last_ptr = prev_ptr
        } else {
            buffer[next_ptr!].prev = prev_ptr
        }
        
        free(x_ptr!)
        count -= 1
        return element
    }
}
