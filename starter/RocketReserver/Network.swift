//
//  Network.swift
//  RocketReserver
//
//  Created by 김문옥 on 2022/03/25.
//  Copyright © 2022 Apollo GraphQL. All rights reserved.
//

import Foundation
import Apollo
import ApolloWebSocket

class Network {
    static let shared = Network()

    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        
        // 1
        let webSocket = WebSocket(url: URL(string: "wss://apollo-fullstack-tutorial.herokuapp.com/graphql")!)

        // 2
        let webSocketTransport = WebSocketTransport(websocket: webSocket)

        // 3
        let splitTransport = SplitNetworkTransport(
          uploadingNetworkTransport: transport,
          webSocketNetworkTransport: webSocketTransport
        )

        // 4
        return ApolloClient(networkTransport: splitTransport, store: store)
    }()
}
