///|
test "base64_decode Hello" {
  inspect(base64_decode("SGVsbG8="), content=(
    #|b"Hello"
  ))
}

///|
test "base64_decode empty" {
  inspect(base64_decode(""), content=(
    #|b""
  ))
}

///|
test "base64_decode Hello World" {
  inspect(base64_decode("SGVsbG8gV29ybGQ="), content=(
    #|b"Hello World"
  ))
}

///|
test "base64_decode padding two" {
  inspect(base64_decode("TQ=="), content=(
    #|b"M"
  ))
}

///|
test "base64_decode no padding" {
  inspect(base64_decode("TWFu"), content=(
    #|b"Man"
  ))
}
