window.reloadApp = -> appWindow.location.reload(true)
window.initTestJQuery = -> window.$ = window.jQuery = appWindow.jQuery

# Nicer printing of jQuery objects
origFormat = jasmine.PrettyPrinter.prototype.format
jasmine.PrettyPrinter.prototype.format = (value) ->
  value = value.selector if value.jquery
  origFormat.call(this, value)

beforeEach ->
  this.addMatchers {
    toBeDisabled: -> this.actual.attr("disabled")?,
    toBeEnabled: -> not this.actual.attr("disabled")?,
    toBeAtLeast: (expectedMin) -> this.actual >= expectedMin
  }

window.millisOf = (timer) ->
  [rest, millis] = timer.text().split(".")
  parseInt(millis, 10)

window.secsOf = (timer) ->
  [secs, rest] = timer.text().split(".")
  parseInt(secs, 10)
