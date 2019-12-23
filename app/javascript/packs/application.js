require("@rails/ujs").start()
require("turbolinks").start()
require("channels")

import { Application } from 'stimulus'
import Flatpickr from 'stimulus-flatpickr'

import { definitionsFromContext } from 'stimulus/webpack-helpers'
const application = Application.start()
const context = require.context('../controllers', true, /_controller\.js$/)
application.load(definitionsFromContext(context))

application.register('flatpickr', Flatpickr)

import('../styles/application.scss');


