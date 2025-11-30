use aiken/collection/list
use cardano/transaction.{OutputReference, Transaction}

pub type Datum {
  merchant: ByteArray,
  payer: ByteArray,
  amount_per_period: Int,
  periods_remaining: Int,
  period_length_seconds: Int,
  next_payment_time: Int,
}

pub type Redeemer {
  Claim
}

validator subscription {
  spend(
    datum_opt: Option<Datum>,
    _redeemer: Redeemer,
    _own_ref: OutputReference,
    self: Transaction,
  ) {
    when datum_opt is {
      Some(datum) -> {
        // Check merchant signed
        let signed_by_merchant = list.has(self.extra_signatories, datum.merchant)
        
        // Check periods remaining
        let valid_periods = datum.periods_remaining >= 1
        
        // Future: Add time check here using self.validity_range
        
        signed_by_merchant && valid_periods
      }
      None -> False
    }
  }
}
