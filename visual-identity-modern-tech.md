# EstiMATE Visual Identity: Modern Technology & Efficiency

## Overview
This visual identity embraces cutting-edge technology and AI-forward design. It projects innovation, efficiency, and precision while maintaining approachability through playful neon accents.

## Color Palette

### Primary Colors
- **Electric Purple**: #8B5CF6 (Primary brand color)
- **Deep Space**: #1E1B4B (Dark mode base)
- **Neon Lime**: #84CC16 (Energy accent)
- **Crystal White**: #FAFAFA (Light mode base)

### Secondary Colors
- **Cyber Pink**: #EC4899 (Alert accent)
- **Tech Blue**: #3B82F6 (Information)
- **Carbon**: #18181B (Text primary)
- **Silver**: #E4E4E7 (Borders)

### Accent Colors
- **Glow Green**: #10F896 (Success states)
- **Warning Orange**: #F97316 (Caution)
- **Error Red**: #F43F5E (Critical)
- **Ice Blue**: #67E8F9 (Cool accent)

### Gradient Combinations
- **Primary Gradient**: #8B5CF6 → #EC4899
- **Success Gradient**: #84CC16 → #10F896
- **Dark Gradient**: #1E1B4B → #312E81

### Semantic Colors
- **Success**: #10F896 (Glow Green)
- **Warning**: #F97316 (Warning Orange)
- **Error**: #F43F5E (Error Red)
- **Info**: #3B82F6 (Tech Blue)

## Typography

### Font Families
- **Primary**: SF Pro Display (Bold weights preferred)
- **Secondary**: SF Mono (Data, prices)
- **Display**: SF Pro Display Black (Hero text)

### Type Scale
- **Hero**: 40pt, Black (Landing screens)
- **Title 1**: 32pt, Bold (Main headers)
- **Title 2**: 24pt, Bold (Section headers)
- **Title 3**: 20pt, Semibold (Cards)
- **Body**: 16pt, Medium (Content)
- **Data**: 14pt, SF Mono Medium (Metrics)
- **Caption**: 12pt, Medium (Labels)
- **Micro**: 10pt, Semibold (Badges)

### Text Colors
- **Primary Text**: #18181B (Carbon)
- **Secondary Text**: #71717A (Gray)
- **Inverse Text**: #FAFAFA (On dark)
- **Accent Text**: #8B5CF6 (Links)

## UI Elements

### Buttons
**Primary Button**
- Background: Linear gradient #8B5CF6 → #EC4899
- Text: #FFFFFF (White)
- Corner Radius: 8px
- Height: 48px
- Font: 16pt, Bold
- Glow: 0 0 24px rgba(139, 92, 246, 0.5)
- Hover: Scale 1.02

**Secondary Button**
- Background: rgba(139, 92, 246, 0.1)
- Text: #8B5CF6
- Border: 2px solid #8B5CF6
- Corner Radius: 8px
- Height: 48px

**Emergency Button**
- Background: #F43F5E with pulse animation
- Text: #FFFFFF
- Corner Radius: 24px
- Height: 56px
- Font: 18pt, Black

### Cards
- Background: #FFFFFF (Light) / #27272A (Dark)
- Corner Radius: 12px
- Border: 1px solid rgba(139, 92, 246, 0.2)
- Shadow: 0 4px 24px rgba(0, 0, 0, 0.06)
- Hover: Border glows #8B5CF6

### Form Elements
**Text Fields**
- Background: #F4F4F5 (Light) / #18181B (Dark)
- Border: 2px solid transparent
- Corner Radius: 8px
- Height: 44px
- Focus: Border #8B5CF6 with glow

**Toggle Switches**
- Track Off: #71717A
- Track On: Linear gradient #8B5CF6 → #EC4899
- Thumb: #FFFFFF with subtle shadow

### Data Visualization
- **Charts**: Neon gradients on dark backgrounds
- **Progress**: Animated gradient fills
- **Metrics**: SF Mono with glow effects

### Navigation
**Tab Bar**
- Background: Frosted glass effect
- Selected: #8B5CF6 with glow
- Unselected: #71717A
- Indicator: Animated underline

**Navigation Bar**
- Background: Blur with #FAFAFA/95%
- Title: #18181B, Bold
- Actions: #8B5CF6

## Icon Style
- **Style**: Filled with rounded corners
- **Primary**: #8B5CF6
- **Secondary**: #71717A
- **Active**: Gradient fill + glow
- **Size Grid**: 20x20, 28x28, 40x40
- **Animation**: Subtle rotation on interaction

## Visual Language

### Photography Style
- High contrast, dramatic lighting
- Tech-forward environments
- Modern tools and devices
- Blurred backgrounds with bokeh
- Cool color temperature

### Illustration Style
- Isometric 3D elements
- Neon outlines on dark
- Geometric patterns
- Circuit board motifs
- Holographic effects

### Patterns & Textures
- Grid patterns with glow nodes
- Gradient meshes
- Tech-inspired line work
- Particle effects for loading
- Glass morphism elements

## Mood & Atmosphere
"Like entering a state-of-the-art command center where AI assistants anticipate your needs. Surfaces glow with subtle neon accents, data flows seamlessly, and every interaction feels precise and powerful. The future of home repair, today."

## Implementation Notes for iOS

### SwiftUI Gradient Extension
```swift
extension LinearGradient {
    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "8B5CF6"), Color(hex: "EC4899")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
```

### Animation Presets
- **Bounce**: Spring(response: 0.4, dampingFraction: 0.6)
- **Smooth**: Animation.easeInOut(duration: 0.3)
- **Quick**: Animation.easeOut(duration: 0.2)

### Dark Mode Considerations
- Automatic color switching
- Increased contrast in dark mode
- Neon effects more prominent
- Reduced white point

### Performance
- Limit gradient animations
- Cache complex shadows
- Use Metal for particle effects

## Example Use Cases

### AI Diagnosis Screen
- Dark background #1E1B4B
- Animated gradient scanner effect
- Neon green success indicators
- Data displayed in SF Mono
- Particle effects during analysis

### Dashboard
- Card-based layout with glass effect
- Live data with glow animations
- Purple gradient for CTAs
- Tech blue for information
- Micro-interactions on all elements

### Emergency Mode
- Full screen red gradient alert
- Pulsing emergency button
- White text for maximum contrast
- Simplified UI for clarity
- Location beacon animation

### Contractor Matching
- Animated connection lines
- Profile cards with hover effects
- Match percentage in neon green
- Tech-inspired loading sequence
- Swipe gestures with trail effects