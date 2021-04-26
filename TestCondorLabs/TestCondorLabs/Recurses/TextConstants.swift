//
//  TextConstants.swift
//  TestCondorLabs
//
//  Created by Pedro Alonso Daza B on 26/04/21.
//

import Foundation
class TextConstants {
    var leng = ""
    
    var WS_ERROR_NO_RESPONSE = ""
    var ERROR_SITES_DATA = ""
    var LABEL_NAME = ""
    var LABEL_REGION = ""
    var ALERT_BUTTON_SAVE_DATA = ""
    var ALERT_BUTTON_KEEP_ASKING = ""
    var ALERT_BUTTON_CANCEL = ""
    var ALERT_MESSAGGE_KEE_SITE = ""
    var WS_ERROR_NO_DATA = ""
    
    init() {
        leng = Locale.current.languageCode ?? "en"
        
        WS_ERROR_NO_RESPONSE = (leng == "en") ? "this service is temporarily out of service": "este servicio esta temporalmente fuera de servicio"
        ERROR_SITES_DATA  = (leng == "en") ? "At this time there are no cities available": "En este momento no hay ciudades disponibles"
        LABEL_NAME = (leng == "en") ? "Name: ": "Nombre: "
        LABEL_REGION = (leng == "en") ? "Region: ": "Region: "
        ALERT_BUTTON_SAVE_DATA = (leng == "en") ? "Keep my decision.": "Mantener mi desicicion"
        ALERT_BUTTON_KEEP_ASKING = (leng == "en") ? "Keep asking.": "Seguir preguntando."
        ALERT_BUTTON_CANCEL = (leng == "en") ? "Cancel.": "Cancelar."
        ALERT_MESSAGGE_KEE_SITE = (leng == "en") ? "You have already selected a site. What do you want to do with this decision?": "Ya seleccionaste un sitio. ¿que deseas hacer con esta descicion? "
        WS_ERROR_NO_DATA = (leng == "en") ? "No Data": "No tienes datos"
    }
    
    
}
