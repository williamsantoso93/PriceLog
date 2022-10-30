//
//  RequestAccess.swift
//  PriceLog
//
//  Created by William Santoso on 24/10/22.
//

import SwiftUI
import Photos
import AVFoundation

enum RequestType {
    case photos
    case camera
}

enum RequestResult {
    case success
    case notAllow
    case decline
}

class RequestAccess {
    static private let displayName: String = Bundle.main.displayName ?? ""
    
    static func alertAccess(_ type: RequestType) -> Alert {
        switch type {
        case .photos:
            return Alert(title: Text("\(displayName) does not have access to your photos. To enable access, tap settings and turn on photos"), primaryButton: .cancel(), secondaryButton: .default(Text("Settings"), action: {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
        case .camera:
            return Alert(title: Text("\(displayName) does not have access to your camera. To enable access, tap settings and turn on camera"), primaryButton: .cancel(), secondaryButton: .default(Text("Settings"), action: {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
        }
        
    }
    
    static func PhotosAccess(completion: @escaping (RequestResult) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .notDetermined, .restricted, .denied:
                    completion(.notAllow)
                case .authorized, .limited:
                    completion(.success)
                @unknown default:
                    completion(.notAllow)
                }
            }
        case .denied, .restricted:
            completion(.decline)
        case .authorized, .limited:
            completion(.success)
        @unknown default:
            completion(.decline)
        }
    }
    
    static func CameraAccess(completion: @escaping (RequestResult) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isSuccess in
                completion(isSuccess ? .success : .notAllow)
            }
        case .denied, .restricted:
            completion(.decline)
        case .authorized:
            completion(.success)
        @unknown default:
            completion(.decline)
        }
    }
}
