from igraph import *

# Create graph
g = Graph()
g.add_vertices(3)
g.add_edges([(0,1), (1,2)])
print g

print "============="
for i in range(3):
    print i
    print "degree: " + str(g.degree(i))
    print "in degree: " + str(g.degree(i, type="in"))
    print "out  degree: " + str(g.degree(i, type="out"))

layout = g.layout_kamada_kawai()
plot(g, layout = layout)

nodes = []
def add_node(phone):
    

