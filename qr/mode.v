module qr

enum Mode {
  numeric alphanumeric binary kanji eci
}

const (
  mode_numeric_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
  mode_alphanumeric_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ','$','%','*','+','-','.','/',':']
  mode_names = ['numeric', 'alphanumeric', 'binary', 'kanji', 'eci', 'empty']
)

fn (m Mode) str() string {
  return mode_names[m] 
}

fn get_optimal(s string) ?Mode {
  if encodable(s, .numeric) {
    return Mode.numeric
  }
  if encodable(s, .alphanumeric) {
    return Mode.alphanumeric
  }
  if encodable(s, .binary) {
    return Mode.binary
  }
  return error("not found valid mode") 
}

fn encodable(s string, mode Mode) bool {
  us := s.ustring()
  for i := 0; i < us.len; i++ {
    if ! encodable_one(us.at(i), mode) {
      return false
    }
  }
  return true
}

fn encodable_one(c string, mode Mode) bool {
  match mode {
    .numeric => {return c in mode_numeric_chars} 
    .alphanumeric => {return c in mode_alphanumeric_chars}
    .binary => {return is_latin1(c)}
    else => {return false}
  }
}

fn is_latin1(u string) bool {
  match u.len {
    0 => {return false}
    1 => {return u[0] <= 0x7f}
    2 => {return u[0] in [0xc2, 0xc3] && (0x80 <= u[1] && u[1] <= 0xbf)} 
    else => {return false}
  }
}

fn indicator(mode Mode) int {
  match mode {
    .numeric => {return 1}
    .alphanumeric => {return 1 << 1}
    .binary => {return 1 << 2}
    .kanji => {return 1 << 3}
    .eci => {return 15}
    else => {return 0}
  }
}
