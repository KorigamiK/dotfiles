let selected_rect = JSON.parse(sioyek.select_rect());
let window_rect = sioyek_api.absolute_to_window_rect_json(selected_rect);
let screenshot_file_name = sioyek.show_text_prompt("Screenshot file name");
sioyek_api.screenshot_js(
  "/home/origami/Pictures/Screenshots/" + screenshot_file_name + ".png",
  window_rect,
);
