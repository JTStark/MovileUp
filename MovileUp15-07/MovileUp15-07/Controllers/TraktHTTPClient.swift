//
//  TraktHTTPClient.swift
//  MovileUp15-07
//
//  Created by iOS on 7/22/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import Foundation
import Alamofire
import TraktModels
import Result


private enum Router: URLRequestConvertible {
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    
    case Show(String)
    case Episode(String, Int, Int)
    
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            switch self {
                case .Show(let id):
                    return ("shows/\(id)", ["extended": "images,full"], .GET)
        
                case .Episode(let show, let season, let ep):
                    return ("shows/\(show)/seasons/\(season)/episodes/\(ep)", ["extended": "images,full"], .GET)
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}





class TraktHTTPClient {
    
    private lazy var manager: Alamofire.Manager = {
    
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "6527b37bd484acd6207ffc91d4c0d9692814082285b540f27db8b92df5f792cd"
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
    
    
    private func getJSONElement<T: JSONDecodable>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
            
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            
            if let json = responseObject as? NSDictionary {
            
                if let value = T.decode(json) {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }
            
            } else {
                completion?(Result.failure(error))
            }
        }
    }
            
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        getJSONElement(Router.Show(id), completion: completion)
    }
            
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        let router = Router.Episode(showId, season, episodeNumber)
    
        getJSONElement(router, completion: completion)
    }
            
            
            
            
            
            
            
//
//    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
//        var req = manager.request(Router.Show(id).URLRequest).validate()
//        
//        req.responseJSON { (_, _, show_json, error) -> Void in
//            
//            if let json: AnyObject = show_json{
//    
//                if let show = Show.decode(json) {
//                    completion?(Result.success(show))
//                } else {
//                    completion?(Result.failure(nil))
//                }
//    
//            } else {
//                completion?(Result.failure(error))
//            }
//        }
//    }
//            
//    
//    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
//        var req = manager.request(Router.Episode(showId, season, episodeNumber).URLRequest).validate()
//                
//        req.responseJSON { (_, _, ep_json, error) -> Void in
//                
//            if let json: AnyObject = ep_json{
//            
//                if let ep = Episode.decode(json) {
//                    completion?(Result.success(ep))
//                } else {
//                    completion?(Result.failure(nil))
//                }
//            
//            } else {
//                completion?(Result.failure(error))
//            }
//        }
//    }
    
}
















