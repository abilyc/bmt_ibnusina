const String trxQuery = r'''
  query history($id: String!){
    getTrxByCustomerId(id: $id){
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
