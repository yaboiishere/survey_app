// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as jq from "jquery";
import "jquery_ujs";
import "@hotwired/turbo-rails";
import "controllers";
window.importmapScriptsLoaded = true;

import { far } from "@fortawesome/free-regular-svg-icons";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { fab } from "@fortawesome/free-brands-svg-icons";
import { library } from "@fortawesome/fontawesome-svg-core";
import "@fortawesome/fontawesome-free";
library.add(far, fas, fab);
