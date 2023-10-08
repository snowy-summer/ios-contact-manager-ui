//
//  String.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/8/23.
//

import Foundation

@frozen enum PhoneNumberType {
    case phoneNumber
}

extension String {
    func formatted(_ style: PhoneNumberType) -> String {
        var result = self
        result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        result.insert("-", at: result.index(result.endIndex, offsetBy: -4))
        return result
    }
}
