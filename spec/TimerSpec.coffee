describe "Timer app", ->
  timerDisplay = toggleButton = undefined

  appLoaded = false
  beforeEach ->
    runs ->
      appLoaded = false
      reloadApp()
      app.onload = ->
        initTestJQuery()
        timerDisplay = $(".timer-display")
        toggleButton = $(".toggle-button")
        appLoaded = true
    waitsFor ->
      appLoaded is true

  afterEach ->
    toggleButton.click() if toggleButton.text() is "Stop"

  it "should have a timer display with zeroed time and a start btn", ->
    expect(timerDisplay).toHaveText "0.000"
    expect(toggleButton).toHaveText "Start"
    expect(toggleButton).toBeEnabled()

  it "should change start button text into 'Stop' on button click", ->
    toggleButton.click()
    expect(toggleButton).toHaveText "Stop"

  it "should change stop button text into 'Start' on button click", ->
    toggleButton.click()
    toggleButton.click()
    expect(toggleButton).toHaveText "Start"

  it "should update the timer fractions when running", ->
    runs -> toggleButton.click()
    waits 100
    runs -> expect(millisOf timerDisplay).toBeGreaterThan 80

  it "should update the timer seconds when running"
