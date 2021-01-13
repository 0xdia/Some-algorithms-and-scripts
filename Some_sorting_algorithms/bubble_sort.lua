
-- Bubble sort algorithm implementation
-- Sort the elements in ascending order

function bubble_sort(list)
  local n = #list
  for i=1, #list do
    for j=1, n-1 do
      if list[j] > list[j+1] then
        local t = list[j]
        list[j] = list[j+1]
        list[j+1] = t
      end
    end

    n = n - 1
  end
end


print("Input the size of the list")
local n = io.read("*n")
local list = {}

for i=1, n do
  table.insert(list, io.read("*n"))
end

-- bubble_sort(list)
print("This is your sorted list")
bubble_sort(list)
for i=1, #list do
  io.write(list[i].." ")
end
print()
