//
//  LoginViewController.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//


import UIKit

import UIKit

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModelProtocol

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

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

    private func navigateToHome() {
        let homeViewModel: HomeViewModelProtocol = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel)
        navigationController?.setViewControllers([homeVC], animated: true)
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
