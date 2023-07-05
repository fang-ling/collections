//
//  DoublyLinkedList+Collection.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    /* Links e as first element. */
    @inlinable mutating func link_first(_ e : Element) {
        let f = first_ptr
        let new_node_ptr = malloc(Node(prev: nil, item: e, next: f))
        first_ptr = new_node_ptr
        if f == nil {
            last_ptr = new_node_ptr
        } else {
            buffer[f!].prev = new_node_ptr
        }
    }
    
    /* Links e as last element. */
    @inlinable mutating func link_last(_ e : Element) {
        let l = last_ptr
        let new_node_ptr = malloc(Node(prev: l, item: e, next: nil))
        last_ptr = new_node_ptr
        if l == nil {
            first_ptr = new_node_ptr
        } else {
            buffer[l!].next = new_node_ptr
        }
    }
    
    /* Inserts element e before non-nil Node successor. */
    @inlinable
    mutating func link_before(_ e : Element, _ successor_ptr : Int?) {
        /* assert successor != nil */
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
    }
    
    /* Unlinks non-null first node. */
    @discardableResult
    @inlinable mutating func unlink_first(_ f_ptr : Int?) -> Element {
        /* assert f == first_ptr && f_ptr != nil */
        let element = buffer[f_ptr!].item
        let next_ptr = buffer[f_ptr!].next
        buffer[f_ptr!].next = nil /* Help GC */
        first_ptr = next_ptr
        if next_ptr == nil {
            last_ptr = nil
        } else {
            buffer[next_ptr!].prev = nil
        }
        
        free(f_ptr!) /* f.prev == nil */
        return element
    }
    
    /* Unlinks non-null last node. */
    @discardableResult
    @inlinable mutating func unlink_last(_ l_ptr : Int?) -> Element {
        /* assert l_ptr == last_ptr && l_ptr != nil */
        let element = buffer[l_ptr!].item
        let prev_ptr = buffer[l_ptr!].prev
        buffer[l_ptr!].prev = nil /* Help GC */
        last_ptr = prev_ptr
        if prev_ptr == nil {
            first_ptr = nil
        } else {
            buffer[prev_ptr!].next = nil
        }
        
        free(l_ptr!)
        return element
    }
    
    /* Unlinks non-null node x. */
    @discardableResult
    @inlinable mutating func unlink(_ x_ptr : Int?) -> Element {
        /* assert x_ptr != nil */
        let element = buffer[x_ptr!].item
        let next_ptr = buffer[x_ptr!].next
        let prev_ptr = buffer[x_ptr!].prev
        
        if prev_ptr == nil {
            first_ptr = next_ptr
        } else {
            buffer[prev_ptr!].next = next_ptr
            buffer[x_ptr!].prev = nil /* Help GC */
        }
        
        if next_ptr == nil {
            last_ptr = prev_ptr
        } else {
            buffer[next_ptr!].prev = prev_ptr
            buffer[x_ptr!].next = nil /* Help GC */
        }
        
        free(x_ptr!)
        return element
    }
}
