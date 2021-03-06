//
//  ErrorProvider.swift
//  WeatherForecast
//
//  Created by 1276121 on 17/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation

public class ErrorProvider: Error {
    var errorDescription: String?
    var errorCode: Int?
    var errorMessage: String?
    var coreError: CommonError?
    
    enum CommonError {
        case noNetwork
        case noProviderFound
        case baseURLNotFound
    }
    
    public init(handler: CommonErrorsUtility?) {
        switch handler?.errorCode {
        case GenericError.noProviderFound.code:
            self.coreError = .noProviderFound
        case GenericError.noNetwork.code:
            self.coreError = .noNetwork
        case GenericError.baseURLNotFound.code:
            self.coreError = .baseURLNotFound
        default:
            self.errorDescription = handler?.errorDescription
            self.errorMessage = handler?.message
            self.errorCode = handler?.errorCode
        }
    }
}
