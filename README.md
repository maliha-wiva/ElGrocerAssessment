# Assessment

This app demonstrates the use of UICollectionViewCompositionalLayout with MVVM architecture in Swift that demonstrates key competencies in authentication, navigation, and dynamic user interface updates, following best practices in iOS development.

## 🚀 Features

### 🔐 Authentication
- Login screen with simple form validation.
- Auth token is securely stored in **Keychain** after successful login.
- User session persists across app restarts (unless app is freshly installed).

### 🏠 Home Screen (UICollectionViewCompositionalLayout)
Structured into 3 distinct sections:

1. **Banner Section**
   - Positioned at the top of the screen.
   - Auto-sliding banners using `Timer`.

2. **Categories Section**
   - Horizontally scrollable.
   - 4 items per row, 2 rows total.
   - Supports dynamic resizing and padding.

3. **Products Section**
   - Vertically scrollable.
   - 2 products per row, at least 20 items.
   - Smooth scrolling and async image loading.

### 🔧 Architecture & Code Practices

- **MVVM Architecture** with clear separation of concerns.
- **Combine / async/await** for reactive and modern async code.
- **Dependency Injection** for testability and modularity.
- **All UI built programmatically** (no Storyboards/XIBs).
- **Mock API simulation** using `DispatchQueue.main.asyncAfter(...)`.

---

## 🧪 Technical Highlights

| Feature                     | Description                                      |
|----------------------------|--------------------------------------------------|
| Compositional Layout       | Used to design flexible and complex UIs         |
| Keychain                   | Stores token securely after login               |
| Mock Networking            | Simulated API delay using timers                |
| Async/Await & Combine      | Efficient data flow and UI updates              |
| Dependency Injection       | Improves testability and code modularity        |

---

## 🧾 Fresh Install Behavior (Important Note)

This app uses **Keychain** to persist authentication tokens for security. However, by default, Keychain data **is not removed** when the app is deleted.

As a result, when the app is reinstalled, it still retrieves the previous token, and directly navigates to the Home screen.

🛠 **Possible Enhancement (Not Implemented):**
To handle this in a real-world app, we could combine a `UserDefaults` flag (e.g. `hasLaunchedBefore`) with Keychain logic to detect fresh installs and clear sensitive data accordingly.

This behavior was not implemented to keep the mock assessment focused and concise.

## Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+
Not added any dependencies, all code is native Swift.

## Screenshots
| Login Screen | Home Screen |

|:------------:|:-----------:|
| ![Login Screen](Screenshots/login.png) | ![Home Screen](Screenshots/home.png) |


## Getting Started

1. Clone the repo
2. Open `.xcodeproj` file
3. Run on iOS Simulator or physical device

## Future Enhancements & Optimizations

The current implementation demonstrates key architectural practices including MVVM, programmatic UI with UICollectionViewCompositionalLayout, dependency injection, and secure token storage using Keychain. Below are some areas identified for future improvement:

### 🔧 Technical Enhancements

- **Fresh Install Detection**  
  Implement logic using a combination of `UserDefaults` and `Keychain` to detect a fresh install and clear stored credentials accordingly.

- **Authentication Enhancements**  
  Handle token expiration and refresh scenarios for a more robust authentication flow.

- **Modular Networking**  
  Refactor the networking logic into a reusable module or framework for better maintainability and reusability across projects.

- **Unit & UI Testing**  
  Introduce unit tests for ViewModels and UI tests for flows like login and home screen to ensure long-term stability. Currently i added for the LoginViewModel

- **Improved Async/Await Usage**  
  Refine Swift concurrency practices by handling cancellation, retries, and structured error handling.

- **Error Handling**  
  Show user-friendly messages and retry actions in case of API failures or no internet connectivity.

### 💡 UI/UX Enhancements

- **Shimmer/Placeholder Loaders**  
  Add skeleton loading states for a better perceived performance during data fetching.

- **Empty State Handling**  
  Provide UI feedback (e.g., illustrations or messages) when there's no data to display in any section.

- **Dark Mode Support**  
  Enable seamless experience by supporting iOS dark mode themes.

