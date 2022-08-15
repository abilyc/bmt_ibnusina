const String trxQuery = r'''
  query getTrxByCustomerCode($code: String!){
    getTrxByCustomerCode(code: $code){
      id
      name
      balance
      history {
        type
        ref
        amount
        date
      }
    }
  }
''';
