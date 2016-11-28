//
//  Address.swift
//  Paged Tabs Example
//
//  Created by Rishabh Kesarwani on 25/11/16.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

struct Address {
    
    private let name: String!
    private let flatNo: String!
    private let society: String!
    private let street: String!
    private let locality: String!
    private let landmark: String!
    private let flatSize: String!
    
    init(name: String, flatNo: String, society: String, street: String, locality: String, landmark: String, flatSize: String) {
        self.name = name
        self.flatNo = flatNo
        self.society = society
        self.street = street
        self.locality = locality
        self.landmark = landmark
        self.flatSize = flatSize
    }
    
    func getName() -> String {
        return self.name
    }
    
    func get(withName: Bool) -> String {
        let addressToReturn = "\(self.flatNo) \(self.society) \(self.street) \(self.locality) \(self.landmark) \(self.flatSize)"
        return withName ? "\(self.name) \(addressToReturn)" : addressToReturn
    }
}
