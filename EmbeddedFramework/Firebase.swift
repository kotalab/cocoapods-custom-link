//
//  Firebase.swift
//  EmbeddedFramework
//
//  Created by tetsuya_kojima on 2019/07/08.
//  Copyright © 2019 com.kotalab. All rights reserved.
//

import Firebase
import FirebaseAuth

public enum Firebase {
    public static func setup() {
        FirebaseApp.configure()
        _ = FirebaseApp.app().flatMap(FirebaseAuth.Auth.auth(app: ))
    }
}
