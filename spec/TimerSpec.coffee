describe "Timer app", ->
  timerDisplay = toggleButton = resetButton = undefined

  appLoaded = false
  beforeEach ->
    runs ->
      appLoaded = false
      reloadApp()
      app.onload = ->
        initTestJQuery()
        timerDisplay = $(".timer-display")
        toggleButton = $(".toggle-button")
        resetButton = $(".reset-button")
        appLoaded = true
    waitsFor ->
      appLoaded is true

  afterEach ->
    toggleButton.click() if $(toggleButton).text() is "Stop"

  it "should have a timer display with zeroed time, a start button, and a disabled reset button when loaded", ->
    expect(timerDisplay).toHaveText "0.000"
    expect(toggleButton).toBeEnabled()
    expect(toggleButton).toHaveText "Start"
    expect(resetButton).toBeDisabled()
    expect(resetButton).toHaveText "Reset"

  it "should start on button click", ->
    toggleButton.click()
    expect(toggleButton).toHaveText "Stop"

  it "should stop when started and clicking the button again", ->
    toggleButton.click()
    toggleButton.click()
    expect(toggleButton).toHaveText "Start"

  it "should update the timer milliseconds when running", ->
    runs -> toggleButton.click()
    waits 90
    runs -> expect(millisOf timerDisplay).toBeAtLeast 80

  it "should update the timer seconds when running", ->
    runs -> toggleButton.click()
    waits 1090
    runs -> expect(secsOf timerDisplay).toBeAtLeast 1
