//
//  SearchModels.swift
//  Acronyms
//
//  Created by Alok on 13/10/21.
//

import Foundation

struct Acronym: Codable {
    let sf: String
    let lfs: [AcronymDetails]
}

struct AcronymDetails: Codable {
    let lf: String?
}
