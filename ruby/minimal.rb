# Game of Life in 125 chars, adapted from https://gist.github.com/1761463
# A square grid can be done in 123 chars.
life=->g,w,h{(0..w*h-1).map{|i|->n{1 if n==3||(g[i]&&n==2)}[g.values_at(i-w-1,i-w,i-w+1,i-1,i+1,i+w-1,i+w,i+w+1).join.size]}}

# Some setup
width = 80
height = 20
generation = 0
grid = (1..width*height).map { [1, nil].sample }

# Print it out
while true do
  system 'clear'
  grid = life[grid, width, height]
  (0..height-1).each do |y|
    (0..width-1).each do |x|
      print "#{(grid[x+(y*width)] ? '#' : '.')}"
    end
    puts
  end
  puts "Generation: #{generation += 1}"
  sleep 0.1
end
