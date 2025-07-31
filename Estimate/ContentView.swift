//
//  ContentView.swift
//  Estimate
//
//  Created by Prabhnoor Singh on 7/29/25.
//

import SwiftUI
import AVFoundation
import CoreML
import Vision
import Combine

// MARK: - Color Palette
extension Color {
    static let terracotta = Color(red: 234/255, green: 88/255, blue: 12/255)
    static let warmCream = Color(red: 254/255, green: 243/255, blue: 199/255)
    static let forestGreen = Color(red: 5/255, green: 150/255, blue: 105/255)
    static let softWhite = Color(red: 255/255, green: 251/255, blue: 245/255)
    static let clayBrown = Color(red: 146/255, green: 64/255, blue: 14/255)
    static let sunsetPink = Color(red: 248/255, green: 113/255, blue: 113/255)
}

// MARK: - Font Extensions
extension Font {
    static let friendlyTitle = Font.system(size: 24, weight: .medium, design: .rounded)
    static let warmBody = Font.system(size: 17, weight: .regular, design: .rounded)
    static let encouragingCallout = Font.system(size: 16, weight: .medium, design: .rounded)
}

// MARK: - Content View
struct ContentView: View {
    @StateObject private var viewModel = MidnightLeakViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Warm gradient background
                LinearGradient(
                    colors: [Color.warmCream, Color.softWhite],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    switch viewModel.currentState {
                    case .initial:
                        EntryPointView(viewModel: viewModel)
                    case .capturingPhoto:
                        CameraView(viewModel: viewModel)
                    case .diagnosing:
                        DiagnosingView()
                    case .showingDiagnosis:
                        DiagnosisView(viewModel: viewModel)
                    case .choosingAction:
                        ActionChoiceView(viewModel: viewModel)
                    case .connectingContractor:
                        ContractorConnectionView(viewModel: viewModel)
                    }
                }
            }
        }
    }
}

// MARK: - Entry Point View
struct EntryPointView: View {
    @ObservedObject var viewModel: MidnightLeakViewModel
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Warm illustration placeholder
            Image(systemName: "house.fill")
                .font(.system(size: 80))
                .foregroundColor(.terracotta.opacity(0.3))
                .padding(.bottom, 20)
            
            Text("Your home repair companion.\nAlways on your side.")
                .font(.friendlyTitle)
                .foregroundColor(.clayBrown)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            // Main panic button
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    viewModel.startEmergencyFlow()
                }
            }) {
                Text("Something's Wrong With My Home")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.softWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.terracotta)
                    .cornerRadius(30)
                    .shadow(color: Color.terracotta.opacity(0.3), radius: 12, x: 0, y: 4)
                    .scaleEffect(isPressed ? 0.95 : 1.0)
            }
            .padding(.horizontal, 40)
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity) { isPressing in
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = isPressing
                }
            } perform: {}
            
            Text("24/7 help • Visual diagnosis • Trusted contractors")
                .font(.caption)
                .foregroundColor(.clayBrown.opacity(0.7))
                .padding(.top, 10)
            
            Spacer()
        }
    }
}

// MARK: - Camera View
struct CameraView: View {
    @ObservedObject var viewModel: MidnightLeakViewModel
    @State private var image: UIImage?
    @State private var showingImagePicker = true
    
    var body: some View {
        VStack(spacing: 30) {
            // Reassuring message
            MessageBubble(
                message: "Hi, I'm here to help. Take a deep breath. Let's figure this out together.\n\nCan you show me what's happening?",
                isFromAssistant: true
            )
            
            Spacer()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                Button(action: {
                    viewModel.analyzeImage(image)
                }) {
                    Text("Analyze This")
                        .font(.encouragingCallout)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.forestGreen)
                        .cornerRadius(26)
                }
                .padding(.horizontal, 40)
            } else {
                // Camera button
                Button(action: {
                    showingImagePicker = true
                }) {
                    VStack(spacing: 20) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.terracotta)
                        
                        Text("Point at the problem")
                            .font(.warmBody)
                            .foregroundColor(.clayBrown)
                    }
                    .frame(width: 200, height: 200)
                    .background(Color.warmCream)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.terracotta.opacity(0.3), lineWidth: 2)
                    )
                }
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image, sourceType: .camera)
        }
    }
}

// MARK: - Diagnosing View
struct DiagnosingView: View {
    @State private var dots = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Animated loading indicator
            ProgressView()
                .scaleEffect(1.5)
                .tint(.terracotta)
            
            Text("Analyzing\(dots)")
                .font(.friendlyTitle)
                .foregroundColor(.clayBrown)
            
            Text("I'm looking at what's happening")
                .font(.warmBody)
                .foregroundColor(.clayBrown.opacity(0.7))
            
            Spacer()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                dots = dots.count < 3 ? dots + "." : ""
            }
        }
    }
}

// MARK: - Diagnosis View
struct DiagnosisView: View {
    @ObservedObject var viewModel: MidnightLeakViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Immediate acknowledgment
                MessageBubble(
                    message: "I can see that's stressful! Let me help you right away.",
                    isFromAssistant: true
                )
                
                // Emergency instructions
                VStack(alignment: .leading, spacing: 15) {
                    Text("First, let's make sure you're safe:")
                        .font(.encouragingCallout)
                        .foregroundColor(.clayBrown)
                    
                    EmergencyStepCard(
                        icon: "drop.triangle.fill",
                        title: "Turn off water valve",
                        description: "Look under the sink for the shutoff valve",
                        action: "Show diagram"
                    )
                    
                    Text("This will stop it from getting worse. You're doing great.")
                        .font(.warmBody)
                        .foregroundColor(.forestGreen)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                // Diagnosis details
                DiagnosisCard(
                    issue: "Supply Line Leak",
                    severity: .moderate,
                    cost: "$150-300",
                    timeToFix: "1-2 hours",
                    description: "Super common, happens to everyone"
                )
                
                // Next steps
                Text("What would help you most right now?")
                    .font(.friendlyTitle)
                    .foregroundColor(.clayBrown)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.currentState = .choosingAction
                }) {
                    Text("See my options")
                        .font(.encouragingCallout)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.terracotta)
                        .cornerRadius(26)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Action Choice View
struct ActionChoiceView: View {
    @ObservedObject var viewModel: MidnightLeakViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What would help you most right now?")
                .font(.friendlyTitle)
                .foregroundColor(.clayBrown)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 40)
            
            Spacer()
            
            // Option cards
            OptionCard(
                icon: "wrench.and.screwdriver.fill",
                title: "Connect me with someone who can fix this tomorrow",
                color: .forestGreen
            ) {
                viewModel.currentState = .connectingContractor
            }
            
            OptionCard(
                icon: "book.fill",
                title: "Show me how to temporarily patch this myself",
                color: .terracotta
            ) {
                // DIY flow
            }
            
            OptionCard(
                icon: "message.fill",
                title: "I need to talk through my options",
                color: .sunsetPink
            ) {
                // Chat flow
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Contractor Connection View
struct ContractorConnectionView: View {
    @ObservedObject var viewModel: MidnightLeakViewModel
    @State private var showingSuccess = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                MessageBubble(
                    message: "I found Mike from Chen's Plumbing. He's helped 47 neighbors with exactly this issue.",
                    isFromAssistant: true
                )
                
                // Contractor card
                ContractorCard(
                    name: "Mike Chen",
                    business: "Chen's Plumbing Solutions",
                    rating: 4.9,
                    completedJobs: 47,
                    availability: "Tomorrow at 10 AM",
                    price: "$200-250",
                    profileImage: "person.circle.fill"
                )
                
                Text("The price will be $200-250, which is fair for this repair")
                    .font(.warmBody)
                    .foregroundColor(.clayBrown)
                    .padding(.horizontal)
                
                Text("Should I connect you?")
                    .font(.encouragingCallout)
                    .foregroundColor(.clayBrown)
                    .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Button(action: {
                        withAnimation {
                            showingSuccess = true
                        }
                    }) {
                        Text("Yes, connect us")
                            .font(.encouragingCallout)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.forestGreen)
                            .cornerRadius(26)
                    }
                    
                    Button(action: {
                        // Show alternatives
                    }) {
                        Text("Show alternatives")
                            .font(.encouragingCallout)
                            .foregroundColor(.terracotta)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.warmCream)
                            .cornerRadius(26)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .overlay(
            Group {
                if showingSuccess {
                    SuccessOverlay()
                }
            }
        )
    }
}

// MARK: - Supporting Views
struct MessageBubble: View {
    let message: String
    let isFromAssistant: Bool
    
    var body: some View {
        HStack {
            if !isFromAssistant { Spacer() }
            
            Text(message)
                .font(.warmBody)
                .foregroundColor(isFromAssistant ? .clayBrown : .white)
                .padding()
                .background(
                    isFromAssistant ? Color.warmCream : Color.terracotta
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(
                            isFromAssistant ? Color.terracotta.opacity(0.1) : Color.clear,
                            lineWidth: 1
                        )
                )
            
            if isFromAssistant { Spacer() }
        }
        .padding(.horizontal)
    }
}

struct EmergencyStepCard: View {
    let icon: String
    let title: String
    let description: String
    let action: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.terracotta)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.encouragingCallout)
                    .foregroundColor(.clayBrown)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.clayBrown.opacity(0.7))
            }
            
            Spacer()
            
            Button(action: {
                // Show diagram
            }) {
                Text(action)
                    .font(.caption)
                    .foregroundColor(.terracotta)
                    .underline()
            }
        }
        .padding()
        .background(Color.softWhite)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct DiagnosisCard: View {
    let issue: String
    let severity: Severity
    let cost: String
    let timeToFix: String
    let description: String
    
    enum Severity {
        case low, moderate, high
        
        var color: Color {
            switch self {
            case .low: return .forestGreen
            case .moderate: return .terracotta
            case .high: return .sunsetPink
            }
        }
        
        var text: String {
            switch self {
            case .low: return "Low"
            case .moderate: return "Moderate"
            case .high: return "High"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(issue)
                    .font(.friendlyTitle)
                    .foregroundColor(.clayBrown)
                
                Spacer()
                
                Label(severity.text, systemImage: "exclamationmark.triangle.fill")
                    .font(.caption)
                    .foregroundColor(severity.color)
            }
            
            Text(description)
                .font(.warmBody)
                .foregroundColor(.clayBrown.opacity(0.8))
            
            HStack(spacing: 30) {
                InfoPill(label: "Cost", value: cost, icon: "dollarsign.circle")
                InfoPill(label: "Time", value: timeToFix, icon: "clock")
            }
        }
        .padding()
        .background(Color.softWhite)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }
}

struct InfoPill: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.terracotta)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.clayBrown.opacity(0.6))
                
                Text(value)
                    .font(.encouragingCallout)
                    .foregroundColor(.clayBrown)
            }
        }
    }
}

struct OptionCard: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(color)
                    .frame(width: 50)
                
                Text(title)
                    .font(.warmBody)
                    .foregroundColor(.clayBrown)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.clayBrown.opacity(0.3))
            }
            .padding()
            .background(Color.softWhite)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

struct ContractorCard: View {
    let name: String
    let business: String
    let rating: Double
    let completedJobs: Int
    let availability: String
    let price: String
    let profileImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 15) {
                Image(systemName: profileImage)
                    .font(.system(size: 60))
                    .foregroundColor(.terracotta)
                    .background(Circle().fill(Color.warmCream))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .font(.friendlyTitle)
                        .foregroundColor(.clayBrown)
                    
                    Text(business)
                        .font(.warmBody)
                        .foregroundColor(.clayBrown.opacity(0.7))
                    
                    HStack(spacing: 5) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < Int(rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .foregroundColor(.clayBrown.opacity(0.7))
                    }
                }
                
                Spacer()
            }
            
            HStack(spacing: 30) {
                InfoBadge(icon: "checkmark.shield.fill", text: "\(completedJobs) similar repairs", color: .forestGreen)
                InfoBadge(icon: "clock.fill", text: availability, color: .terracotta)
            }
            
            Divider()
            
            HStack {
                Text("Estimated cost:")
                    .font(.warmBody)
                    .foregroundColor(.clayBrown.opacity(0.7))
                
                Spacer()
                
                Text(price)
                    .font(.friendlyTitle)
                    .foregroundColor(.clayBrown)
            }
        }
        .padding()
        .background(Color.softWhite)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }
}

struct InfoBadge: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.clayBrown)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color.opacity(0.1))
        .cornerRadius(15)
    }
}

struct SuccessOverlay: View {
    @State private var scale = 0.5
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.forestGreen)
                    .scaleEffect(scale)
                
                Text("You're all set!")
                    .font(.friendlyTitle)
                    .foregroundColor(.clayBrown)
                
                Text("Mike will be there tomorrow at 10 AM.\nYou handled that brilliantly!")
                    .font(.warmBody)
                    .foregroundColor(.clayBrown.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
            .padding(40)
            .background(Color.softWhite)
            .cornerRadius(30)
            .shadow(radius: 20)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

// MARK: - View Model
class MidnightLeakViewModel: ObservableObject {
    enum FlowState {
        case initial
        case capturingPhoto
        case diagnosing
        case showingDiagnosis
        case choosingAction
        case connectingContractor
    }
    
    @Published var currentState: FlowState = .initial
    @Published var capturedImage: UIImage?
    @Published var diagnosis: String = ""
    
    func startEmergencyFlow() {
        currentState = .capturingPhoto
    }
    
    func analyzeImage(_ image: UIImage) {
        capturedImage = image
        currentState = .diagnosing
        
        // Simulate AI analysis
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.currentState = .showingDiagnosis
            self.diagnosis = "Supply Line Leak"
        }
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}