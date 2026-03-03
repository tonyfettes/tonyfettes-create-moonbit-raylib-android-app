///|
/// Starter hello world
fn starter_main_mbt(c : ProjectConfig) -> String {
  let display_name = c.display_name
  (
    #|///|
    #|fn main {
    $|  @raylib.init_window(800, 450, "\{display_name}")
    #|  @raylib.set_target_fps(60)
    #|  while not(@raylib.window_should_close()) {
    #|    @raylib.begin_drawing()
    #|    @raylib.clear_background(@raylib.raywhite)
    #|    let text = "Hello, World!"
    #|    let font_size = 20
    #|    @raylib.draw_text(
    #|      text,
    #|      (@raylib.get_screen_width() - @raylib.measure_text(text, font_size)) / 2,
    #|      @raylib.get_screen_height() / 2,
    #|      font_size,
    #|      @raylib.lightgray,
    #|    )
    #|    @raylib.end_drawing()
    #|  }
    #|  @raylib.close_window()
    #|}
    #|
  )
}

///|
/// moon.mod.json for the generated project's moonbit directory
fn gen_moon_mod_json(c : ProjectConfig) -> String {
  let module_name = c.module_name
  (
    #|{
    $|  "name": "\{module_name}",
    #|  "version": "0.1.0",
    #|  "deps": {
    #|    "tonyfettes/raylib": "0.2.3"
    #|  },
    #|  "preferred-target": "native"
    #|}
    #|
  )
}

///|
/// moon.pkg for the generated project's moonbit directory
fn gen_moon_pkg_content() -> String {
  (
    #|import {
    #|  "tonyfettes/raylib",
    #|}
    #|
    #|options(
    #|  "is-main": true,
    #|)
  )
}
