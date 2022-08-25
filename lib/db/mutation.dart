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

const String gantiPwMutation = r'''
mutation gantiPw($newUserName: String!, $newPass: String!) {
  changeUsrPsw(newPass: $newPass, newUsrName: $newUserName) {
    token
  }
}
''';

const String newCustomer = r'''
  mutation addNewCustomer(
    $username: String!
    $password: String!
    $code: String!
  ) {
    addNewCustomer(
      username: $username
      password: $password
      code: $code
      status: true
    ) {
      success
      message
    }
  }
''';

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

const String batchPenarikanMutation = r'''
  mutation PenarikanBatch(
    $date: String
    $description: String
    $reference: String
    $input: [FormInput]
  ) {
    penarikanBatch(
      date: $date
      description: $description
      reference: $reference
      input: $input
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
