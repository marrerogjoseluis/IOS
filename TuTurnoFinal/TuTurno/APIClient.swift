//
//  APIClient.swift
//  SegundoObligatorio
//
//  Created by Jose Luis Marrero on 19/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.

// Comentarios
// Hacer una colectionView para las vistas de los distintos dias.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire
import MapKit
import CoreLocation

class APIClient {
    
    static let sharedClient = APIClient()
    
    private let baseURL = "http://tuturno.azurewebsites.net/api/comercio"
    
        
    private init() {
        
    }
    
    
    func getTuTurno(onCompletion: (comercio: [Comercio]?, error: NSError?) -> Void) {
        
        Alamofire.request(.GET, self.baseURL).validate().responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            
            switch response.result {
                
            case .Failure(let error):
                onCompletion(comercio: nil, error: error)
            case .Success(let value):
                
                if let comercio = Mapper<Comercio>().mapArray(value) {
                    
                    onCompletion(comercio: comercio, error: nil)
                }else {
                    onCompletion(comercio: nil, error: NSError(domain: "MyApp", code: 9999, userInfo: [NSLocalizedDescriptionKey: "Fallo el mapeo"]))
                }
            }
            
        }
    }
    
}
