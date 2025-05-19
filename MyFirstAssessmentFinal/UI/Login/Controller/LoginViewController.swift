//
//  LoginViewController.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//
//  This file contains the implementation of the LoginViewController, which handles user login functionality.
import UIKit
/// A view controller responsible for handling user login functionality.
///
/// `LoginViewController` presents a login form with email and password fields,
/// validates user input, and initiates the login process through its view model.
/// On successful login, it navigates to the home screen; on failure, it displays an error alert.
///
/// - Note: This controller uses dependency injection for its view model and mock services for demonstration.
class LoginViewController: UIViewController {
    /// The view model that handles login logic and validation.

    private let viewModel: LoginViewModelProtocol
    /// The text field for entering the user's email address.

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    /// The text field for entering the user's password.

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    /// The button that triggers the login process.

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    /// Initializes the login view controller with a given view model.
    ///
    /// - Parameter viewModel: The view model conforming to `LoginViewModelProtocol`.
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets up the user interface and adds targets for user interaction.

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    /// Arranges the UI elements in a vertical stack and sets layout constraints.
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    /// Handles the login button tap event.
    ///
    /// Validates input, attempts login, and handles navigation or error display.
    @objc private func loginTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        do {
            try viewModel.validate(email: email, password: password)
            viewModel.login(email: email, password: password) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.navigateToHome()
                    case .failure(let error):
                        self?.showError(error.localizedDescription)
                    }
                }
            }
        } catch {
            showError(error.localizedDescription)
        }
    }
    /// Navigates to the home screen upon successful login.

    private func navigateToHome() {
        // Initialize services (can be replaced with real services in production)
        let bannerService = MockBannerService()
        let categoryService = MockCategoryService()
        let productService = MockProductService()

        // Inject services into ViewModel
        let homeViewModel: HomeViewModelProtocol = HomeViewModel(
            bannerService: bannerService,
            categoryService: categoryService,
            productService: productService
        )

        // Initialize HomeViewController with ViewModel
        let homeVC = HomeViewController(viewModel: homeViewModel)

        // Set it as the root of the navigation stack
        navigationController?.setViewControllers([homeVC], animated: true)
    }

    /// Displays an error alert with the provided message.
    ///
    /// - Parameter message: The error message to display.
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
