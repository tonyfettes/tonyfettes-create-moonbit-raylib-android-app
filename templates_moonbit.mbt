///|
/// Starter bouncing ball game with touch-to-pause
fn starter_main_mbt(c : ProjectConfig) -> String {
  let display_name = c.display_name
  let buf = StringBuilder::new()
  buf.write_string(
    (
      #|///|
      #|fn main {
      #|  // Initialization
      #|  let screen_width = 800
      #|  let screen_height = 450
      #|  @raylib.init_window(
      #|
    ),
  )
  buf.write_string("    screen_width, screen_height, \"\{display_name}\",\n")
  buf.write_string(
    (
      #|  )
      #|  let mut ball_position_x : Float = Float::from_int(@raylib.get_screen_width()) /
      #|    2.0
      #|  let mut ball_position_y : Float = Float::from_int(@raylib.get_screen_height()) /
      #|    2.0
      #|  let mut ball_speed_x : Float = 5.0
      #|  let mut ball_speed_y : Float = 4.0
      #|  let ball_radius = 20
      #|  let mut pause = false
      #|  let mut frames_counter = 0
      #|  @raylib.set_target_fps(60)
      #|
      #|  // Main game loop
      #|  while not(@raylib.window_should_close()) {
      #|    // Update
      #|    if @raylib.is_key_pressed(@raylib.KeySpace) || @raylib.is_gesture_detected(@raylib.GestureTap) {
      #|      pause = not(pause)
      #|    }
      #|    if not(pause) {
      #|      ball_position_x += ball_speed_x
      #|      ball_position_y += ball_speed_y
      #|
      #|      // Check walls collision for bouncing
      #|      if ball_position_x >=
      #|        Float::from_int(@raylib.get_screen_width() - ball_radius) ||
      #|        ball_position_x <= Float::from_int(ball_radius) {
      #|        ball_speed_x = -ball_speed_x
      #|      }
      #|      if ball_position_y >=
      #|        Float::from_int(@raylib.get_screen_height() - ball_radius) ||
      #|        ball_position_y <= Float::from_int(ball_radius) {
      #|        ball_speed_y = -ball_speed_y
      #|      }
      #|    } else {
      #|      frames_counter += 1
      #|    }
      #|
      #|    // Draw
      #|    @raylib.begin_drawing()
      #|    @raylib.clear_background(@raylib.raywhite)
      #|    @raylib.draw_circle_v(
      #|      @raylib.Vector2::new(ball_position_x, ball_position_y),
      #|      Float::from_int(ball_radius),
      #|      @raylib.maroon,
      #|    )
      #|    @raylib.draw_text(
      #|      "PRESS SPACE or TAP to PAUSE",
      #|      10,
      #|      @raylib.get_screen_height() - 25,
      #|      20,
      #|      @raylib.lightgray,
      #|    )
      #|
      #|    // On pause, we draw a blinking message
      #|    if pause && frames_counter / 30 % 2 != 0 {
      #|      @raylib.draw_text("PAUSED", 350, 200, 30, @raylib.gray)
      #|    }
      #|    @raylib.draw_fps(10, 10)
      #|    @raylib.end_drawing()
      #|  }
      #|
      #|  // De-Initialization
      #|  @raylib.close_window()
      #|}
      #|
    ),
  )
  buf.to_string()
}

///|
/// moon.mod.json for the generated project's moonbit directory
fn gen_moon_mod_json(c : ProjectConfig) -> String {
  let module_name = c.module_name
  let buf = StringBuilder::new()
  buf.write_string(
    (
      #|{
      #|  "name": "
    ),
  )
  buf.write_string(module_name)
  buf.write_string(
    (
      #|",
      #|  "version": "0.1.0",
      #|  "deps": {
      #|    "tonyfettes/raylib": "0.2.2"
      #|  },
      #|  "preferred-target": "native"
      #|}
      #|
    ),
  )
  buf.to_string()
}

///|
/// moon.pkg for the generated project's moonbit directory
fn gen_moon_pkg_content() -> String {
  let s =
    #|import {
    #|  "tonyfettes/raylib",
    #|}
    #|
    #|options(
    #|  "is-main": true,
    #|)
  s
}
