//
//  ScannerView.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/04/2024.
//

import SwiftUI
import UIKit
import AVKit

struct ScannerView: View {
    @EnvironmentObject var dataHolder: DataHolder
    /// QR Code Scanner Properties
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    /// QR Scanner AV Output
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    /// Error Properties
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    @Environment(\.presentationMode) var presentationMode
    /// Camera QR Output Delegate
    @StateObject private var qrDelegate = QRScannerDelegate()
    /// Scanned Code
    @State private var scannedCode: String = ""
    /// Device Orientation
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    /// TripAPI
    @ObservedObject var tripAPI = TripAPI()
    /// check
    @Binding var check: Bool
    
    @Binding var addTripSuccess: Bool
    
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(Color.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Place the QR code inside the area")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 20)
            
            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundColor(.gray)
            
            Spacer(minLength: 0)
            
            /// Scanner
            GeometryReader {
                let size = $0.size
                let sqareWidth = min(size.width, 300)
                
                ZStack {
                    CameraView(frameSize: CGSize(width: sqareWidth, height: sqareWidth), session: $session, orientation: $orientation)
                        .cornerRadius(4)
                        /// Making it little smaller
                        .scaleEffect(0.97)
//                        .onRotate{
//                            if session.isRunning {
//                                orientation = $0
//                            }
//                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                                if session.isRunning {
                                    orientation = UIDevice.current.orientation
                                }
                            }
                    
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            /// Trimming to get Scanner like Edges
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                /// Sqaure Shape
                .frame(width: sqareWidth, height: sqareWidth)
                /// Scanner Animation
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? sqareWidth : 0)
                })
                /// To Make it Center
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            
            Spacer(minLength: 15)
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    reactivateCamera()
                    activateScannerAnimation()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            Spacer(minLength: 45)
        }
        .padding(15)
        /// Checking Camera Permission, when the View is Visible
        .onAppear(perform: checkCameraPermission)
        .onDisappear {
            session.stopRunning()
        }
        .alert(errorMessage, isPresented: $showError) {
            /// Showing Setting's Button, if permission is denied
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        /// Opening App's Setting, Using openURL SwiftUI API
                        openURL(settingsURL)
                    }
                }
                
                /// Along with Cancel Button
                Button("Cancel", role: .cancel) {
                }
            }
        }
        .onChange(of: qrDelegate.scannedCode) { newValue in
            if let code = newValue {
                scannedCode = code
                /// When the first code scan is available, immediately stop the camera.
                session.stopRunning()
                /// Stopping Scanner Animation
                deActivateScannerAnimation()
                /// Clearing the Data on Delegate
                qrDelegate.scannedCode = nil
                /// Presenting Scanned Code
//                presentError(scannedCode)
                /// Get UserName
                if let username = getValue(for: "username", from: scannedCode) {
                    // Hiển thị thông báo thành công
                    print("Added trip for username: \(username)")
                    tripAPI.addTrip(tokenLogin: dataHolder.tokenLogin, dutyID: dataHolder.sessionId!, username: username) {success in
                        DispatchQueue.main.async{
                            if success {
                                dataHolder.isAddTripSuccess = true
                                addTripSuccess = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    check = true
                                }
                            }else {
                                dataHolder.isAddTripSuccess = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    check = true
                                }
                                print("Failed to add trip for username: \(username)")
                            }
                        }
                    }
                    
//                    if tripAPI.isAddTripSuccessful {
//                        // Thực hiện đóng view quét QR
//                        dataHolder.isAddTripSuccess = true
//                        DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                            presentationMode.wrappedValue.dismiss()
//                            check = true
//                        }
//                    } else {
//                        dataHolder.isAddTripSuccess = false
//                        print("Failed to add trip for username: \(username)")
//                    }
                } else {
                    // Trường hợp không tìm thấy username trong URL
                    print( "No username found in scanned QR code.")
                    // Thực hiện đóng view quét QR
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onChange(of: session.isRunning) { newValue in
            if newValue {
                orientation = UIDevice.current.orientation
            }
        }
    }
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    /// Activating Scanner Animation Method
    func activateScannerAnimation() {
        /// Adding Delay for Each Reversal
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    /// De-Activating Scanner Animation Method
    func deActivateScannerAnimation() {
        /// Adding Delay for Each Reversal
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    /// Checking Camera Permission
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    /// New Setup
                    setupCamera()
                } else {
                    /// Already Existing One
                    reactivateCamera()
                }
            case .notDetermined:
                /// Requesting Camera Access
                if await AVCaptureDevice.requestAccess(for: .video) {
                    /// Permission Granted
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    /// Permission Denied
                    cameraPermission = .denied
                    /// Presenting Error Message
                    presentError("Please Provide Access to Camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    /// Setting Up Camera
    func setupCamera() {
        do {
            /// Finding Back Camera
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            
            /// Camera Input
            let input = try AVCaptureDeviceInput(device: device)
            /// For Extra Saftey
            /// Checking Whether input & output can be added to the session
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            /// Adding Input & ouptut to Camera Session
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            /// Setting Ouput config to read QR Codes
            qrOutput.metadataObjectTypes = [.qr]
            /// Adding Delegate to Retreive the Fetched QR Code From Camera
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            /// Note Session must be started on Background thread
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    /// Presenting Error
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    /// Get Value
    func getValue(for key: String, from url: String) -> String? {
        // Tách chuỗi URL thành các thành phần
        if let urlComponents = URLComponents(string: url) {
            // Lặp qua các query items trong URL để tìm tham số cần truy xuất
            for queryItem in urlComponents.queryItems ?? [] {
                // Nếu tìm thấy tham số có tên là key, trả về giá trị của nó
                if queryItem.name == key {
                    return queryItem.value
                }
            }
        }
        // Trả về nil nếu không tìm thấy giá trị cho key
        return nil
    }
}

//struct ScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
