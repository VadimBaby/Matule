//
//  SupabaseManager.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import Foundation
import Supabase

final class SupabaseManager {
    static let instance = SupabaseManager()
    
    private let supabase = SupabaseClient(supabaseURL: URL(string: "https://vdfuraswyldrktaeldjy.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZkZnVyYXN3eWxkcmt0YWVsZGp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUzNDM4MjgsImV4cCI6MjAzMDkxOTgyOH0.05huZHZLu89QHlQDVve77L3AvU72sl_h5mBr2Wyruds")
    
    private let users: String = "users"
    
    func signUp(name: String, email: String, password: String) async throws {
        
        try await supabase.auth.signUp(email: email, password: password)
        
        try await signIn(email: email, password: password)
        
        let user = try await supabase.auth.session.user
        
        let userModel = UserModel(id: user.id, name: name, email: email, created_at: .now)
        
        try await supabase.from(users)
            .insert(userModel)
            .execute()
        
        try await supabase.auth.signOut(scope: .local)
    }
    
    func signIn(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }
    
    func resetPassword(email: String) async throws {
        try await supabase.auth.resetPasswordForEmail(email)
    }
    
    func verifyOTP(token: String, email: String) async throws {
        try await supabase.auth.verifyOTP(email: email, token: token, type: .recovery)
    }
    
    func updatePassword(password: String) async throws {
        try await supabase.auth.update(user: .init(password: password))
    }
}
