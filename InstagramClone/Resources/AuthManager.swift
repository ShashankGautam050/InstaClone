//
//  AuthManager.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 01/01/26.
//

import FirebaseAuth
public class AuthManager {
    public static var shared = AuthManager()
    private init() {}
    
    public var currentUser: User? {
        return Auth.auth().currentUser
    }
    // Mark - Public
    /// this method is responsible for registering the new user
    public func registerUser(username : String?, email : String?, password : String, completion : @escaping(Bool) -> Void){
        guard let email = email,!email.isEmpty,let username = username,!username.isEmpty else {
            return
        }
        DatabaseManager.shared.canCreateUser(with: email, userName: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil,error == nil else {
                        completion(false)
                        return
                    }
                    
                    //Insert into the database
                    DatabaseManager.shared.insertNewUser(with: email, userName: username) { inserted
                        in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
   // MARK - Public
  /// This Method is responsible to login the user
    public func loginUser(username : String?, email : String?, password : String,completion: @escaping (Bool) -> Void){
        
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil,error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            
        }
        
    }
    
  // MARK - Public
    /// This method is responsible to logout the user
    public func logoutUser(completion: @escaping (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            completion(false)
            print(error.localizedDescription)
            return
        }
        
    }
}
