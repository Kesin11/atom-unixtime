moment = require 'moment'

class TimeConverter
  constructor: (unixtime_or_string) ->
    # from unixtime
    if (String(unixtime_or_string).match(/\d{10}/))
      @moment = moment.unix(unixtime_or_string)
    # from date string
    else
      @moment = moment(unixtime_or_string)

  toUnixtime: () ->
    return @moment.unix()

  toString: () ->
    return @moment.format('YYYY-MM-DD HH:mm:ss')

module.exports = {
  TimeConverter: TimeConverter
}
