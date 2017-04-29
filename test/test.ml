module P = Piqirun
module DTC = Dtcprotocol_piqi

let bleh s =
  let p = P.init_from_string s in
  let lr = DTC.parse_logon_request p in
  let lr_gen = DTC.gen_logon_request lr in
  P.to_string lr_gen
