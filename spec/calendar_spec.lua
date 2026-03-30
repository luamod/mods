local helpers = require "spec.helpers"
local mods = require "mods"

local cal = mods.calendar

local test_functions = helpers.test_functions

describe("mods.calendar", function()
  after_each(function()
    cal.setfirstweekday(cal.MONDAY)
  end)

  -- stylua: ignore
  local months = {
    "January", "February", "March"    , "April"  , "May"     , "June"    ,
    "July"   , "August"  , "September", "October", "November", "December",
  }
  local days = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }

  test_functions(cal, {
    -- stylua: ignore start
    --{{expected}, {args}}

    isleap = {
      {{ false }, { 1900 }},
      {{ true  }, { 1600 }},
      {{ true  }, { 2000 }},
      {{ true  }, { 2024 }},
      {{ false }, { 2025 }},
      {{ false }, { 2100 }},
      {{ true  }, { 2400 }},
    },
    leapdays = {
      {{ 0 }, { 2000, 2000 }},
      {{ 1 }, { 2000, 2001 }},
      {{ 0 }, { 2010, 2011 }},
      {{ 7 }, { 2000, 2025 }},
    },
    weekday = {
      {{ cal.THURSDAY }, { 1970, 1, 1  }},
      {{ cal.THURSDAY }, { 2026, 3, 26 }},
    },
    monthrange = {
      {{ cal.THURSDAY, 29 }, { 2024, 2 }},
      {{ cal.SUNDAY  , 28 }, { 2026, 2 }},
    },
    weekheader = {
      {{ "Mo Tu We Th Fr Sa Su"                                                         }, {    }},
      {{ "M T W T F S S"                                                                }, { 1  }},
      {{ "Mo Tu We Th Fr Sa Su"                                                         }, { 2  }},
      {{ "Mon Tue Wed Thu Fri Sat Sun"                                                  }, { 3  }},
      {{ "Monday     Tuesday    Wednesday  Thursday   Friday     Saturday   Sunday    " }, { 10 }},
    },
  })

  it("exports month constants", function()
    for no, name in ipairs(months) do
      assert.are_equal(no, cal[name:upper()])
    end
  end)

  it("exports weekday constants", function()
    local weekdays = days
    for no, name in ipairs(weekdays) do
      assert.are_equal(no, cal[name:upper()])
    end
  end)

  it("exports month names", function()
    assert.is_list(cal.months)
    assert.are_same(months, cal.months)
  end)

  it("exports weekday names", function()
    assert.is_list(cal.days)
    assert.are_same(days, cal.days)
  end)

  describe("weekdays()", function()
    it("returns a function iterator", function()
      assert.is_function(cal.weekdays())
    end)

    it("iterates Monday-first by default", function()
      local weekdays = {}
      for weekday in cal.weekdays() do
        weekdays[#weekdays + 1] = weekday
      end
      assert.are_same({ 1, 2, 3, 4, 5, 6, 7 }, weekdays)
    end)

    it("iterates from the requested first weekday", function()
      local weekdays = {}
      for weekday in cal.weekdays(cal.SUNDAY) do
        weekdays[#weekdays + 1] = weekday
      end
      assert.are_same({ 7, 1, 2, 3, 4, 5, 6 }, weekdays)
    end)
  end)

  it("weekheader() returns headers for Sunday-first weeks", function()
    assert.are_equal("Su Mo Tu We Th Fr Sa", cal.weekheader(2, cal.SUNDAY))
  end)

  it("getfirstweekday() returns the module-global default", function()
    assert.are_equal(cal.MONDAY, cal.getfirstweekday())
    cal.setfirstweekday(cal.SUNDAY)
    assert.are_equal(cal.SUNDAY, cal.getfirstweekday())
  end)

  it("firstweekday field is readable and writable as a property", function()
    assert.are_equal(cal.MONDAY, cal.firstweekday)
    cal.firstweekday = cal.SUNDAY
    assert.are_equal(cal.SUNDAY, cal.firstweekday)
    assert.are_equal(cal.SUNDAY, cal.getfirstweekday())
  end)

  ---@diagnostic disable: discard-returns, param-type-mismatch, missing-parameter, assign-type-mismatch

  it("firstweekday field errors on invalid assignment", function()
    assert.Error(function()
      cal.firstweekday = true
    end, "calendar.firstweekday: integer value expected, got true")
  end)

  -- stylua: ignore
  it("errors on invalid argument types", function()
    -- Keep these explicit: some invalid inputs report internal helper names
    -- like `validate_month` instead of the public function name.

    -- Argument #1 validation.

    assert.Error(function() cal.isleap(true)          end, "bad argument #1 to 'isleap' (integer value expected, got true)")
    assert.Error(function() cal.monthrange(2026.5, 3) end, "bad argument #1 to 'monthrange' (integer value expected, got 2026.5)")
    assert.Error(function() cal.setfirstweekday(7.5)  end, "bad argument #1 to 'setfirstweekday' (integer value expected, got 7.5)")
    assert.Error(function() cal.setfirstweekday(true) end, "bad argument #1 to 'setfirstweekday' (integer value expected, got true)")
    assert.Error(function() cal.weekdays(false)       end, "bad argument #1 to 'weekdays' (integer value expected, got false)")
    assert.Error(function() cal.weekheader("2")       end, [[bad argument #1 to 'weekheader' (integer value expected, got "2")]])

    -- Argument #2 validation.

    assert.Error(function() cal.leapdays(2000, false) end, "bad argument #2 to 'leapdays' (integer value expected, got false)")
    assert.Error(function() cal.monthrange(2026)      end, "bad argument #2 to 'monthrange' (integer value expected, got no value)")
    assert.Error(function() cal.weekday(2026, "3", 1) end, [[bad argument #2 to 'weekday' (integer value expected, got "3")]])
    assert.Error(function() cal.weekheader(2, "7")    end, [[bad argument #2 to 'weekheader' (integer value expected, got "7")]])
  end)

  -- stylua: ignore
  it("errors on out-of-range values", function()
    assert.Error(function() cal.monthrange(2026, 0)  end, "bad month number 0; must be 1-12")
    assert.Error(function() cal.monthrange(2026, 13) end, "bad month number 13; must be 1-12")
    assert.Error(function() cal.setfirstweekday(0)   end, "bad weekday number 0; must be 1 (Monday) to 7 (Sunday)")
    assert.Error(function() cal.setfirstweekday(8)   end, "bad weekday number 8; must be 1 (Monday) to 7 (Sunday)")
    assert.Error(function() cal.weekday(2026, 2, 29) end, "bad day number 29 for 2026-02")
    assert.Error(function() cal.weekdays(0)          end, "bad weekday number 0; must be 1 (Monday) to 7 (Sunday)")
    assert.Error(function() cal.weekheader(0)        end, "bad argument #1 to 'weekheader' (width must be a positive integer)")
    assert.Error(function() cal.weekheader(2, 8)     end, "bad weekday number 8; must be 1 (Monday) to 7 (Sunday)")
  end)
end)
