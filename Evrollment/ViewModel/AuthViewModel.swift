import Foundation

@MainActor
@Observable
class AuthViewModel {
    var user: User?
    var errorMessage: String?
    var successMessage: String?
    var isLoading = false
    
    func register(email: String, password: String) async {
        guard let url = URL(string: Config.apiBaseURL + "/api/auth/register") else { return }
        
        let body = AuthRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            self.errorMessage = nil
            self.successMessage = nil
            self.isLoading = true
            request.httpBody = try JSONEncoder().encode(body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let errorResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data)
                self.errorMessage = errorResponse?.message ?? "Registration failed with status \(httpResponse.statusCode)"
                self.isLoading = false
                return
            }
            
            let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
            self.isLoading = false
            self.user = registerResponse.user
            self.successMessage = registerResponse.message
            self.errorMessage = nil
        } catch {
            self.isLoading = false
            self.errorMessage = "Registration failed: \(error.localizedDescription)"
        }
    }
}
