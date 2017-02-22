//
//  WSSEManager.swift
//  Shadoo
//
//  Created by Pauline on 17/09/2016.
//  Copyright © 2016 Pauline Montchau. All rights reserved.
//

import UIKit
import CryptoSwift

class WSSEManager: NSObject {
    
    var created: String?
    var nonce: String?
    var digest: String?
    
    let username: String
    let password: String
    
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        super.init()
        self.created = getTimeStamp()
        self.nonce = getNonce()?.uppercased()
        self.digest = getDigest()
        print("created : \(created) / nonce : \(nonce) / digest : \(digest)")
    }
    
    
    
    func getTimeStamp() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: Date())
    }
    
    
    func randomStringWithLength (len : Int) -> String {
        
        let letters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : String = String(len)
        
        for _ in 0 ..< len {
            let length = UInt32(letters.characters.count)
            let rand = arc4random_uniform(length)
            
            let randLetterIndex = letters.characters.index(letters.characters.startIndex, offsetBy: Int(rand))
            let randLetter = letters.characters[randLetterIndex]
            
            randomString.append(randLetter)
        }
        
        return randomString
    }
    
    
    func getNonce() -> String?
    {
        let randomStr = randomStringWithLength(len:10)
        let bytes = [UInt8](randomStr.utf8)
        
        var hexString = String()
        for byte in bytes {
            hexString = hexString.appendingFormat("%02x", UInt(byte) )
        }
        return hexString
    }
    
    
    func getDigest() -> String?
    {
        if let nonce = self.nonce, let created = self.created
        {
            let concatStr = nonce + created + password
            let bytes = [UInt8](concatStr.utf8)
            let sha = bytes.sha1()
            let digest = sha.toBase64()
            return digest
        }
        return nil
    }
    
    
    func getWsseHeader() -> String?{
        if let digest = self.digest, let nonce = self.nonce, let created = self.created {
            var header = "UsernameToken Username=\"";
            header += username
            header += "\", PasswordDigest=\""
            header += digest
            header += "\", Nonce=\""
            header += nonce
            //header += nonce.toBase64()
            header += "\", Created=\""
            header += created
            header += "\""
            
            return header
        }
        return nil
    }
    
}
