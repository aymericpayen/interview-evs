time = DateTime.new(2024, 9, 13, 9, 0, 0)
while time < DateTime.new(2024, 9, 13, 17, 0, 0)
  value = rand(100..101).round(2)
  PotatoPrice.create(time: time, value: value)
  time += 1.minute
end
