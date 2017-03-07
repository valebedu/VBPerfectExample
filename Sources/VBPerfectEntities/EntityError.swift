//
//  EntityError.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 06/03/2017.
//
//

import Foundation

public enum EntityError: Error
{
    case parsingFailed(body: [String: Any])
}
