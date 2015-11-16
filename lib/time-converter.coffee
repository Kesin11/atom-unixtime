moment = require 'moment'

class TimeConverter
  constructor: (unixtime_or_string) ->
    # from unixtime
    if (String(unixtime_or_string).match(/\d{10}/))
      @moment = moment.unix(unixtime_or_string)
      @fromUnixtime = true

    # from date string
    else
      @moment = moment(unixtime_or_string)
      @fromUnixtime = false

  toUnixtime: () ->
    return @moment.unix()

  toString: () ->
    return @moment.format('YYYY-MM-DD HH:mm:ss')

  convert: () ->
    return if @fromUnixtime then @toString() else @toUnixtime()

module.exports = {
  TimeConverter: TimeConverter
}
