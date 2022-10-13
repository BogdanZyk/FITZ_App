//
//  FirebaseAuthGroup.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.10.2022.
//

import FirebaseAuth


func firebaseAuthGroup(){
    do {
      try Auth.auth().useUserAccessGroup("group.BogdanZyk.FITZ")
    } catch let error as NSError {
      print("Error changing user access group: %@", error)
    }
}


