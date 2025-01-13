// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FileController from "./file_controller"
application.register("file", FileController)

import HomeController from "./home_controller"
application.register("home", HomeController)

import TooltipController from "./tooltip_controller"
application.register("tooltip", TooltipController)
