TimeConverter = require '../lib/time-converter'

module.exports =
class AtomUnixtimeView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-unixtime')

    # Create message element
    message = document.createElement('div')
    message.classList.add('message')
    @element.appendChild(message)

    @timeConverter = null

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # TEAR DOWN ANY STATE AND DETACH
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  setTime: (unixtime_or_string) ->
    @timeConverter = new TimeConverter.TimeConverter(unixtime_or_string)
    converted_time = @timeConverter.convert()
    @element.textContent = "#{unixtime_or_string} => #{converted_time}"
