const String loginMutation = r"""
  mutation Login($username: String!, $password: String!) {
  login(username: $username, password: $password) {
    token
    userId
    userRole
    username
  }
}
""";
