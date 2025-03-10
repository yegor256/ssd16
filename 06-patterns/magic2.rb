# SPDX-FileCopyrightText: Copyright (c) 2021 Yegor Bugayenko
# SPDX-License-Identifier: MIT

def h2sec(h)
  return h * 60 * 60
end

def (h)
  seconds_in_minutes = 60
  minutes_in_hours = 60
  return h * seconds_in_minutes * minutes_in_hours
end
