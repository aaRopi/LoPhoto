//
//  WebServices.swift
//  LoPhoto!
//
//  Created by Prateek Ropia on 24/08/2019.
//  Copyright © 2019 Prateek Ropia. All rights reserved.
//

import Foundation

class WebServices {
    static let shared = WebServices()
    
    func getAlbums(completionHandler:@escaping (_ albums: [Album]?, _ error: String?) -> Void) {
        // make web call
        guard let albumUrl = URL(string: WebResources.AlbumResource) else {
            print("Error: cannot create URL")
            completionHandler(nil, "cannot create url")
            return
        }
        
        let urlRequest = URLRequest(url: albumUrl)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for errors first
            guard error == nil else {
                print("error getting albums!")
                print(error!)
                completionHandler(nil, error!.localizedDescription)
                return
            }
            
            // print response to console
            print("Response: ")
            print(response ?? "no response")
            
            // did we get some data?
            guard let responseData = data else {
                print("No error but no data!")
                completionHandler(nil, "no error, but no data")
                return
            }
            
            // parse JSON
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [[String: Any]] else {
                        print("error trying to convert data to JSON")
                        completionHandler(nil, "error trying to convert data to JSON")
                        return
                }
                
                print(jsonData)
                
                var returnAlbums = [Album]()
                
                for jsonDataPiece in jsonData {
                    guard let album = Album(json: jsonDataPiece) else { continue }
                    returnAlbums.append(album)
                }
                
                completionHandler(returnAlbums, nil)
                
            } catch {
                print("error error JSON terror")
                return
            }
        }
        
        dataTask.resume()
    }
    
    func loadAlbumPhotos(_ album: Album, completionHandler:@escaping (_ photos: [Photo]?, _ error: String?) -> Void ) {
        let urlString = WebResources.PhotosResource + "?albumId=" + "\(album.id)" //String(format: "%d", album.id)
        
        // make web call
        guard let albumUrl = URL(string: urlString) else {
            print("Error: cannot create URL")
            completionHandler(nil, "cannot create url")
            return
        }
        
        let urlRequest = URLRequest(url: albumUrl)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for errors first
            guard error == nil else {
                print("error getting albums!")
                print(error!)
                completionHandler(nil, error!.localizedDescription)
                return
            }
            
            // print response to console
            print("Response: ")
            print(response ?? "no response")
            
            // did we get some data?
            guard let responseData = data else {
                print("No error but no data!")
                completionHandler(nil, "no error, but no data")
                return
            }
            
            // parse JSON
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [[String: Any]] else {
                        print("error trying to convert data to JSON")
                        completionHandler(nil, "error trying to convert data to JSON")
                        return
                }
                
                print(jsonData)
                
                var returnPhotos = [Photo]()
                
                for jsonDataPiece in jsonData {
                    guard let photo = Photo(json: jsonDataPiece) else { continue }
                    returnPhotos.append(photo)
                }
                
                completionHandler(returnPhotos, nil)
                
            } catch {
                print("error error JSON terror")
                return
            }
        }
        
        dataTask.resume()
    }
    
    func loadImageData(_ imageUrl: String, completionHandler:@escaping (_ data: Data?, _ error: String?) -> Void) {
        guard let imageUrl = URL(string: imageUrl) else {
            print("Error: cannot create URL")
            completionHandler(nil, "cannot create url")
            return
        }
        
        let urlRequest = URLRequest(url: imageUrl)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for errors first
            guard error == nil else {
                print("error getting albums!")
                print(error!)
                completionHandler(nil, error!.localizedDescription)
                return
            }
            
            // print response to console
            print("Response: ")
            print(response ?? "no response")
            
            // did we get some data?
            guard let responseData = data else {
                print("No error but no data!")
                completionHandler(nil, "no error, but no data")
                return
            }
            
            completionHandler(responseData, nil)
        }
        
        dataTask.resume()
    }
}
