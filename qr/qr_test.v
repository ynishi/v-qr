import qr

fn test_get_smallest_version() {
  l1 := "HELLO WORLD".ustring().len
  assert qr.get_smallest_version(l1, qr.Mode.alphanumeric,qr.ErrorCorrectionLevel.Q).num == 1
  l2 := "HELLO THERE WORLD".ustring().len
  assert qr.get_smallest_version(l2, qr.Mode.alphanumeric,qr.ErrorCorrectionLevel.Q).num == 2 
  assert qr.get_smallest_version(7089, qr.Mode.numeric,qr.ErrorCorrectionLevel.L).num == 40 
  assert qr.get_smallest_version(7090, qr.Mode.numeric,qr.ErrorCorrectionLevel.L).num == 0 
  assert qr.get_smallest_version(4296, qr.Mode.alphanumeric,qr.ErrorCorrectionLevel.L).num == 40 
  assert qr.get_smallest_version(2953, qr.Mode.binary,qr.ErrorCorrectionLevel.L).num == 40 
  assert qr.get_smallest_version(1817, qr.Mode.kanji,qr.ErrorCorrectionLevel.L).num == 40 
}

fn test_mode_indicator(){
  assert qr.indicator(qr.Mode.numeric) == 1
  assert qr.indicator(qr.Mode.alphanumeric) == 2
  assert qr.indicator(qr.Mode.binary) == 4
  assert qr.indicator(qr.Mode.kanji) == 8
  assert qr.indicator(qr.Mode.eci) == 15
}

fn test_encode_numeric() {
  assert qr.encode_numeric("8675309").str() == '["1101100011", "1000010010", "1001"]'
}

fn test_a_to_bin() {
  assert qr.a_to_bin('97') == '1100001'
}

fn test_pair_to_bin() {
  assert qr.pair_to_bin("HE") == "01100001011"
  assert qr.pair_to_bin("D") == "001101"
  assert qr.pair_to_bin(" ") == "100100"
}

fn test_encode_alpha() {
  assert qr.encode_alpha("HE").str() == '["01100001011"]'
  assert qr.encode_alpha("D").str() == '["001101"]'
  assert qr.encode_alpha("HED").str() == '["01100001011", "001101"]'
  assert qr.encode_alpha(" ").str() == '["100100"]'
  assert qr.encode_alpha("HELLO WORLD").str() == '["01100001011", "01111000110", "10001011100", "10110111000", "10011010100", "001101"]'
}

fn test_latin1_encode() {
  s := "Hello,World!"
  assert s[0] == 72
  assert s[1] == 0x65
  assert qr.pad_bit(8, qr.decimal_to_binary(s[2])) == '01101100'
}

fn test_encode_bit() {
  assert qr.encode_bit("H").str() == '["01001000"]'
  assert qr.encode_bit("Hello, world!").str() == '["01001000", "01100101", "01101100", "01101100", "01101111", "00101100", "00100000", "01110111", "01101111", "01110010", "01101100", "01100100", "00100001"]'
}

fn test_get_terminator() {
  q := qr.QR{version:qr.Version{1}, ecl:qr.ErrorCorrectionLevel.Q}
  assert q.get_terminator(104) == ''
  assert q.get_terminator(102) == '00'
  assert q.get_terminator(72) == '0000'
}

fn test_pad_to_mult8bit() {
  assert qr.pad_to_mult8bit("1") == '10000000'
  assert qr.pad_to_mult8bit("000000011") == '0000000110000000'
  assert qr.pad_to_mult8bit("001000000101101100001011011110001101000101110010110111000100110101000011010000") == "00100000010110110000101101111000110100010111001011011100010011010100001101000000"
}

fn test_take_n_pad() {
  assert qr.take_n_pad(1) == '11101100'
  assert qr.take_n_pad(2) == '1110110000010001'
  assert qr.take_n_pad(3) == '111011000001000111101100'
}

fn test_get_required_capacity() {
  q := qr.QR{version:qr.Version{1}, ecl:qr.ErrorCorrectionLevel.Q}
  assert q.get_required_capacity() == 104
}

fn test_pad_to_max() {
  s := "00100000010110110000101101111000110100010111001011011100010011010100001101000000"
  q := qr.QR{version:qr.Version{1}, ecl:qr.ErrorCorrectionLevel.Q}
  assert s.len == 80
  assert (104 - 80) / 8 == 3
  assert q.pad_to_max(s) == "00100000010110110000101101111000110100010111001011011100010011010100001101000000111011000001000111101100"
}

fn test_latin() {
  s := "ÿa"
  u := s.ustring().at(0)
  assert u in ["ÿ"]
}
