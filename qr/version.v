module qr

struct Version {
pub:
  num int
}

fn (ve Version) size() int {
  if ve.available() {
    return (ve.num - 1) * 4 + 21
  }
  return 0
}

fn (ve Version) available() bool {
  return 1 <= ve.num && ve.num <= 40
}
