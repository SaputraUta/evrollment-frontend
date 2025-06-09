//
//  User.swift
//  Evrollment
//
//  Created by Saputra on 07/06/25.
//

struct User: Codable {
    var email: String
    var role: String?
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
}

struct RegisterResponse: Codable {
    let message: String
    let user: User?
}

struct AuthRequestBody: Codable {
    let email: String
    let password: String
}
