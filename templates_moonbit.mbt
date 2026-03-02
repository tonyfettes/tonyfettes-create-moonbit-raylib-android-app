///|
/// Starter bouncing ball game with touch-to-pause
fn starter_main_mbt(c : ProjectConfig) -> String {
  let display_name = c.display_name
  "///|\nfn main {\n  // Initialization\n  let screen_width = 800\n  let screen_height = 450\n  @raylib.init_window(\n    screen_width, screen_height, \"" +
  display_name +
  "\",\n  )\n  let mut ball_position_x : Float = Float::from_int(@raylib.get_screen_width()) /\n    2.0\n  let mut ball_position_y : Float = Float::from_int(@raylib.get_screen_height()) /\n    2.0\n  let mut ball_speed_x : Float = 5.0\n  let mut ball_speed_y : Float = 4.0\n  let ball_radius = 20\n  let mut pause = false\n  let mut frames_counter = 0\n  @raylib.set_target_fps(60)\n\n  // Main game loop\n  while not(@raylib.window_should_close()) {\n    // Update\n    if @raylib.is_key_pressed(@raylib.KeySpace) || @raylib.is_gesture_detected(@raylib.GestureTap) {\n      pause = not(pause)\n    }\n    if not(pause) {\n      ball_position_x += ball_speed_x\n      ball_position_y += ball_speed_y\n\n      // Check walls collision for bouncing\n      if ball_position_x >=\n        Float::from_int(@raylib.get_screen_width() - ball_radius) ||\n        ball_position_x <= Float::from_int(ball_radius) {\n        ball_speed_x = -ball_speed_x\n      }\n      if ball_position_y >=\n        Float::from_int(@raylib.get_screen_height() - ball_radius) ||\n        ball_position_y <= Float::from_int(ball_radius) {\n        ball_speed_y = -ball_speed_y\n      }\n    } else {\n      frames_counter += 1\n    }\n\n    // Draw\n    @raylib.begin_drawing()\n    @raylib.clear_background(@raylib.raywhite)\n    @raylib.draw_circle_v(\n      @raylib.Vector2::new(ball_position_x, ball_position_y),\n      Float::from_int(ball_radius),\n      @raylib.maroon,\n    )\n    @raylib.draw_text(\n      \"PRESS SPACE or TAP to PAUSE\",\n      10,\n      @raylib.get_screen_height() - 25,\n      20,\n      @raylib.lightgray,\n    )\n\n    // On pause, we draw a blinking message\n    if pause && frames_counter / 30 % 2 != 0 {\n      @raylib.draw_text(\"PAUSED\", 350, 200, 30, @raylib.gray)\n    }\n    @raylib.draw_fps(10, 10)\n    @raylib.end_drawing()\n  }\n\n  // De-Initialization\n  @raylib.close_window()\n}\n"
}

///|
/// moon.mod.json for the generated project's moonbit directory
fn gen_moon_mod_json(c : ProjectConfig) -> String {
  let module_name = c.module_name
  "{\n  \"name\": \"\{module_name}\",\n  \"version\": \"0.1.0\",\n  \"deps\": {\n    \"tonyfettes/raylib\": \"0.2.2\"\n  },\n  \"preferred-target\": \"native\"\n}\n"
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
