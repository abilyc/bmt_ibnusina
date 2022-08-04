const String trxQuery = r'''
  query GetCustomerTrx($_eq: String) {
    customer(where: {name: {_eq: $_eq}}) {
      trx_TABREG_cash_in {
        ref
        desc
        amount
        date
        customer_cash_out {
          id
          name
        }
      }
      trx_TABREG_cash_out {
        ref
        desc
        amount
        customer_cash_in {
          id
          name
        }
      }
    }
  }

''';
