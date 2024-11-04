(* Location.ml *)

module PBox = PrintBox

open Lexing  (* Include this line *)

type location = { start_pos : position; end_pos : position }

let make_location (startp, endp) = { start_pos = startp; end_pos = endp }

let dummy_loc = { start_pos = dummy_pos; end_pos = dummy_pos }

let location_style = PBox.Style.fg_color PBox.Style.Cyan

let location_to_tree ?(includefile = true) { start_pos; end_pos } =
  if start_pos.pos_lnum = end_pos.pos_lnum then
    PBox.sprintf_with_style location_style "@ %d:%d-%d"
      start_pos.pos_lnum
      (start_pos.pos_cnum - start_pos.pos_bol)
      (end_pos.pos_cnum - end_pos.pos_bol)
  else
    PBox.sprintf_with_style location_style "@ %d:%d-%d:%d"
      start_pos.pos_lnum
      (start_pos.pos_cnum - start_pos.pos_bol)
      end_pos.pos_lnum
      (end_pos.pos_cnum - end_pos.pos_bol)

(* Function to convert location to string *)
let string_of_location { start_pos; end_pos } =
  if start_pos.pos_lnum = end_pos.pos_lnum then
    Printf.sprintf "line %d, characters %d-%d"
      start_pos.pos_lnum
      (start_pos.pos_cnum - start_pos.pos_bol)
      (end_pos.pos_cnum - end_pos.pos_bol)
  else
    Printf.sprintf "line %d, character %d to line %d, character %d"
      start_pos.pos_lnum
      (start_pos.pos_cnum - start_pos.pos_bol)
      end_pos.pos_lnum
      (end_pos.pos_cnum - end_pos.pos_bol)

(* Function to convert position to string *)
let string_of_position pos =
  Printf.sprintf "line %d, character %d"
    pos.pos_lnum
    (pos.pos_cnum - pos.pos_bol)
