def root(a, b, c)
  d = Math.sqrt(b * b - 4 * a * c)
  r1 = (-b + d) / (2 * a)
  r2 = (-b - d) / (2 * a)
  [r1, r2]
end

def root(a, b, c)
  d = Math.sqrt(b * b - 4 * a * c)
  [r(a, b, d, 1), r(a, b, d, -1)]
end
def r(a, b, d, m)
  (-b + d * m) / (2 * a)
end
