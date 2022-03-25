//
//  Network.swift
//  RocketReserver
//
//  Created by 김문옥 on 2022/03/25.
//  Copyright © 2022 Apollo GraphQL. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
}
