window.reloadApp = -> appWindow.location.reload(true)
window.initTestJQuery = -> window.$ = window.jQuery = appWindow.jQuery

# Nicer printing of jQuery objects
origFormat = jasmine.PrettyPrinter.prototype.format
jasmine.PrettyPrinter.prototype.format = (value) ->
  value = value.selector if value.jquery
  origFormat.call(this, value)

beforeEach ->
  this.addMatchers {
    toBeEnabled: -> this.actual.length > 0 and not this.actual.attr("disabled")?
  }

window.millisOf = ($timerDisplay) ->
  [rest, millis] = $timerDisplay.text().split('.')
  parseInt(millis, 10)
