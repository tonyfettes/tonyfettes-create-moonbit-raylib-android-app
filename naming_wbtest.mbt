///|
test "to_package_id basic" {
  inspect(
    to_package_id("MyBouncingBall"),
    content=(
      #|mybouncingball
    ),
  )
}

///|
test "to_package_id single word" {
  inspect(
    to_package_id("Hello"),
    content=(
      #|hello
    ),
  )
}

///|
test "to_package_id with numbers" {
  inspect(
    to_package_id("Game2048"),
    content=(
      #|game2048
    ),
  )
}

///|
test "to_display_name basic" {
  inspect(
    to_display_name("MyBouncingBall"),
    content=(
      #|My Bouncing Ball
    ),
  )
}

///|
test "to_display_name single word" {
  inspect(
    to_display_name("Hello"),
    content=(
      #|Hello
    ),
  )
}

///|
test "to_display_name consecutive uppercase" {
  inspect(
    to_display_name("MyUIApp"),
    content=(
      #|My UIApp
    ),
  )
}

///|
test "to_theme_name" {
  inspect(
    to_theme_name("MyBouncingBall"),
    content=(
      #|Theme.MyBouncingBall
    ),
  )
}

///|
test "is_valid_name valid PascalCase" {
  inspect(
    is_valid_name("MyBouncingBall"),
    content=(
      #|true
    ),
  )
}

///|
test "is_valid_name empty" {
  inspect(
    is_valid_name(""),
    content=(
      #|false
    ),
  )
}

///|
test "is_valid_name lowercase start" {
  inspect(
    is_valid_name("myGame"),
    content=(
      #|false
    ),
  )
}

///|
test "is_valid_name special chars" {
  inspect(
    is_valid_name("My-Game"),
    content=(
      #|false
    ),
  )
}

///|
test "is_valid_name with numbers" {
  inspect(
    is_valid_name("Game2048"),
    content=(
      #|true
    ),
  )
}

///|
test "derive_names landscape" {
  inspect(
    derive_names("MyBouncingBall", "landscape", "user"),
    content=(
      #|{project_name: "MyBouncingBall", package_id: "mybouncingball", display_name: "My Bouncing Ball", theme_name: "Theme.MyBouncingBall", module_name: "user/mybouncingball", orientation: "landscape"}
    ),
  )
}

///|
test "derive_names portrait" {
  inspect(
    derive_names("MyBouncingBall", "portrait", "user"),
    content=(
      #|{project_name: "MyBouncingBall", package_id: "mybouncingball", display_name: "My Bouncing Ball", theme_name: "Theme.MyBouncingBall", module_name: "user/mybouncingball", orientation: "portrait"}
    ),
  )
}
