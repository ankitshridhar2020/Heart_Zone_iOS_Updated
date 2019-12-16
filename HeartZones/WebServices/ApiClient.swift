//
//  ApiClient.swift
//  HeartZones
//
//  Created by Apple on 13/08/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SVProgressHUD

class ApiClient {
    
    // MARK: - ACTIVITY INDICATOR START/STOP METHODS
    
    class func showSVProgressHUDViewWith(_ statusText: String) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            SVProgressHUD.show(withStatus: statusText)
        })
    }
    
    class func hideSVProgressHUDView() {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            SVProgressHUD.dismiss()
        })
    }
    
    // MARK: - CHECK NETWORK CONNECTION
    
    class func isNetworkReachable() -> Bool {
        return ReachabilityManager.shared.isNetworkAvailable
    }
    
    // MARK: - BASE API CALL FOR POST/GET FOR AUTHENTICATION
    
    class func baseWebServiceCallWith_url(_ web_service_url: String, method: HTTPMethod, apiParameters: Parameters, loadingViewText: String, baseSuccessBlock: @escaping(_ responseObject: DataResponse<Any>) -> (), baseFailureBlock: @escaping(_ error: NSError) -> () ) {
        
        let isReachable : Bool = isNetworkReachable()
        
        if isReachable {
            
            if !loadingViewText.isEmpty {
                self.showSVProgressHUDViewWith(loadingViewText)
            }
            
            let requestHeader: HTTPHeaders = [
                "X-User-Token": auth_token
                
            ]
            let absoluteUrl : String = BASE_URL.appending(web_service_url)
            
            Alamofire.request(absoluteUrl, method: method, parameters: apiParameters, headers: requestHeader).responseJSON { (response: DataResponse<Any>) in
                
                self.hideSVProgressHUDView()
                
                if (response.result.isSuccess) {
                    
                    if let statusCode = response.response?.statusCode {
                        
                        switch(statusCode) {
                            
                        case 200, 201:
                            baseSuccessBlock(response)
                            break
                            
                        case 401:
                            NotificationCenter.default.post(name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION, object: nil)
                            break
                            
                        default:
                            if response.result.value is NSDictionary {
                                baseFailureBlock(getApiResponseFailureError(response.result.value as! NSDictionary, errorCode: statusCode))
                            }
                            break
                        }
                    }
                }else if(response.result.isFailure) {
                    if let objError = response.result.error {
                        baseFailureBlock(objError as NSError)
                    }
                }
            }
        }else {
            baseFailureBlock(NO_NETWORK_ERROR)
        }
    }
    
}

