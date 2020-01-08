#########################
##  Crime Mapping and        ##
##  Spatial Analysis               ##
##  Lab 6                              ##
##  Introduction to Python    ##
##  Spring 2019                   ##
########################

# Python is very much like R in certain respects. 
# We also use hashtags for comments. We also 
# rely on objects and functions. But there are some 
# key differences.


x = 1

x

y = [1,2,3]

y[0] # why 0?

x/y[1] # why this result?

1/2
1.0/2.0
1/2.0

layer = qgis.utils.iface.activeLayer()

layer.pendingFields()

for field in layer.pendingFields():
    print field.name(), field.typeName()

print layer.fields()[1].name()