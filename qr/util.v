module qr

fn pad_bit(length int, binary string) string {
  pad := get_pad_bit(length, binary) or {
    return err
  }
  return pad + binary
}

fn pad_bit_r(length int, binary string) string {
  pad := get_pad_bit(length, binary) or {
    return err
  }
  return binary + pad
}

fn get_pad_bit(length int, binary string) ?string {
  if length == binary.len {
    return ''
  }
  p := is_binaries(binary) or {
    return err
  }
  if p {
    return '0'.repeat(length - binary.len)
  } else {
    return ''
  }
}

fn is_binaries(s string) ?bool {
  return is_letters(s, is_binary)
}

fn is_binary(s string) ?bool {
  return is_letter(s, binaries)
}

fn is_letters(s string, f fn(string) ?bool) ?bool {
  us := s.ustring()
  for i := 0; i < us.len; i++ {
    p := f(us.at(i)) or {
      return error(err)
    }
    if !p {
      return false
    }
  }
  return true
}

fn is_letter(s string, ls []string) ?bool {
  us := s.ustring()
  match us.len {
    0 => {return error('$s is empty')}
    1 => {return us.at(0) in ls}
    else => {return error('$s is not single letter')}
  }
}

fn decimal_to_binary(_n int) string {
  mut n := _n
  mut acc := ""
  for n > 0 {
    acc = (n % 2).str() + acc
    n /= 2
  }
  return acc
}

fn join(ss []string) string {
  mut acc := ""
  for s in ss {
     acc += s
  }
  return acc
}

fn remove(c, s string) string {
  mut acc := ""
  for i := 0; i < s.len; i++ {
    if c[0] != s[i] {
      acc += s.substr(i, i+1)
    }
  }
  return acc
}
