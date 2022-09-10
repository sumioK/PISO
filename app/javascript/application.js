// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

import "controllers"
import "./custom/users_show.js"
import "./custom/prview.js"

//= require jquery
//= require jquery_ujs
