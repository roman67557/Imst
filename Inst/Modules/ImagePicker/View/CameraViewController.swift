//
//  FourthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController  {
  
  //MARK: - Public Properties
  
  public var presenter: CameraViewPresenterProtocol!
  
  //MARK: - Private Properties
  
  private let captureButton = UIButton()
  private let changeCameraButton = UIButton()
  private let flashButton = UIButton()
  private let previewView = UIView()
  
  private var captureSession = AVCaptureSession()
  private var videoPreviewLayer = AVCaptureVideoPreviewLayer()
  private var capturePhotoOutput = AVCapturePhotoOutput()
  private let capturePhotoSettings = AVCapturePhotoSettings()
  
  //MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.view.backgroundColor = .white
    setup()
  }
  
  override func viewDidLayoutSubviews() {
    videoPreviewLayer.frame = view.bounds
  }
  
  deinit {
    print("camera deinit")
  }
  
  //MARK: - Private Methods
  
  private func setup() {
    addSubViews()
    setupCapturePhotoSettings()
    setupCaptureButton()
    setupChangeCameraButton()
    setupFlashButton()
    setupConstraints()
    
    do {
      try setupCamera()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func addSubViews() {
    [previewView, captureButton, changeCameraButton ,flashButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupCapturePhotoSettings() {
    capturePhotoSettings.flashMode = .off
    capturePhotoSettings.isHighResolutionPhotoEnabled = true
  }
  
  private func setupCaptureButton() {
    captureButton.layer.cornerRadius = 38
    captureButton.clipsToBounds = true
    
    captureButton.backgroundColor = .systemGray5
    captureButton.setBackgroundColor(.gray, for: .highlighted)
    
    captureButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
  }
  
  private func setupChangeCameraButton() {
    changeCameraButton.layer.cornerRadius = 25
    changeCameraButton.clipsToBounds = true
    
    changeCameraButton.setImage(.swap, for: .normal)
    changeCameraButton.setBackgroundColor(.gray, for: .highlighted)
    changeCameraButton.backgroundColor = .systemGray5
    
    changeCameraButton.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
  }
  
  private func setupFlashButton() {
    flashButton.layer.cornerRadius = 25
    
    flashButton.setImage(.noFlash, for: .normal)
    flashButton.backgroundColor = .systemGray5
    flashButton.setBackgroundColor(.gray, for: .highlighted)
    
    flashButton.addTarget(self, action: #selector(changeFlash), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    
    captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    captureButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    captureButton.heightAnchor.constraint(equalToConstant: 76).isActive = true
    captureButton.widthAnchor.constraint(equalToConstant: 76).isActive = true
    
    changeCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.size.width / 3).isActive = true
    changeCameraButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    changeCameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    changeCameraButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    
    flashButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.size.width / 3).isActive = true
    flashButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    flashButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    flashButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  private func setupCamera() throws {
    guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { print("No device"); return }
    switch captureDevice.deviceType {
    case .builtInWideAngleCamera: break
    default: break
    }
    
    let input = try AVCaptureDeviceInput(device: captureDevice)
    
    captureSession.addInput(input)
    
    capturePhotoOutput = AVCapturePhotoOutput()
    capturePhotoOutput.isHighResolutionCaptureEnabled = true
    
    captureSession.addOutput(capturePhotoOutput)
    
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    
    videoPreviewLayer.frame = previewView.layer.bounds
    
    previewView.layer.addSublayer(videoPreviewLayer)
    
    DispatchQueue.global().async { [weak self] in
      self?.captureSession.startRunning()
    }
  }
  
  @objc private func takePhoto() {
    dismiss(animated: true)
    capturePhotoOutput.capturePhoto(with: capturePhotoSettings, delegate: self)
  }
  
  @objc private func changeCamera() {
    captureSession.beginConfiguration()
    let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput
    captureSession.removeInput(currentInput!)
    let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
    let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice!)
    captureSession.addInput(newVideoInput!)
    captureSession.commitConfiguration()
  }
  
  private func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
    let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
    
    for device in discoverySession.devices {
      if device.position == position {
        return device
      }
    }
    
    return nil
  }
  
  @objc private func changeFlash() {
    switch capturePhotoSettings.flashMode {
    case .off:
      capturePhotoSettings.flashMode = .on
      flashButton.setImage(.flash, for: .normal)
    case .on:
      capturePhotoSettings.flashMode = .off
      flashButton.setImage(.noFlash, for: .normal)
    default:
      break
    }
  }
  
}

//MARK: - Extensions

extension CameraViewController: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard error == nil else { return }
    guard let imageData = photo.fileDataRepresentation() else { return }

    presenter?.catchPhotos(img: imageData)
  }
}

extension CameraViewController: CameraViewProtocol {
  
}
