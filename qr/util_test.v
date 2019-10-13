import qr

fn test_pad_bit() {
  assert qr.pad_bit(9, '1011') == '000001011'
  assert qr.pad_bit(6, "1101") == "001101"
  assert qr.pad_bit(6, "101101") == "101101"
}

fn test_pad_bit_r() {
  assert qr.pad_bit_r(9, '1011') == '101100000'
  assert qr.pad_bit_r(6, "1101") == "110100"
  assert qr.pad_bit_r(6, "101101") == "101101"
}

fn test_decimal_to_binary() {
  assert qr.decimal_to_binary(10) == '1010'
  assert qr.decimal_to_binary(11) == '1011'
}

fn test_remove() {
  assert qr.remove(' ', 'abc d') == 'abcd'
}
