

type token_id = nat

type safe_transfer_from_param = {
  from: address;      (* Source address *)
  to_:   address;     (* Target address. Target smart contract must implement entry points from `erc1155_receiver` interface *)
  token_id: token_id; (* ID of the token type *)
  amount: nat;        (* Transfer amount *)
  data: bytes;        (* Additional data with no specified format, MUST be sent unaltered in call to `OnERC1155Received` on `to_` *)
}

type tx = {
  token_id: token_id; (* ID of the token type *)
  amount: nat;        (* Transfer amount *)
}

type safe_batch_transfer_from_param = {
  from: address;      (* Source address *)
  to_:   address;     (* Target address. Target smart contract must implement entry points from `erc1155_receiver` interface *)
  batch: tx list;     (* Batch of tokens and their amounts to be transfered *)
  data: bytes;        (* Additional data with no specified format, MUST be sent unaltered in call to `OnERC1155BatchReceived` on `to_` *)
}

type balance_request = {
  owner: address;     (* The address of the token holder *)
  token_id: token_id; (* ID of the  token *)
}

type balance_of_param = {
  balance_request: balance_request;
  balance_view: balance_request * nat -> operation;
}

type balance_of_batch_param = {
  balance_request: balance_request list;
  balance_view: balance_request * nat list -> operation;
}

type set_approval_for_all_param = {
  operator: address;
  approved: bool;
}

type is_approved_for_all_request = {
  owner: address;
  operator: address;
}
type is_approved_for_all = {
  is_approved_for_all_request: is_approved_for_all_request;
  approved_view: is_approved_for_all_request * bool -> operation
}

(* ERC1155 entry points *)
type erc1155 =
  | SafeTransferFrom of safe_transfer_from_param
  | SafeBatchTransferFrom of safe_batch_transfer_from_param
  | BalanceOf of balance_of_param
  | BalanceOfBatch of balance_of_batch_param
  | SetApprovalForAll of set_approval_for_all_param
  | IsApprovedForAll of is_approved_for_all
  | ERC1155Ext of unit


type on_erc1155_received_param = {
  operator: address;    (* The address which initiated the transfer (i. e. sender) *)
  from: address option; (* Source address. None for minting operation *)
  token_id: token_id;   (* ID of the token type *)
  amount: nat;          (* Transfer amount *)
  data: bytes;          (* Additional data with no specified format *)
}

type on_erc1155_batch_received_param = {
  operator: address;    (* The address which initiated the transfer (i. e. sender) *)
  from: address option; (* Source address. None for minting operation *)
  batch: tx list;       (* Batch of tokens and their amounts which are transfered *)
  data: bytes;          (* Additional data with no specified format *)
}

(* ERC1155TokenReceiver entry points *)
type erc1155_token_receiver =
  | OnERC1155Received of on_erc1155_received_param
  | OnERC1155BatchReceived of on_erc1155_batch_received_param
  | ERC1155TokenReceiverExt of unit


let test(u: unit) = 77
