//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 01/01/26.
//

import FirebaseDatabase
public class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    private let database = Database.database().reference()
    // Mark - Public
    /// Check either userName and userEmail is already available or not
    /// - Parameters
    ///     - email : String represents userEmail
    ///     - userName : String represents userName
    public func canCreateUser(with email : String, userName : String,completion : (Bool) -> Void) {
            completion(true)
    }
    // This method is responsible to insert new credentials in the database
    /// - Parameters
    ///     - email : String represents userEmail
    ///     - userName : String represents userName
    ///     - completion : Asychronous callback for result if database entry succeded
    public func insertNewUser(with email : String, userName : String,completion : @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        
        database.child(key).setValue(["username" : userName]){ error , _ in
            if error == nil {
                
                //succeded
                completion(true)
            } else {
                //failed
                completion(false)
            }
        }
        
    }
    }
