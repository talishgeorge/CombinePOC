//
//  CommonErrorUtility.swift
//  WeatherForecast
//
//  Created by 1276121 on 17/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation
import UIKit

private enum ErrorKey: String {
    case errors = "errors",
    code = "code",
    description = "description",
    error = "_errors",
    name = "name",
    errorResponse = "errorResponse",
    errorId = "errorId",
    errorDetails = "errorDetails",
    errorDescription = "error_description",
    errorCode = "error_code",
    cod = "cod",
    message = "message"
    
}

public class CommonErrorsUtility {
    public static let shared = CommonErrorsUtility()
    public var code: String?
    public var errorDescription: String?
    public var dictionary: [String: Any]?
    public var name: String?
    public var errorId: String?
    public var logTrackCode: String?
    public var errorArray: [[String: Any]]?
    public var errorCode: Int?
    public var message: String?
    
    convenience init(json: [String: Any]) {
        self.init()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let decodedJson = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictionaryJson = decodedJson as? [String: Any] {
                self.extractErrorValues(dictionaryJson: dictionaryJson)
            }
        } catch {
        }
    }

    convenience init(jsonData: Data?, withOption readingOption: JSONSerialization.ReadingOptions) {
        self.init()
        guard let data = jsonData else { return }
        do {
            let decodedJson = try JSONSerialization.jsonObject(with: data, options: readingOption)
            if let dictionaryJson = decodedJson as? [String: Any] {
                        errorDescription = dictionaryJson[ErrorKey.errorDescription.rawValue] as? String
                        code = dictionaryJson[ErrorKey.errorCode.rawValue] as? String
                        errorDescription = dictionaryJson[ErrorKey.errorDescription.rawValue] as? String
                        code = dictionaryJson[ErrorKey.errorCode.rawValue] as? String
                        self.errorCode = dictionaryJson["cod"] as? Int
                        self.message = dictionaryJson[ErrorKey.message.rawValue] as? String
                        self.extractErrorValues(dictionaryJson: dictionaryJson)
            }
        } catch {
        }
    }

    private func extractErrorValues(dictionaryJson: [String: Any]) {
        errorCode = dictionaryJson[ErrorKey.cod.rawValue] as? Int
        message = dictionaryJson[ErrorKey.message.rawValue] as? String
        if
            let keyString = getErrorKeyString(from: dictionaryJson),
            let errors: [[String: Any]] = dictionaryJson[keyString] as? [[String: Any]] {
            errorArray = errors
            dictionary = dictionaryJson
            if errors.count > 0 {
                code = errors[0][ErrorKey.code.rawValue] as? String
                name = errors[0][ErrorKey.name.rawValue] as? String
                errorDescription = errors[0][ErrorKey.description.rawValue] as? String
            }
        } else {
            code = ""; name = ""; errorDescription = ""
        }
        guard let errorResponse = dictionaryJson[ErrorKey.errorResponse.rawValue] as? [String: Any] else {
            errorId = ""; logTrackCode = ""
            return }
        errorId = errorResponse[ErrorKey.errorId.rawValue] as? String
    }
    /* Method to extract error name by checking all posibilities
     @param: error : pass instance of NSError
     */
    public func extractErrorNameByChecking(error: NSError) -> String {
        var errorName: String?
        if
            let dictionaryJson = dictionary,
            let keyString = getErrorKeyString(from: dictionaryJson),
            let errors: [[String: Any]] = dictionaryJson[keyString] as? [[String: Any]] {
            if errors.count == 0 {
                errorName = errors[0][ErrorKey.description.rawValue] as? String
            } else {
                if let name = errors[0][ErrorKey.name.rawValue] {
                    errorName = name as? String
                } else {
                    errorName = errors[0][ErrorKey.description.rawValue] as? String
                }
            }
        } else {
            errorName = error.userInfo[ErrorKey.description.rawValue] as? String
        }
        if let name = errorName { return name } else { return "" }
    }
    
    private func getErrorKeyString(from errorDictionary: [String: Any]) -> String? {
        if errorDictionary.keys.contains(ErrorKey.errors.rawValue) {
            return ErrorKey.errors.rawValue
        } else if errorDictionary.keys.contains(ErrorKey.error.rawValue) {
            return ErrorKey.error.rawValue
        }
        else if errorDictionary.keys.contains(ErrorKey.cod.rawValue) {
            return ErrorKey.cod.rawValue
        }
        else if errorDictionary.keys.contains(ErrorKey.message.rawValue) {
            return ErrorKey.message.rawValue
        }else {
            return nil
        }
    }
}
