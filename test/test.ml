open Pbrt
open Dtc_pb.Dtcprotocol_pb

let bleh s =
  let enc = Encoder.create () in
  let dec = Decoder.of_bytes s in
  let lr = decode_logon_request dec in
  Format.printf "%a@." Dtc_pb.Dtcprotocol_pp.pp_logon_request lr ;
  encode_logon_request lr enc ;
  Format.printf "%s@." (Encoder.to_bytes enc |> Bytes.unsafe_to_string)
