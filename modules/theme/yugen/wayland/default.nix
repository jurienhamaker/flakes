let
  common = import ../common;
  fnKeys = import ./fnKeys;
in
[
  ./notice
  fnKeys
] ++ common
