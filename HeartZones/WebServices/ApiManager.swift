//
//  ApiManager.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import Alamofire_SwiftyJSON

class APIManager {
    
    // MARK: - Users apis
    
    class func user_signIn_apiCall(_ params: Parameters, success:@escaping (_ UserDict: User) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        ApiClient.baseWebServiceCallWith_url(USER_LOGIN, method: .post, apiParameters: params, loadingViewText: LOADING_POPUP_TEXT, baseSuccessBlock: {(responseObject: DataResponse) -> () in
            
            self.update_user_authToken_and_other_data(responseObject.response!)
            
            let emptyDataError: NSError = getFailureError("Sorry! Unable to login.")
            
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else {
                failure(emptyDataError)
                return
            }
            guard let isSuccess: Bool = responseDictionary["status"] as? Bool, isSuccess else {
                failure(emptyDataError)
                return
            }
            guard let userData = Mapper<User>().map(JSONObject: responseDictionary["data"]) else {
                failure(emptyDataError)
                return
            }
            success(userData)
            
        }, baseFailureBlock:{(error: NSError?) -> () in
            failure(error!)
        })
    }
    
}

// Update auth-token

extension APIManager {
    
    class func update_user_authToken_and_other_data(_ response: HTTPURLResponse) {
        if let token: String = response.allHeaderFields["X-User-Token"] as? String {
            auth_token = token
        }
    }
    
}

