import qr

const (
  v0 = qr.Version{0}
  v1 = qr.Version{1}
  v2 = qr.Version{2}
  v3 = qr.Version{3}
  v10 = qr.Version{10}
  v40 = qr.Version{40}
  v41 = qr.Version{41}
)

fn test_version_available() {
  assert v0.available() == false
  assert v1.available() == true
  assert v10.available() == true
  assert v40.available() == true
  assert v41.available() == false
}

fn test_verson_size() {
  assert v0.size() == 0
  assert v1.size() == 21
  assert v2.size() == 25
  assert v3.size() == 29
  assert v40.size() == 177
}
