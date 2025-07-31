# EstiMATE Visual Identity: Warmth & Human Connection

## Overview
This visual identity prioritizes human warmth, community, and approachability. It creates a neighborhood feeling where technology serves relationships, not the other way around.

## Color Palette

### Primary Colors
- **Terracotta**: #EA580C (Primary brand color)
- **Warm Cream**: #FEF3C7 (Light base)
- **Forest Green**: #059669 (Trust accent)
- **Soft White**: #FFFBF5 (Background)

### Secondary Colors
- **Sunset Pink**: #F87171 (Friendly accent)
- **Clay Brown**: #92400E (Grounding color)
- **Sky Blue**: #60A5FA (Optimism)
- **Sage**: #86EFAC (Growth)

### Accent Colors
- **Honey Gold**: #FCD34D (Highlights)
- **Dusty Rose**: #FDA4AF (Gentle alerts)
- **Ocean**: #06B6D4 (Information)
- **Lavender**: #C7D2FE (Calm moments)

### Earth Tones
- **Sand**: #FDE68A (Subtle highlights)
- **Stone**: #D6D3D1 (Neutral elements)
- **Moss**: #84CC16 (Natural success)
- **Adobe**: #DC2626 (Warm warnings)

### Semantic Colors
- **Success**: #059669 (Forest Green)
- **Warning**: #F59E0B (Amber)
- **Error**: #DC2626 (Adobe - warm, not harsh)
- **Info**: #60A5FA (Sky Blue)

## Typography

### Font Families
- **Primary**: SF Pro Rounded (Friendly, approachable)
- **Secondary**: SF Pro Text (Body text)
- **Accent**: Georgia (Quotes, testimonials)

### Type Scale
- **Hero**: 36pt, Bold (Welcoming)
- **Title 1**: 30pt, Semibold (Friendly headers)
- **Title 2**: 24pt, Medium (Sections)
- **Title 3**: 20pt, Medium (Cards)
- **Body**: 17pt, Regular (Comfortable reading)
- **Callout**: 16pt, Medium (Gentle emphasis)
- **Quote**: 18pt, Georgia Italic
- **Caption**: 14pt, Regular (Soft labels)

### Text Colors
- **Primary Text**: #451A03 (Rich Brown)
- **Secondary Text**: #92400E (Clay Brown)
- **Tertiary Text**: #78716C (Warm Gray)
- **Link Text**: #EA580C (Terracotta)

## UI Elements

### Buttons
**Primary Button**
- Background: #EA580C (Terracotta)
- Text: #FFFBF5 (Soft White)
- Corner Radius: 20px (Very rounded)
- Height: 52px
- Font: 17pt, Semibold
- Shadow: 0 4px 12px rgba(234, 88, 12, 0.2)

**Secondary Button**
- Background: #FEF3C7 (Warm Cream)
- Text: #EA580C (Terracotta)
- Border: None
- Corner Radius: 20px
- Height: 52px

**Help Button**
- Background: #059669 (Forest Green)
- Text: #FFFBF5
- Corner Radius: 26px (Pill shape)
- Height: 52px
- Icon: Heart or Hands

### Cards
- Background: #FFFBF5 (Soft White)
- Corner Radius: 20px
- Shadow: 0 8px 24px rgba(0, 0, 0, 0.06)
- Padding: 24px
- Border: None (shadow only)

### Form Elements
**Text Fields**
- Background: #FEF3C7 (Warm Cream)
- Border: 2px solid transparent
- Corner Radius: 12px
- Height: 48px
- Focus: Border #EA580C
- Placeholder: #92400E

**Toggle Switches**
- Track Off: #E7E5E4
- Track On: #059669
- Thumb: #FFFBF5
- Rounded ends

### Community Elements
**Profile Avatars**
- Circle shape
- 3px border in #EA580C
- Warm filter on photos
- Group overlapping for teams

**Rating Stars**
- Filled: #FCD34D (Honey Gold)
- Empty: #FEF3C7
- Rounded points

## Icon Style
- **Style**: Rounded, chunky strokes (3px)
- **Primary Color**: #EA580C
- **Secondary Color**: #059669
- **Style**: Hand-drawn quality
- **Size Grid**: 24x24, 32x32, 48x48
- **Personality**: Friendly, imperfect

## Visual Language

### Photography Style
- Golden hour lighting
- Real people, genuine smiles
- Homey, lived-in spaces
- Warm color grading
- Environmental portraits
- Community moments

### Illustration Style
- Hand-drawn elements
- Watercolor textures
- Organic shapes
- Botanical accents
- Warm gradients
- Storybook quality

### Patterns & Textures
- Subtle paper texture
- Organic dots and dashes
- Leaf patterns
- Woven/fabric textures
- Hand-drawn borders

## Mood & Atmosphere
"Like walking into your favorite neighborhood coffee shop where the barista knows your name. Warm wood, plants in the window, the smell of fresh bread, and that friend who always has great advice. Technology that feels like a warm hug."

## Implementation Notes for iOS

### SwiftUI Extensions
```swift
extension Font {
    static let friendlyTitle = Font.system(
        size: 24, 
        weight: .medium, 
        design: .rounded
    )
    static let warmBody = Font.system(
        size: 17, 
        weight: .regular, 
        design: .rounded
    )
}
```

### Corner Radius System
- Small: 8px (Tags)
- Medium: 12px (Inputs)
- Large: 20px (Cards, buttons)
- XLarge: 26px (Pills)

### Animation Guidelines
- Duration: 0.4s (Slower, organic)
- Easing: Ease-in-out
- Subtle bounces on success
- Gentle fade transitions

### Accessibility
- High contrast maintained
- Larger touch targets (52px)
- Clear focus indicators
- Reduced motion options

## Example Use Cases

### Welcome Screen
- Warm gradient background (#FEF3C7 to #FFFBF5)
- Hand-drawn home illustration
- Terracotta welcome button
- Friendly, conversational copy

### Contractor Profile
- Circular photo with warm border
- Green verified badge
- Star ratings in honey gold
- Personal bio in Georgia font
- "Message" button in forest green

### Chat Interface
- Cream background
- Rounded message bubbles
- Contractor messages in white
- User messages in light terracotta
- Emoji reactions encouraged

### Community Feed
- Card-based success stories
- Profile pictures prominent
- Warm testimonial quotes
- Heart reactions in sunset pink
- Share buttons in sky blue

### Help Center
- Illustrated category cards
- Hand-drawn icons
- FAQ in conversational tone
- Video tutorials with warm overlay
- Community expert badges