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

const String setorMutation = r'''
  mutation Penyetoran (
    $reference: String
    $date: String
    $description: String
    $cashIn: ID!
    $amount: Int!
  ) {
    penyetoran(
      reference: $reference
      date: $date
      description: $description
      cashIn: $cashIn
      amount: $amount
    ) {
      id
      success
    }
  }
''';
