import strutils, sequtils

let f = readFile("dataset")
var nums = f.split("\n").map(parseInt)
var i = 0
for num in nums:
  for j in countup(i+1, nums.len-1):
      if nums[i] + nums[j] == 2020:
        echo nums[i], " * ", nums[j], " = ", nums[i] * nums[j]
      for k in countup(j+1, nums.len-1):
        if nums[i] + nums[j] + nums[k] == 2020:
          echo nums[i], " * ", nums[j], " * ", nums[k], " = ", nums[i] * nums[j] * nums[k]
  inc i
