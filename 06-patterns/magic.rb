# SPDX-FileCopyrightText: Copyright (c) 2021 Yegor Bugayenko
# SPDX-License-Identifier: MIT

def points
  File.readlines("/data/users.csv") # why here?
    .map { |t| t.split(',', 11) } # what is 11?
    .map { a[7].to_i } # why 7?
    .inject(&:+)
end
