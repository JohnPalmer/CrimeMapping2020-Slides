#########################
##  Crime Mapping and  ##
##  Spatial Analysis   ##
##  Lab 6              ##
##  Introduction to R  ##
##  Spring 2019        ##
#########################

# This is an example of an R script. Any line that starts with a hashtag (#) is treated as a comment and will not be executed when the script is passed to the R interpreter.

# Let's start with some basics. You can treat R as a very fancy calculator by simply typing math expressions:

1+1 # put the cursor on this line (or highlight it) and press control-enter to pass it to the R interpreter. You will see the input code, followed by R's response, in the console below. Now try the others, just to get a sense of the basic operators
1/2
2*2
2^3
2**3 # Do you see what this double-star operator does?
2*2-4
2*(2-4)

# Now let's try some logical operators:
1>2
1<2
1==1
1==2
"a" == "a"
"a" == "b"
# Do you get the point? Why would we want to do this? We know 1 is less than 2, so why do we need R to tell us that? Also, why do we use the double equals sign instead of simply the equals sign? 

a = 1
a
b = 2
b
# What have we done here?
a<b
b>b
a==b
# Do you see how this works? Now what if we use the single equals sign?
a = b 
a
b
# What happened here?

# a and b are objects and we have assigned values to them using the single equals sign. In R, you can assign values to objects that way or like this:
a <- 3 # This is equivalent to:
a = 3 # Many people prefer the former (<-) as a matter of style because it makes the code more readable. You can also use the arror in the other direction:
3 -> a # This does exactly the same thing as the previous two lines.

# What kind of objects are a and b here? We can find out like this:
class(a) # The concept of a class is very important in R (and many other programming languages). Each class of objects has certain properties. Moreover, classes can have subclasses, which inheret the properties of the parent class and then add some more. To see some other examples of classes, try this:
c = "1"
class(c)
c + a # Why does this produce an error?
# You can sometimes change the class of an object:
as.numeric(c) + a # See how this works? But be careful. What happens here:
d = "hello"
d
e = as.numeric(d)
e
e + a
# What is this NA thing? NA is R's way of writing a missing value. It stands for "Not Available". Does e have a class?
class(e) # Why would we want to have an object that only stores NA? This will become clear later on.
f = a < b
f
class(f) # So here wee have another class.
as.numeric(f)
f = a > b
f
as.numeric(f) # See what happens when we coerce a logical object into a numeric one?

# The numeric class stores real numbers with double precision.
pi
class(pi)
class(1/3)

# We can also store numbers as integers:
a = as.integer(pi)
a
class(a)

# Notice that we need to be explicit to create an integer. By default, I treats numbers as double-precision reals. Notice also that when we divide an integer by a numeric, we get a numeric. This also happens when we divide an integer by another integer:
as.integer(1) / 2
as.integer(1) / as.integer(2)
class(as.integer(2) / as.integer(1))
# This seems normal, as it is probably what you are used to from using a standard calculator. Be careful in other languages, though (such as python), which are often more strict about classes and will sometimes produce unexpected results (for example using floor division when there is an integer involved).


# All of this is great, but for most of our analysis, it will be useful to have objects that store more information than this. One of this is a vector, which you can create using the c function. (The c is for "concatenate"):
v = c(2, 3, 4, 5, 6, 7)
v
class(v) # Notice this has the same numeric class as our single-valued a. (In fact, R treats a as a vector with a single element.) We can select one element of v like this:
v[1] # this grabs the first element of the vector
v[2] # this grabs the second element
v[c(1,2,3)] # this grabs elements 1, 2, and 3. (Notice that we specify these as their own vector here.)
v[c(1,3,5)] # this grabs elements 1, 3, and 5
v[1:4] # The colon (:) is a way of getting the full sequance of numbers. For example:
1:3
1:5

w = c("a", "b", "c") # What kind of vector it this?
w
class(w)

x = c("a", 1, TRUE) # What about this?
x
class(x) # What is happending here?
x = c(1, TRUE, 2)
x
class(x)
# What you can see from the above lines, is that mixing classes within a vector results in the coercion of all elements to one class or another.

# In addition to vectors, it is really useful to have matrixes:
m = matrix(1:12, nrow = 4, ncol = 3)
m
class(m)
m[1] # we can subset a matrix just like a vector.
m[5]
m[1,2] # we can also subset using two values - one for row and the other for column. Or we can subset an entire row or column:
m[1,]
m[,1]

# we can also create a matrix by binding vectors together:
a = c(1, 2, 3)
b = c(4, 5, 6)
m = rbind(a, b)
m
m = cbind(a, b)
m

c = c("a", "b", "c")
c
m = rbind(a, c) # But notice that when we bind vectors of different classes into a matrix, R coerces them to be all one class.
m
class(m[1])
class(m[2])

# For our analysis, we will often want to group data of different classes. For instance, the crime datasets we have been using have columns with numeric values and columns with character values. How do we deal with this? The object we want here is a dataframe:
d = data.frame(a, c)
d
d[1,]
d[,1]
d[,2]
class(d)
class(d[1,1])
class(d[1,2])
class(d[,1])
class(d[,2])
# What is the class of the second column of our dataframe? How did that happen? R's dataframe function coerces character vectors into factors. This is actually something we will often not want, so we can stop it from doing so this way:
d = data.frame(a, c, stringsAsFactors = FALSE) 
d
class(d[,2])

# Notice what we did here: We called a function (data.frame) and we gave it arguments, each separated by a comma. The first two arguments were the vectors that would make up the dataframe. The third argument was the stringsAsFactors setting (which we set to false). Functions are another key part of R (and most programming languages). In R, the arguments of the function can be specified based on the order they are added (as we did with the first two), or based on names (as we did with the third). To learn about the arguments a function takes and what it does, use the help function:
help(data.frame)

# You can also write your own functions:
myAwesomeFunction = function(x=1, y=2) {
  r1 = x + y
  r2 = r1^2
  r3 = r2 - 200
  return(r3)
}

myAwesomeFunction()
myAwesomeFunction(x=2, y=4)
myAwesomeFunction(2, 4)
myAwesomeFunction(2)
myAwesomeFunction
# What do each of the above lines do? Why did we specify values for x and y in the function? What if we had not done this? Try writing the function again without specifying these and see what happens.
# Can you write this function in a more concise way?

# What if you write a bunch of functions that you often use. Is there a way to access these without writing them again each time? You could save them in a file and then load this file using the source function. For example:

sink("myFunctions.R") # sink starts a new file and sends the output to that file
myAwesomeFunction # calling your function without any parenthesis simply outputs the function code itself
sink() # sink() closes the connection to the file you are writing. You can now find this file on your machine and take a look.

source("myFunctions.R") # this loads the contents of the myFunctions.R file into memory - making the functions accessible.

# Another way of reusing functions is to package them into an R library (sometimes called an R package). You can make these yourself and you can even publish them to a public repository so others can use them. One of the most powerful things about R is the enormous number of libraries that have been written by contributers from a wide array of fields. You can see many of these by clicking the "Packages" tab in the bottom right panel of R Studio. You can easily install and update packages from that panel. To use them in your R session, load them like this:
library(tidyverse) # This loads the tidyverse library. If you have not installed it first, though, it will throw an error. 

# tidyverse is actually a set of packages, which are very useful. Notice that when you first load it, R tells you the packages that it includes, and also a set of conflicts. The conflicts are functions that have the same names as other functions already in memory. In this case, it is telling us that the filder and lag functions from dplyr (part of tidyvers) have the same names as functions already loaded in the stats package (which loads with R). Since we have loaded dplyr after stats, we have masked the stats functions. Calling these names now will called the dplyr ones. This issue of masking also comes up with objects. Be careful when you create objects and then later reuse the names, as you may be overwriting objects you still need. You also may want to clear all objects from memory to start on a clean slate. You can do so like this:
rm(list=ls()) 

# Here is an example of how you can load csv data using tidyverse (you will need to change the file name and put it in the working directory to make this work:
D = read_csv("chicago_crime_map_ytd_2019_01_14.csv") 
D
class(D)

# tidyverse has read the file as what it calls a tibble. This is an enhanced dataframe. It has all of the characteristics (and functions) of a dataframe and then extra ones that turn out to be very useful. One issue though, is that the column names in our original data had spaces in them, and this can cause problems:
names(D) # The names function gives us the column names of our dataframe

# We can fix this as follows: 
D = rename_all(D, make.names, unique=TRUE)
names(D) # see what we did?

# In fact on of the nice things about tidyverse is that we can load the data and do fix the names at the same time:
D = read_csv("chicago_crime_map_ytd_2019_01_14.csv") %>% rename_all(make.names, unique=TRUE) # We are using this special %>% command here, which is a way of chaining together multiple commands. The output from the first chunk is sent through %>% to the second chunk and the final result is then assigned to D.

# For this data, it would be nice to work more with the times. There is a great library for dealing with dates and times:
library(lubridate)

# Now look through the rest of the code to see how we can plot and analyze the clusters in this data:
D = read_csv("chicago_crime_map_ytd_2019_01_14.csv") %>% rename_all(make.names, unique=TRUE)%>% mutate(ts=mdy_hms(D$DATE..OF.OCCURRENCE, tz = "America/Chicago"), hour=hour(ts), hourd = as.integer(hour)+minute(ts)/60, day=day(ts), dayd=as.integer(day)+as.integer(hour)/24)

library(scatterplot3d)

scatterplot3d(as.data.frame(D[, c("X.COORDINATE", "Y.COORDINATE", "hourd")]), pch = 20, xlab = "easting", ylab="northing", cex.symbols = .1, zlab="time", x.ticklabs = NA, y.ticklabs = NA, z.ticklabs=NA)

plot(density(D$hour))

hist(D$hour)

D_ts = D %>% group_by(dayd) %>% summarise(n=n())              

ggplot(D_ts, aes(x=dayd, y=n)) + geom_line() + xlab("days since start of 2019") + ylab("number crime reports")
ggsave("chicago_hourly.png")

ggplot(D, aes(x=hour)) + geom_bar()
ggsave("chicago_hour_bar.png")

crime_locs = D %>% select(X.COORDINATE, Y.COORDINATE) %>% filter(complete.cases(.))

clusters = kmeans(crime_locs,9)

plot(crime_locs, col=clusters$cluster, pch=20)

sum(clusters$withinss)

K=20
ss = rep(NA, K)
for (i in 1:K) {
  clusters=kmeans(crime_locs, centers=i)
  ss[i] = sum(clusters$withinss)
}

cluster_results = data_frame(n=1:K, ss=ss)

ggplot(cluster_results, aes(x=n, y=ss)) + geom_line() + xlab("K") + ylab("Sum of Squares")
ggsave("cluster_comparison_elbow.png")

clusters = kmeans(crime_locs,5)
crime_locs = crime_locs %>% mutate(cluster=clusters$cluster)
ggplot(crime_locs, aes(x=X.COORDINATE, y=Y.COORDINATE, color=factor(cluster))) + geom_point() + theme(axis.line=element_blank(),axis.text.x=element_blank(), axis.text.y=element_blank(),axis.ticks=element_blank(), axis.title.x=element_blank(), axis.title.y=element_blank(),legend.position="none")
ggsave("clusters_5.png")
