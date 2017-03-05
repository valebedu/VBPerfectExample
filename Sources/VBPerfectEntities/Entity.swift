//
//  Entity.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 21/02/2017.
//
//

import Foundation

protocol Entity
{
    var createdAt: Date? { get set }
    var updatedAt: Date? { get set }
}
