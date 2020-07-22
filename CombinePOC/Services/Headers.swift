//
//  Headers.swift
//  WeatherForecast
//
//  Created by 1276121 on 16/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import Foundation
struct APIHeaderKeys {
    static let accept = "Accept"
    static let contentType = "Content-Type"
    static let travelCountry = "AFKL-TRAVEL-Country"
    static let travelHost = "AFKL-TRAVEL-Host"
    static let acceptLanguage = "Accept-Language"
    static let xApiConsumer = "X_API_CONSUMER"
    static let travelChannel = "AFKL-TRAVEL-Channel"
    static let contentTypeHALJson = "application/hal+json"
    static let xPreDeployed = "X-Predeployed"
    static let travelMarket = "AFKL-Travel-Market"
    static let charSet = "charset"
    static let posLanguage = "PosLanguage"
    static let posCountry = "PosCountry"
    static let trackingId = "Cookie"
    static let travelStation = "AFKL-TRAVEL-Station"
}

struct APIHeaders {
    static let defaultConsumerCountry = "NL"
    static var common: [String: String] {
        let language = "en"
        return [APIHeaderKeys.accept: "application/json",
                APIHeaderKeys.contentType: "application/json",
                APIHeaderKeys.travelCountry: "nl",
                APIHeaderKeys.acceptLanguage: language,
                APIHeaderKeys.xPreDeployed: "true",
                APIHeaderKeys.travelHost: "NL"]
    }
    static var generic: [String: String] {
        let language = "en"
        return [APIHeaderKeys.accept: "application/json",
                APIHeaderKeys.contentType: "application/json",
                APIHeaderKeys.travelCountry: "NL",
                APIHeaderKeys.acceptLanguage: language,
                APIHeaderKeys.travelHost: "KL"]
    }
}
