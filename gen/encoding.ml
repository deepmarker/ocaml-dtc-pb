type encoding =
  | Binary
  | Binary_VLS
  | Json
  | Json_compact
  | Protobuf

let int_of_encoding = function
  | Binary -> 0
  | Binary_VLS -> 1
  | Json -> 2
  | Json_compact -> 3
  | Protobuf -> 4
;;

let encoding_of_int = function
  | 0 -> Some Binary
  | 1 -> Some Binary_VLS
  | 2 -> Some Json
  | 3 -> Some Json_compact
  | 4 -> Some Protobuf
  | _ -> None
;;

type meta =
  { version : int
  ; encoding : encoding
  }

type t =
  | Request of meta
  | Response of meta

let message_size = 16

let read buf =
  let open EndianString.LittleEndian in
  let size = get_uint16 buf 0 in
  if size <> message_size
  then None
  else (
    let kind = get_uint16 buf 2 in
    let version = Int32.to_int (get_int32 buf 4) in
    let encoding = encoding_of_int (Int32.to_int (get_int32 buf 8)) in
    let dtc = String.sub buf 12 4 in
    match kind, encoding, dtc with
    | 6, Some encoding, "DTC\x00" -> Some (Request { version; encoding })
    | 7, Some encoding, "DTC\x00" -> Some (Response { version; encoding })
    | _ -> None)
;;

let read_exn buf =
  match read buf with
  | None -> invalid_arg "Encoding.read_exn"
  | Some t -> t
;;

let write buf t =
  let open EndianBytes.LittleEndian in
  let kind, version, encoding =
    match t with
    | Request { version; encoding } -> 6, version, encoding
    | Response { version; encoding } -> 7, version, encoding
  in
  set_int16 buf 0 message_size;
  set_int16 buf 2 kind;
  set_int32 buf 4 (Int32.of_int version);
  set_int32 buf 8 (Int32.of_int (int_of_encoding encoding));
  String.blit "DTC\x00" 0 buf 12 4
;;

let to_string t =
  let buf = Bytes.create message_size in
  write buf t;
  Bytes.unsafe_to_string buf
;;
