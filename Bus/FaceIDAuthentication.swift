//
//  FaceIDAuthentication.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 18/04/2024.
//

import Foundation
import LocalAuthentication

class FaceIDAuthentication: ObservableObject{
    @Published var isUnlocked = false
    @Published var showingAlert = false
    @Published var biometricError: NSError?
    @Published var isLoggedIn = false
    
    private let context = LAContext()
    private let dataHolder = DataHolder.shared
    
    var loginAction: ((String, String) -> Void)?
    
    func authenticate() {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &biometricError) {
            let reason = "Please authenticate yourself to unlock your account."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        
                        if let savedUsername = self.dataHolder.savedUsername, let savedPassword = self.dataHolder.savedPassword {
                            self.loginAction?(savedUsername, savedPassword)
                        }
                    } else {
                        self.handleAuthenticationError(error: authenticationError)
                    }
                }
            }
        } else {
            self.handleAuthenticationError(error: biometricError)
        }
    }
    
    func logOut(){
//        dataHolder.savedUsername = nil
//        dataHolder.savedPassword = nil
        self.isLoggedIn = false
        self.isUnlocked = false
        self.context.invalidate()
    }
    
    private func handleAuthenticationError(error: Error?) {
        if let error = error as? LAError {
            switch error.code {
            case .authenticationFailed:
                self.biometricError = NSError(domain: "com.yourapp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Authentication failed."])
            case .userCancel:
                self.biometricError = NSError(domain: "com.yourapp", code: 2, userInfo: [NSLocalizedDescriptionKey: "Authentication was canceled by the user."])
            case .userFallback:
                self.biometricError = NSError(domain: "com.yourapp", code: 3, userInfo: [NSLocalizedDescriptionKey: "User tapped the fallback button."])
            case .biometryNotAvailable:
                self.biometricError = NSError(domain: "com.yourapp", code: 4, userInfo: [NSLocalizedDescriptionKey: "Biometry is not available on this device."])
            case .biometryNotEnrolled:
                self.biometricError = NSError(domain: "com.yourapp", code: 5, userInfo: [NSLocalizedDescriptionKey: "Biometry is not enrolled on this device."])
            case .biometryLockout:
                self.biometricError = NSError(domain: "com.yourapp", code: 6, userInfo: [NSLocalizedDescriptionKey: "Biometry is locked out."])
            default:
                self.biometricError = NSError(domain: "com.yourapp", code: 7, userInfo: [NSLocalizedDescriptionKey: "Unable to authenticate using Face ID."])
            }
        } else {
            self.biometricError = NSError(domain: "com.yourapp", code: 8, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred."])
        }
        
        self.showingAlert = true
    }
    
}
