//
//  User.swift
//  Evrollment
//
//  Created by Saputra on 07/06/25.
//

struct User: Codable {
    let id: Int?
    let email: String
    let role: String?
}

struct LoginResponse: Codable {
    let token: String
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
