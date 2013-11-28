# derived from http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Parallel_algorithm
map = ->
  emit 1, # Or put a GROUP BY key here
    sum: @value # the field you want stats for
    min: @value
    max: @value
    count: 1
    diff: 0 # M2,n:  sum((val-mean)^2)

reduce = (key, values) ->
  a = values[0] # will reduce into here
  i = 1 #!

  while i < values.length
    b = values[i] # will merge 'b' into 'a'
    
    # temp helpers
    delta = a.sum / a.count - b.sum / b.count # a.mean - b.mean
    weight = (a.count * b.count) / (a.count + b.count)
    
    # do the reducing
    a.diff += b.diff + delta * delta * weight
    a.sum += b.sum
    a.count += b.count
    a.min = Math.min(a.min, b.min)
    a.max = Math.max(a.max, b.max)
    i++
  a
finalize = (key, value) ->
  value.avg = value.sum / value.count
  value.variance = value.diff / value.count
  value.stddev = Math.sqrt(value.variance)
  value