

# use bigvis to bin, condense, smooth and present data
library('bigvis')
library('ggplot2')

# subset the diamonds data
mydiamonds <- subset(diamonds, carat < 2.75)

# condense avg price based on bins of carat sizes of .1 carat intervals
myd <- condense(bin(mydiamonds$carat, .1), z=mydiamonds$price, summary="mean")
# smooth out the trend
myds <- smooth(myd, 50, var=".mean", type="robust")

# plot the orginal binned prices vs the smoothed trend line
ggplot() + geom_line(data=myd, aes(x=mydiamonds.carat, y=.mean, colour="Avg Price")) + 
    geom_line(data=myds, aes(x=mydiamonds.carat, y=.mean, colour="Smoothed")) + 
    ggtitle("Avg Diamond prices by binned Carat") + 
    ylab("Avg Price") + 
    xlab("Carats") + 
    scale_colour_manual("", breaks=c("Avg Price","Smoothed"), values=c("blue", "black"))
