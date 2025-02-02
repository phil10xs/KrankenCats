This project follows the MVVM (Model-View-ViewModel) architecture, a widely adopted pattern that separates concerns and enhances scalability in mobile applications. The codebase is organised using feature-based folder development, making it easier to manage and maintain as the app grows. This structure allows each feature to be developed, tested, and scaled independently, ensuring modularity and reducing complexity.

For the user interface, SwiftUI was exclusively used to ensure a modern, declarative approach. State management was handled with SwiftUI’s @ObservedObject, @Published, and @State, enabling reactive programming and ensuring the app remains highly responsive as it scales. These tools efficiently synchronise the UI with underlying data changes, providing a dynamic and user-friendly experience.

UI lifecycle management was optimised through SwiftUI lifecycle methods, such as onAppear and onDisappear. These methods effectively manage state transitions and trigger appropriate actions based on user interactions, ensuring smooth navigation and performance.

In-memory storage was implemented using NSCache and NSObject, which allows for quick, temporary data storage. This approach improves performance by reducing redundant network requests or disk I/O operations, enhancing the app's responsiveness.

Concurrency was managed using Swift 5.5's async/await functionality, combined with DispatchQueue. This ensured efficient handling of background tasks without blocking the main thread, allowing the app to remain responsive during complex or time-consuming operations, such as data processing or network requests.

Unit testing was conducted using XCTest to ensure the reliability and stability of the codebase. Tests were written to validate individual components, particularly the ViewModels and business logic, ensuring the app behaves as expected under various scenarios.

To further enhance user experience, navigation transitions were given special attention. Custom animations were implemented to provide a smooth and visually appealing transition between screens, improving the overall feel of the app and offering users a polished, intuitive experience.
