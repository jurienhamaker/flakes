let
  common = import ../common;
  fnKeys = import ../fnKeys;
in
[
  ./notice
] ++ [common fnKeys]
