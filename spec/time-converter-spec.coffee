TimeConverter = require '../lib/time-converter'

describe "TimeConverter", ->
  unixtime = 1420038000
  date_string = "2015-01-01 00:00:00"
  time_converter = undefined

  describe "when build by unixtime", ->
    beforeEach ->
      time_converter = new TimeConverter.TimeConverter(unixtime)

    it "output same unixtime", ->
      expect(time_converter.toUnixtime()).toEqual(unixtime)

    it "output correct datetime string", ->
      expect(time_converter.toString()).toEqual(date_string)

  describe "when build by date string", ->
    beforeEach ->
      time_converter = new TimeConverter.TimeConverter(date_string)

    it "output same date string", ->
      expect(time_converter.toString()).toEqual(date_string)

    it "output correct unixtime", ->
      expect(time_converter.toUnixtime()).toEqual(unixtime)
