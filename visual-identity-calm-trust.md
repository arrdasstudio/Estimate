# EstiMATE Visual Identity: Calm & Trust

## Overview
This visual identity emphasizes serenity, reliability, and professional competence. It creates a calming atmosphere that reduces anxiety while conveying expertise and trustworthiness.

## Color Palette

### Primary Colors
- **Trust Blue**: #2563EB (Primary brand color)
- **Calm Navy**: #1E3A8A (Deep accent)
- **Sky Soft**: #DBEAFE (Light background)
- **Pure White**: #FFFFFF (Base)

### Secondary Colors
- **Sage Green**: #10B981 (Success/positive)
- **Warm Gray**: #6B7280 (Neutral text)
- **Soft Lavender**: #E0E7FF (Subtle accents)
- **Pearl**: #F9FAFB (Alternative background)

### Accent Colors
- **Alert Amber**: #F59E0B (Warnings)
- **Gentle Red**: #EF4444 (Errors, used sparingly)
- **Ocean Teal**: #06B6D4 (Information)

### Semantic Colors
- **Success**: #10B981 (Sage Green)
- **Warning**: #F59E0B (Alert Amber)
- **Error**: #EF4444 (Gentle Red)
- **Info**: #06B6D4 (Ocean Teal)

## Typography

### Font Families
- **Primary**: SF Pro Display (Headers, body)
- **Secondary**: SF Pro Text (UI elements)
- **Monospace**: SF Mono (Prices, codes)

### Type Scale
- **Hero**: 34pt, Bold (Welcome screens)
- **Title 1**: 28pt, Bold (Section headers)
- **Title 2**: 22pt, Semibold (Subsections)
- **Title 3**: 20pt, Medium (Card headers)
- **Body**: 17pt, Regular (Main content)
- **Callout**: 16pt, Medium (Emphasis)
- **Footnote**: 13pt, Regular (Supporting info)
- **Caption**: 12pt, Regular (Labels)

### Text Colors
- **Primary Text**: #1E3A8A (Calm Navy)
- **Secondary Text**: #6B7280 (Warm Gray)
- **Tertiary Text**: #9CA3AF (Light Gray)
- **Link Text**: #2563EB (Trust Blue)

## UI Elements

### Buttons
**Primary Button**
- Background: #2563EB (Trust Blue)
- Text: #FFFFFF (White)
- Corner Radius: 12px
- Height: 50px
- Font: 17pt, Semibold
- Shadow: 0 4px 6px rgba(37, 99, 235, 0.1)

**Secondary Button**
- Background: #E0E7FF (Soft Lavender)
- Text: #2563EB (Trust Blue)
- Border: None
- Corner Radius: 12px
- Height: 50px

**Emergency Button**
- Background: #EF4444 (Gentle Red)
- Text: #FFFFFF (White)
- Corner Radius: 25px
- Height: 56px
- Font: 18pt, Bold

### Cards
- Background: #FFFFFF (White)
- Corner Radius: 16px
- Shadow: 0 2px 8px rgba(0, 0, 0, 0.04)
- Padding: 20px
- Border: 1px solid #F3F4F6

### Form Elements
**Text Fields**
- Background: #F9FAFB (Pearl)
- Border: 1px solid #E5E7EB
- Corner Radius: 8px
- Height: 44px
- Focus Border: #2563EB (Trust Blue)

**Toggle Switches**
- Track Off: #E5E7EB
- Track On: #2563EB
- Thumb: #FFFFFF

### Navigation
**Tab Bar**
- Background: #FFFFFF with blur
- Selected Icon: #2563EB
- Unselected Icon: #9CA3AF
- Badge: #EF4444

**Navigation Bar**
- Background: #FFFFFF
- Title: #1E3A8A
- Buttons: #2563EB

## Icon Style
- **Style**: Outlined, 2px stroke
- **Primary Color**: #2563EB
- **Secondary Color**: #6B7280
- **Size Grid**: 24x24, 32x32, 48x48
- **Corner Radius**: 4px for containers

## Visual Language

### Photography Style
- Bright, natural lighting
- Calm, organized homes
- Professional contractors in clean uniforms
- Soft focus backgrounds
- Warm but not oversaturated colors

### Illustration Style
- Simple, geometric shapes
- Soft gradients using primary palette
- Minimal detail for clarity
- Breathing room around elements
- Subtle animations for delight

### Patterns & Textures
- Subtle geometric patterns for backgrounds
- Soft gradients: Sky to white
- Watercolor-inspired accents
- No harsh lines or aggressive shapes

## Mood & Atmosphere
"Like stepping into a well-organized, sunlit office where a trusted advisor greets you with a warm smile. Everything feels intentional, calm, and under control. The space breathes confidence without intimidation."

## Implementation Notes for iOS

### SwiftUI Color Extensions
```swift
extension Color {
    static let trustBlue = Color(hex: "2563EB")
    static let calmNavy = Color(hex: "1E3A8A")
    static let skySoft = Color(hex: "DBEAFE")
    static let sageGreen = Color(hex: "10B981")
    static let warmGray = Color(hex: "6B7280")
}
```

### Spacing System
- Base unit: 4px
- Common spacings: 8, 12, 16, 20, 24, 32, 48

### Animation Guidelines
- Duration: 0.3s for standard transitions
- Easing: Spring with 0.8 damping
- Subtle scale effects on tap (0.95)

### Accessibility
- All text maintains WCAG AA contrast
- Minimum touch targets: 44x44
- Color not sole indicator of state

## Example Use Cases

### Emergency Screen
- Background: Subtle gradient from #DBEAFE to #FFFFFF
- Emergency button prominent with #EF4444
- Calming blue accents throughout
- Clear, spacious layout

### Contractor Profile
- White card with subtle shadow
- Trust Blue for verified badges
- Sage Green for ratings
- Professional photography style

### Chat Interface
- Light gray message bubbles for AI
- Trust Blue bubbles for user
- Soft transitions between states
- Typing indicators in Soft Lavender