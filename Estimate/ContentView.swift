import SwiftUI
import PhotosUI

// MARK: - Data Models
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp = Date()
}

struct DIYStep: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let time: String
    var isCompleted: Bool = false
}

// MARK: - Predefined Responses
struct PredefinedResponses {
    static let initial = "That sounds stressful! Water leaks can definitely cause anxiety. Let me help you figure this out. Can you show me a photo of where the water is coming from? This will help me give you the most accurate advice."
    
    static let diagnosis = DiagnosisInfo(
        title: "Supply Line Leak",
        icon: "🔧",
        time: "20-30 min",
        difficulty: "Easy",
        cost: "$5-15",
        description: "Good news! This is a common issue that's actually pretty simple to fix yourself. The supply line is just the flexible tube that connects your water valve to your faucet. You'll just need some towels and possibly a new supply line from the hardware store."
    )
    
    static let afterDiagnosis = "So this is definitely fixable! What would be most helpful right now?"
    
    static let proQuote = ProQuote(
        laborCost: "$120-150",
        partsCost: "$30-50",
        totalRange: "$150-200",
        time: "1-2 hours",
        description: "This includes the plumber's diagnostic fee, labor, and parts. Most plumbers have a minimum charge of about $100-150 just to come out."
    )
    
    static let steps = [
        DIYStep(
            title: "Turn off the water valve under the sink",
            description: "Look for a knob or lever and turn it clockwise (righty-tighty). This stops water flow immediately.",
            time: "1 minute"
        ),
        DIYStep(
            title: "Place towels or a bucket under the leak",
            description: "This catches any remaining water. Don't worry if it's still dripping a bit - that's just water left in the pipes.",
            time: "2 minutes"
        ),
        DIYStep(
            title: "Check if it's the connection or the line itself",
            description: "If water is coming from where the line connects, try tightening it by hand. If the line has a hole, you'll need a replacement ($5-10 at any hardware store).",
            time: "2 minutes"
        ),
        DIYStep(
            title: "Optional: Replace the supply line",
            description: "Unscrew the old line (lefty-loosey), take it to the hardware store to match size, and screw in the new one. Hand-tight plus 1/4 turn with pliers.",
            time: "15-20 minutes including store trip"
        )
    ]
    
    static let encouragement = "You're doing great! You just saved yourself about $150-200 in plumber fees. If you run into any issues, I'm here to help!"
}

struct DiagnosisInfo {
    let title: String
    let icon: String
    let time: String
    let difficulty: String
    let cost: String
    let description: String
}

struct ProQuote {
    let laborCost: String
    let partsCost: String
    let totalRange: String
    let time: String
    let description: String
}

// MARK: - Color Extensions
extension Color {
    static let warmCream = Color(red: 254/255, green: 243/255, blue: 199/255)
    static let terracotta = Color(red: 234/255, green: 88/255, blue: 12/255)
    static let forestGreen = Color(red: 5/255, green: 150/255, blue: 105/255)
    static let softWhite = Color(red: 255/255, green: 251/255, blue: 245/255)
    static let clayBrown = Color(red: 146/255, green: 64/255, blue: 14/255)
}

// MARK: - Main View
struct ContentView: View {
    @State private var currentScreen = 1
    @State private var messages: [Message] = []
    @State private var userInput = ""
    @State private var showTyping = false
    @State private var capturedImage: UIImage?
    @State private var showCamera = false
    @State private var showQuickOptions = false
    @State private var diySteps: [DIYStep] = PredefinedResponses.steps
    @State private var completedSteps = 0
    @State private var showEncouragement = false
    @State private var isRecording = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.warmCream, Color.softWhite],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Dynamic content based on screen
                switch currentScreen {
                case 1:
                    InitialGreetingScreen(
                        messages: $messages,
                        userInput: $userInput,
                        showTyping: $showTyping,
                        currentScreen: $currentScreen,
                        isRecording: $isRecording
                    )
                case 2:
                    PhotoOptionsScreen(
                        messages: $messages,
                        currentScreen: $currentScreen,
                        showCamera: $showCamera,
                        capturedImage: $capturedImage
                    )
                case 3:
                    CameraScreen(
                        capturedImage: $capturedImage,
                        currentScreen: $currentScreen
                    )
                case 4:
                    AnalyzingScreen(
                        currentScreen: $currentScreen
                    )
                case 5:
                    DiagnosisScreen(
                        messages: $messages,
                        currentScreen: $currentScreen,
                        showQuickOptions: $showQuickOptions,
                        userInput: $userInput,
                        showTyping: $showTyping,
                        isRecording: $isRecording
                    )
                case 6:
                    DIYStepsScreen(
                        steps: $diySteps,
                        completedSteps: $completedSteps,
                        showEncouragement: $showEncouragement
                    )
                default:
                    InitialGreetingScreen(
                        messages: $messages,
                        userInput: $userInput,
                        showTyping: $showTyping,
                        currentScreen: $currentScreen,
                        isRecording: $isRecording
                    )
                }
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(image: $capturedImage)
                .onDisappear {
                    if capturedImage != nil {
                        currentScreen = 4
                        // Simulate analysis
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            currentScreen = 5
                            showQuickOptions = true
                        }
                    }
                }
        }
    }
}

// MARK: - Screen 1: Enhanced Home Screen
struct InitialGreetingScreen: View {
    @Binding var messages: [Message]
    @Binding var userInput: String
    @Binding var showTyping: Bool
    @Binding var currentScreen: Int
    @Binding var isRecording: Bool
    @FocusState private var isInputFocused: Bool
    @State private var inputText = ""
    @State private var isPulsing = true
    @State private var selectedSuggestion: String? = nil
    @State private var showingSuggestions = true
    
    private let suggestions = [
        "💧 Water leak under sink",
        "💡 Electrical outlet not working", 
        "🚪 Door won't close properly",
        "🚿 Low water pressure",
        "🔥 Heater making strange noise"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation Bar
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20))
                    .foregroundColor(.clayBrown)
                
                Spacer()
                
                Text("EstiMATE")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.clayBrown)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.clayBrown)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 16)
            
            // Progress Indicator
            VStack(spacing: 8) {
                HStack {
                    Text("Progress")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.clayBrown.opacity(0.7))
                    
                    Spacer()
                    
                    Text("1 of 6")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.clayBrown.opacity(0.7))
                }
                
                ProgressView(value: 1, total: 6)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(.terracotta)
                    .scaleEffect(y: 2)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Welcome Section
                    VStack(spacing: 16) {
                        Text("👋")
                            .font(.system(size: 48))
                        
                        VStack(spacing: 8) {
                            Text("Hi Amanda!")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.clayBrown)
                            
                            Text("What's happening at home?")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.clayBrown.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Smart Suggestions (only show if no messages)
                    if messages.isEmpty && showingSuggestions {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "lightbulb")
                                    .font(.system(size: 16))
                                    .foregroundColor(.terracotta)
                                
                                Text("Common Issues")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.clayBrown)
                                
                                Spacer()
                            }
                            
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                                ForEach(suggestions, id: \.self) { suggestion in
                                    Button(action: {
                                        selectedSuggestion = suggestion
                                        inputText = String(suggestion.dropFirst(2)) // Remove emoji
                                        handleSuggestionTap(suggestion)
                                    }) {
                                        HStack {
                                            Text(suggestion)
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundColor(.clayBrown)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right.circle.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.terracotta)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 14)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.softWhite)
                                                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedSuggestion == suggestion ? Color.terracotta : Color.clear, lineWidth: 2)
                                        )
                                    }
                                    .scaleEffect(selectedSuggestion == suggestion ? 0.98 : 1)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedSuggestion)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                    // Chat Messages
                    if !messages.isEmpty {
                        VStack(spacing: 16) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                            
                            if showTyping {
                                TypingIndicator()
                            }
                        }
                        .padding(.horizontal, 20)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }
            
            Spacer()
            
            // Enhanced Input Section
            VStack(spacing: 16) {
                // Quick Action Buttons (only show when no conversation started)
                if messages.isEmpty {
                    HStack(spacing: 12) {
                        Button(action: {
                            // Handle voice input
                            isRecording.toggle()
                            if !isRecording {
                                inputText = "I've got water leaking under my kitchen sink"
                                isInputFocused = true
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "mic.fill")
                                    .font(.system(size: 16))
                                Text("Voice")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(isRecording ? .white : .terracotta)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(isRecording ? Color.red : Color.terracotta.opacity(0.1))
                            )
                        }
                        
                        Button(action: {
                            // Handle photo input
                            currentScreen = 2
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 16))
                                Text("Photo")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.terracotta)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.terracotta.opacity(0.1))
                            )
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                
                // Input Field with Floating Label
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.clayBrown.opacity(0.1))
                    
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            if isInputFocused || !inputText.isEmpty {
                                Text("Describe your problem")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.terracotta)
                                    .transition(.opacity)
                            }
                            
                            TextField(isInputFocused || !inputText.isEmpty ? "" : "💬 Describe your problem...", text: $inputText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.system(size: 16))
                                .foregroundColor(.clayBrown)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.warmCream)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(
                                            isInputFocused ? Color.terracotta : 
                                            isPulsing && inputText.isEmpty ? Color.terracotta.opacity(0.3) : Color.clear, 
                                            lineWidth: 2
                                        )
                                        .scaleEffect(isPulsing && inputText.isEmpty && !isInputFocused ? 1.02 : 1)
                                        .animation(
                                            isPulsing && inputText.isEmpty && !isInputFocused ? 
                                            .easeInOut(duration: 2).repeatForever(autoreverses: true) : .default, 
                                            value: isPulsing
                                        )
                                )
                        )
                        .focused($isInputFocused)
                        .onSubmit {
                            if !inputText.isEmpty {
                                handleUserInput(inputText)
                            }
                        }
                        
                        // Send Button (appears when typing)
                        if !inputText.isEmpty {
                            Button(action: {
                                if !inputText.isEmpty {
                                    handleUserInput(inputText)
                                }
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.terracotta)
                            }
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.softWhite)
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: messages.isEmpty)
        .animation(.easeInOut(duration: 0.3), value: isInputFocused)
    }
    
    private func handleSuggestionTap(_ suggestion: String) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            showingSuggestions = false
            selectedSuggestion = suggestion
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            handleUserInput(String(suggestion.dropFirst(2))) // Remove emoji
        }
    }
    
    private func handleUserInput(_ text: String) {
        isPulsing = false
        userInput = text
        inputText = ""
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            showingSuggestions = false
        }
        
        // Add user message
        messages.append(Message(text: text, isUser: true))
        
        // Show typing
        showTyping = true
        
        // Simulate response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showTyping = false
            messages.append(Message(text: PredefinedResponses.initial, isUser: false))
            
            // Move to photo options after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                currentScreen = 2
            }
        }
    }
}

// MARK: - Screen 2: Photo Options
struct PhotoOptionsScreen: View {
    @Binding var messages: [Message]
    @Binding var currentScreen: Int
    @Binding var showCamera: Bool
    @Binding var capturedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            // Chat container
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding()
            }
            
            // Options
            HStack(spacing: 16) {
                Button(action: {
                    showCamera = true
                }) {
                    Label("Take Photo", systemImage: "camera.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.forestGreen)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    // Handle text description
                }) {
                    Text("Just Describe")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.clayBrown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.warmCream)
                        .cornerRadius(20)
                }
            }
            .padding()
            .background(Color.white)
        }
    }
}

// MARK: - Screen 3: Camera
struct CameraScreen: View {
    @Binding var capturedImage: UIImage?
    @Binding var currentScreen: Int
    @State private var showCamera = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Point at the problem and snap a photo")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(16)
                    .padding(.top, 60)
                
                Spacer()
                
                Image(systemName: "camera.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white.opacity(0.3))
                
                Spacer()
                
                Button(action: {
                    // Camera capture handled by ImagePicker
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(Color.terracotta, lineWidth: 4)
                                .frame(width: 72, height: 72)
                        )
                }
                .padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(image: $capturedImage)
        }
    }
}

// MARK: - Screen 4: Analyzing
struct AnalyzingScreen: View {
    @Binding var currentScreen: Int
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Spinner
            Circle()
                .stroke(Color.warmCream, lineWidth: 4)
                .frame(width: 60, height: 60)
                .overlay(
                    Circle()
                        .trim(from: 0, to: 0.3)
                        .stroke(Color.terracotta, lineWidth: 4)
                        .rotationEffect(Angle(degrees: rotation))
                        .onAppear {
                            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                                rotation = 360
                            }
                        }
                )
            
            Text("Analyzing your photo...")
                .font(.system(size: 18))
                .foregroundColor(.clayBrown)
            
            Spacer()
        }
    }
}

// MARK: - Screen 5: Diagnosis with Chat
struct DiagnosisScreen: View {
    @Binding var messages: [Message]
    @Binding var currentScreen: Int
    @Binding var showQuickOptions: Bool
    @Binding var userInput: String
    @Binding var showTyping: Bool
    @Binding var isRecording: Bool
    @State private var inputText = ""
    @State private var showDiagnosisCard = true
    
    var body: some View {
        VStack(spacing: 0) {
            // Chat container
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        if showDiagnosisCard {
                            DiagnosisCard()
                        }
                        
                        Text(PredefinedResponses.afterDiagnosis)
                            .font(.body)
                            .foregroundColor(.clayBrown)
                            .padding()
                            .background(Color.warmCream)
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(messages.filter { $0.timestamp > Date().addingTimeInterval(-60) }) { message in
                            MessageBubble(message: message)
                        }
                        
                        if showTyping {
                            TypingIndicator()
                        }
                    }
                    .padding()
                }
            }
            
            // Quick options
            if showQuickOptions {
                HStack(spacing: 10) {
                    Button(action: {
                        showQuickOptions = false
                        messages.append(Message(text: "DIY Steps 🔧", isUser: true))
                        currentScreen = 6
                    }) {
                        Label("DIY Steps", systemImage: "wrench.fill")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.forestGreen)
                            .cornerRadius(20)
                    }
                    
                    Button(action: {
                        showQuickOptions = false
                        messages.append(Message(text: "Get Pro Quote 💰", isUser: true))
                        showProQuote()
                    }) {
                        Label("Get Pro Quote", systemImage: "dollarsign.circle")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.clayBrown)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.warmCream)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            // Input area
            VStack(spacing: 10) {
                if showQuickOptions {
                    Text("Or just tell me what's on your mind...")
                        .font(.system(size: 14))
                        .foregroundColor(.clayBrown.opacity(0.6))
                }
                
                HStack(spacing: 12) {
                    TextField("Ask me anything...", text: $inputText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.warmCream)
                        .cornerRadius(25)
                        .onSubmit {
                            if !inputText.isEmpty {
                                handleDiagnosisInput(inputText)
                            }
                        }
                    
                    Button(action: {
                        isRecording.toggle()
                    }) {
                        Image(systemName: "mic.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(isRecording ? Color.red : Color.terracotta)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
            .background(Color.white)
        }
    }
    
    private func handleDiagnosisInput(_ text: String) {
        messages.append(Message(text: text, isUser: true))
        inputText = ""
        showTyping = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showTyping = false
            // Simple response logic based on keywords
            let response = getResponseForInput(text)
            messages.append(Message(text: response, isUser: false))
        }
    }
    
    private func getResponseForInput(_ input: String) -> String {
        let lowercased = input.lowercased()
        
        if lowercased.contains("valve") || lowercased.contains("wrong") {
            return "No worries! Look for the main shutoff - it's usually a larger valve near where the water line comes into the house. Or just turn off the main water supply temporarily. Better safe than sorry!"
        } else if lowercased.contains("still leak") || lowercased.contains("still dripping") {
            return "That's okay! Sometimes it takes a minute for the water to stop completely. If it's still actively flowing, double-check that the valve is turned all the way clockwise. You can also try the main water shutoff."
        } else if lowercased.contains("scared") || lowercased.contains("worried") || lowercased.contains("nervous") {
            return "I totally understand - home repairs can feel overwhelming! Remember, you're not going to break anything. Water valves are designed to be turned on and off. Take your time, and I'm here to guide you through each step."
        } else if lowercased.contains("can't find") || lowercased.contains("where") {
            return "No problem! Send me a photo of under your sink and I'll help you spot it. In the meantime, you can place a bucket under the leak to catch the water. The valve is usually a small knob or lever connected to the pipes."
        } else {
            return "I understand your concern. Let me help you with that. Feel free to ask me anything specific about the repair or if you need clarification on any step."
        }
    }
    
    private func showProQuote() {
        // Would show pro quote card in messages
    }
}

// MARK: - Screen 6: DIY Steps
struct DIYStepsScreen: View {
    @Binding var steps: [DIYStep]
    @Binding var completedSteps: Int
    @Binding var showEncouragement: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 10) {
                Text("Let's fix this together!")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.clayBrown)
                
                HStack(spacing: 6) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 14))
                    Text("About 20-30 minutes")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.forestGreen)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.forestGreen.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
            
            // Steps
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(steps.indices, id: \.self) { index in
                        StepRow(
                            step: $steps[index],
                            onToggle: {
                                if !steps[index].isCompleted {
                                    steps[index].isCompleted = true
                                    completedSteps += 1
                                    
                                    if completedSteps == steps.count {
                                        showEncouragement = true
                                    }
                                }
                            }
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .opacity
                        ))
                        .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.1), value: steps)
                    }
                    
                    if showEncouragement {
                        EncouragementCard()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.spring(), value: showEncouragement)
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Supporting Views
struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.isUser ? Color.terracotta : Color.warmCream)
                .foregroundColor(message.isUser ? .white : .clayBrown)
                .cornerRadius(20)
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}

struct TypingIndicator: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.clayBrown)
                    .frame(width: 8, height: 8)
                    .offset(y: animationAmount)
                    .animation(
                        .easeInOut(duration: 0.5)
                        .repeatForever()
                        .delay(Double(index) * 0.2),
                        value: animationAmount
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.warmCream)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            animationAmount = -10
        }
    }
}

struct DiagnosisCard: View {
    let diagnosis = PredefinedResponses.diagnosis
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Text(diagnosis.icon)
                    .font(.system(size: 48))
                    .frame(width: 48, height: 48)
                    .background(Color.warmCream)
                    .clipShape(Circle())
                
                Text(diagnosis.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.clayBrown)
            }
            
            HStack(spacing: 16) {
                DetailItem(label: "DIY Time", value: diagnosis.time)
                DetailItem(label: "Difficulty", value: diagnosis.difficulty)
                DetailItem(label: "Cost", value: diagnosis.cost)
            }
            
            Text(diagnosis.description)
                .font(.body)
                .foregroundColor(.clayBrown.opacity(0.8))
                .lineSpacing(4)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 16)
    }
}

struct DetailItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.clayBrown.opacity(0.7))
            
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.clayBrown)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.softWhite)
        .cornerRadius(12)
    }
}

struct StepRow: View {
    @Binding var step: DIYStep
    let onToggle: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Button(action: onToggle) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(step.isCompleted ? Color.forestGreen : Color.terracotta, lineWidth: 2)
                        .frame(width: 24, height: 24)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(step.isCompleted ? Color.forestGreen : Color.clear)
                        )
                    
                    if step.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.clayBrown)
                
                Text(step.description)
                    .font(.system(size: 14))
                    .foregroundColor(.clayBrown.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
                
                if !step.time.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                        Text(step.time)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.forestGreen)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.forestGreen.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.top, 4)
                }
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8)
    }
}

struct EncouragementCard: View {
    var body: some View {
        Text(PredefinedResponses.encouragement)
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.forestGreen)
            .cornerRadius(20)
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
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

#Preview {
    ContentView()
}