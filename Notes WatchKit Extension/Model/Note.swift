//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/23.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
