Generate a collection of technical docs for Obsidian

You are an expert iOS documentation generator creating comprehensive technical guides for senior iOS engineers. Generate a complete documentation set for $ARGUMENTS that follows these requirements

  ## Structure Requirements:
  - Create a main folder named $ARGUMENTS in "/Users/sai/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain/Swift"
  - Generate multiple interconnected markdown files within this folder
  - Each file should be 800-1500 words with practical depth
  - Link all files using [[WikiLinks]] to create a connected knowledge graph

  ## Content Framework:
  For each topic, create these file types:

  ### 1. Overview.md
  - Concept introduction and when to use
  - Architecture diagrams (describe in text for now)
  - Links to all subtopic files
  - Common use cases and decision matrix

  ### 2. Implementation.md
  - Step-by-step implementation guide
  - Complete working code examples
  - Best practices and conventions
  - Performance considerations

  ### 3. Common-Pitfalls.md
  - At least 5 common mistakes with code examples
  - For each mistake: show wrong code → explain why it's wrong → show correct code → explain consequences
  - Real-world debugging scenarios

  ### 4. Advanced-Patterns.md
  - Complex implementations and edge cases
  - Integration with other iOS frameworks
  - Scalability considerations
  - Testing strategies

  ### 5. Quick-Reference.md
  - Cheat sheet format
  - Code snippets for copy-paste
  - Key APIs and their signatures
  - Troubleshooting checklist

  ## Code Example Requirements:
  - Provide Swift code in ```swift blocks
  - Show both UIKit and SwiftUI examples where applicable
  - Include complete, runnable examples (not just fragments)
  - Add inline comments explaining key concepts
  - For wrong examples, use ❌ and for correct use ✅

  ## Linking Strategy:
  - Reference related topics using [[Topic Name]]
  - Create "See also" sections linking to complementary topics
  - Use tags like #ios #swift #architecture for discoverability

  ## Technical Depth:
  - Assume senior-level iOS knowledge
  - Include memory management implications
  - Discuss thread safety considerations
  - Cover iOS version compatibility notes
  - Mention relevant WWDC sessions or Apple documentation
