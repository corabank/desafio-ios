protocol PasswordPresenterType: AnyObject {
    func login(password: String)
}

protocol PasswordControllerType: AnyObject {
    func loggedIn()
}
