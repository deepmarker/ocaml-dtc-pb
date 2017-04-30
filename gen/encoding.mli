type encoding =
  | Binary
  | Binary_VLS
  | Json
  | Json_compact
  | Protobuf

type meta = {
  version : int ;
  encoding : encoding ;
}

type t =
  | Request of meta
  | Response of meta

val read : string -> t option
val write : Bytes.t -> t -> unit
