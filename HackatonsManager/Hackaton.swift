//
//  Hackaton.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 24/06/2022.
//

import Foundation


class Hackaton{
    var hName : String?
    var dept : String?
    var date : String?
    var theme : String?
    var numParts: String?
    var currNumParts: String?
    var parts : String?
    
    init(hName: String? ,dept : String?, date: String?, theme : String? , numParts: String? ,currNumParts : String?, parts : String?){
        self.hName = hName
        self.dept = dept
        self.theme = theme
        self.date = date
        self.numParts = numParts
        self.currNumParts = currNumParts
        self.parts = parts
    }
}

