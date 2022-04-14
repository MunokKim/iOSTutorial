//
//  TokenAddingInterceptor.swift
//  RocketReserver
//
//  Created by 김문옥 on 2022/04/15.
//  Copyright © 2022 Apollo GraphQL. All rights reserved.
//

import Foundation
import Apollo
import KeychainSwift

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        let keychain = KeychainSwift()
        if let token = keychain.get(LoginViewController.loginKeychainKey) {
            request.addHeader(name: "Authorization", value: token)
        } // else do nothing
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
