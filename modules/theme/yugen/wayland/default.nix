let
  common = import ../common;
in
[
  ./notice
  ./fn-keys
  fnKeys
] ++ common
