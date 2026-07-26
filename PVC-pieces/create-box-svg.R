##
##

library(svglite)
library(rgl)

df <- xyz.coords(x=c(0,0,100,100,0,0,100,100), y=c(0,100,100,0,0,100,100,0), z=c(0,0,0,0,100,100,100,100))

plot3d(df, xlab="", ylab="", zlab="", type='n', main = "", sub = "", ann = FALSE, axes = FALSE)
box3d()

# Open the SVG graphics device and specify the file name
svglite::svglite("box.svg", width = 4, height = 4) # Set dimensions in inches

# Create your plot (e.g., using base R graphics or ggplot2)

# Close the device to save the file
dev.off()

