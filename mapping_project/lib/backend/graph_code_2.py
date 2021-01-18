import math

thisdict = { # dictionary containing all room data
    }

thisdict[1]=[[3,9],[4,8],[5,5]]#first number = room number. second = distance of connection
thisdict[2]=[[4,3],[5,6]]
thisdict[3]=[[1,9],[5,10]]
thisdict[4]=[[1,8],[2,3]]
thisdict[5]=[[1,5],[2,6],[3,10]]

def findifconnect(room1,room2): # function to determine whether there is a direct connection betweent two points
    x = thisdict[room1] # x contains all data for room1 with all connections and distances
    for i in range(len(x)): # loop through each connection list eg if room1 = 1, when i = 0, x = [2,6].
        if x[i][0] == room2: # if the room number that room1 connects to is room2 do this:
            return True
    return False

def finddist(room1,room2):# function to find distance between 2 rooms
    x = thisdict[room1]
    for i in range(len(x)):
        if x[i][0] == room2:# searchs through the connections list and finds the one with room2 and returns the dist
            return x[i][1]
def addconnection(room1,room2,dist): # add connections
    global thisdict
    thisdict[room1].append([room2,dist])
    thisdict[room2].append([room1,dist])
def addroom(room):
    global thisdict
    thisdict[room] = []

def updatedist(room1,room2,dist): # change
    global thisdict
    for i in range(len(thisdict[room1])):
        if thisdict[room1][i][0] == room2:
            thisdict[room1][i] = [room2,dist]
            break
    for i in range(len(thisdict[room2])):
        if thisdict[room2][i][0] == room1:
            thisdict[room2][i] = [room1,dist]

def shortest_dist_dijkstars(room1,room2):
    unfinished = []    # list with all rooms that have no confirmed shortest distance to room1
    finished = {}    # dictionary with all rooms that have a confirmed shortest distance to room1 (key = room  number, value[0] = dist to source, value[1] = last connection for shortest path
    for i in thisdict:
        unfinished.append([i,math.inf,"none"]) #math.inf = floating point represenation of infinity. can be used with <, >, =
        finished[i] = [math.inf,"none"]
        #loops through thisdict which contains all the rooms and adding their number, the word infinite and the word none into a list within the "unfinished" list
        # 0 = room number, 1 = shortest distance currently known, 2 = last connection for this shortest distance

    # need to put room1 at the front of the list and set its dist to 0
    for i in range(len(unfinished)):
        switch = [0,0]
        # we switch room1 and the room at 0 and put the room at 0 at the end
        if unfinished[i][0] == room1: #when we find room1
            unfinished[i][1] = 0 # room1 to room1 clearly equals 0 not infinity
            # puts them into switch list so there is no data loss
            switch[0] = unfinished[0]
            switch[1] = unfinished[i]
            if switch[0] != switch[1]: # don't do anything if we are witching the same 2 rooms
                # otherwise we duplicate
                unfinished[0] = switch[1]
                unfinished.append(switch[0])
            break #break as no point in continuing the for loop

    #Set distance to room1 equal to 0 in finished:
    finished[room1][0] = 0

    #EXAMPLE:
    # unfinished = [[1, 0, 'none'], [2, math.inf, 'none'], [3, math.inf, 'none']]
    # thisdict = {1: [[2, 6], [3, 7]], 2: [[1, 6]], 3: [[1, 7]]}
    # finished = {1:[0,'none'],2:[math.inf,'none'],3:[math.inf,'none']}

    while len(unfinished) != 0:
        #Bring room with smallest distance to front of list (required by algorithm)
        min_dist = math.inf #ensures that no room will start off with a distance larger than min_dist
        for room in unfinished:
            if room[1] < min_dist: # found a new minimum dist
                min_dist = room[1]
        #Now, find the room with distance equal to min_dist, and bring it to the front
        for room in unfinished:
            if room[1] == min_dist: # found the room
                unfinished.remove(room)
                unfinished = [room]+unfinished #add the room to the start of unfinished
                break

        #unfinished[0] (room number unfinished[0][0]) is current node
        for unvisited_node_shortest_connection_data in thisdict[unfinished[0][0]]: # EXAMPLE: loop through thisdict[1] = [[2, 6], [3, 7]] i = [2,6]
            #unvisited_node_shortest_connection_data[0] = room number of neighbour, [1] = distance to neighbour
            #finds the connection data of the room number of the first list within the list as this room has the shortest distance between it and room1
            #find the shortest current connection
            new_dist = unvisited_node_shortest_connection_data[1] + unfinished[0][1] # = dist from source -> current node + dist from current node -> neighbour
            if new_dist < finished[unvisited_node_shortest_connection_data[0]][0]: # LHS is dist to neighbour through current node. RHS is old minimum dist
                #update finished
                finished[unvisited_node_shortest_connection_data[0]][0] = new_dist #update older min dist to new min dist
                finished[unvisited_node_shortest_connection_data[0]][1] = unfinished[0][0] #update older preceding node to new preceding node (new preceding node is just current)
        #update unfinished (doing it after for loop, so it can all be done at one time and so save time) with values from finished
        for room_index,room in enumerate(unfinished):
            room_number = room[0]
            unfinished[room_index][1] = finished[room_number][0]
            unfinished[room_index][2] = finished[room_number][1]


        unfinished.remove(unfinished[0])
    #print(unfinished)
    print(finished)
    output=[room2]
    output2 = 0
    path = False
    while path == False:
        addon = finished[output[len(output)-1]]
        output.append(addon[1])
        output2 += addon[0]
        if output[-1] == room1:
            path = True
    print(output)
    print(output2)

shortest_dist_dijkstars(1,2)
