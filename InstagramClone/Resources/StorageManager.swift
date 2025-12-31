//
//  StorageManager.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 01/01/26.
//
public struct PhotoPost {
    let identifier : String
    let thumbnailImage : URL
    let postUrl : URL
    let caption : String?
    let likesCount : [PostLike]
    let comments : [PostComment]
    let creationDate : Date
    let photoType : PhotoType
    let taggedUsers : [String]
    let owner : Users
}
public struct Users {
    let userName : String
    let bio : String
    let name : (first : String,last : String)
    let birthDate : Date
    let gender : Gender
    let counts : Counts
    let profilePhoto : URL
    let joinDate : Date
}
public struct Counts {
    let followedBy : Int
    let follows : Int
    let post : Int
}
public enum Gender{
    case male, female, other
}
public struct PostLike {
    let postId : String
    let userName : String
    let profileImageUrl : URL
    let creationDate : Date
}
public struct PostComment {
    let postId : String
    let userName : String
    let commentText : String
    let profileImageUrl : URL
    let creationDate : Date
    let likes : [PostLike]
}
public enum PhotoType : String {
    case photo = "Photo"
     case video = "Video"
}
import FirebaseStorage
public class StorageManager {
    public static let shared = StorageManager()
    private init() {}
    private let bucket = Storage.storage().reference()
    
    // MARK - Public
    public func uploadUserPhotoPost(model : PhotoPost,completion : (Result<URL,Error>) -> Void){
        
    }
    
    public func downloadImage(with reference : String,completion : (Result<URL,Error>) -> Void){
        
    }
}
