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

const String penarikanMutation = r'''
  mutation Penarikan (
    $reference: String
    $date: String
    $description: String
    $cashOut: ID!
    $amount: Int!
  ) {
    penarikan(
      reference: $reference
      date: $date
      description: $description
      cashOut: $cashOut
      amount: $amount
    ) {
      id
      success
    }
  }
''';

const String transferMutation = r'''
  mutation Transfer($reference: String, $date: String, $description: String, $amount: Int!, $capitalAccountFROM: ID!, $capitalAccountTO: ID!){
    transfer(
      reference: $reference 
      date: $date
      description: $description 
      amount: $amount
      capitalAccountFROM: $capitalAccountFROM 
      capitalAccountTO: $capitalAccountTO 
    ){
      id
      success
    }
  }
''';
