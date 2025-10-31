import UIKit
import AVFoundation
import Vision

class CardReaderLiteViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
  var completion: (([String:Any]) -> Void)?

  private let session = AVCaptureSession()
  private var requests = [VNRequest]()
  private var processed = false

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupCamera()
    setupVision()
  }

  private func setupCamera() {
    session.sessionPreset = .high
    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
          let input = try? AVCaptureDeviceInput(device: device) else { return }

    session.addInput(input)

    let output = AVCaptureVideoDataOutput()
    output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    session.addOutput(output)

    let preview = AVCaptureVideoPreviewLayer(session: session)
    preview.frame = view.bounds
    preview.videoGravity = .resizeAspectFill
    view.layer.addSublayer(preview)

    session.startRunning()
  }

  private func setupVision() {
    let request = VNRecognizeTextRequest { [weak self] req, err in
      if let err = err {
        print("Vision error: \(err)")
        return
      }
      self?.handleRecognizedText(req)
    }
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = false
    requests = [request]
  }

  private func handleRecognizedText(_ request: VNRequest) {
    guard !processed,
          let observations = request.results as? [VNRecognizedTextObservation] else { return }

    let fullText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: " ")

    if let number = extractCardNumber(from: fullText), luhnValid(number) {
      processed = true
      session.stopRunning()

      let expiry = extractExpiry(from: fullText)
      let brand = detectBrand(from: number)

      DispatchQueue.main.async {
        self.dismiss(animated: true) {
          self.completion?([
            "number": number,
            "last4": String(number.suffix(4)),
            "brand": brand,
            "expiryMonth": expiry?.month ?? NSNull(),
            "expiryYear": expiry?.year ?? NSNull()
          ])
        }
      }
    }
  }

  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])
    try? handler.perform(self.requests)
  }

  // --- Helpers simples ---
  func extractCardNumber(from text: String) -> String? {
    let pattern = "\\b\\d{13,19}\\b"
    if let match = text.range(of: pattern, options: .regularExpression) {
      return String(text[match]).replacingOccurrences(of: " ", with: "")
    }
    return nil
  }

  func extractExpiry(from text: String) -> (month: Int, year: Int)? {
    let pattern = "(0[1-9]|1[0-2])/?([0-9]{2,4})"
    if let match = text.range(of: pattern, options: .regularExpression) {
      let sub = String(text[match])
      let parts = sub.split(separator: "/")
      if parts.count == 2, let m = Int(parts[0]), let y = Int(parts[1]) {
        return (m, y < 100 ? 2000 + y : y)
      }
    }
    return nil
  }

  func detectBrand(from number: String) -> String {
    if number.hasPrefix("4") { return "Visa" }
    if number.hasPrefix("5") { return "MasterCard" }
    if number.hasPrefix("3") { return "Amex" }
    return "Unknown"
  }

  func luhnValid(_ number: String) -> Bool {
    let reversed = number.reversed().compactMap { Int(String($0)) }
    var sum = 0
    for (idx, digit) in reversed.enumerated() {
      if idx % 2 == 1 {
        let doubled = digit * 2
        sum += doubled > 9 ? doubled - 9 : doubled
      } else {
        sum += digit
      }
    }
    return sum % 10 == 0
  }
}