class Backend {
  final Map<int, List<List<int>>> thisdict = {
    1: [
      [3, 9],
      [4, 5],
      [4, 8],
      [5, 5]
    ],
    2: [
      [4, 3],
      [5, 6]
    ],
    3: [
      [1, 9],
      [5, 10]
    ],
    4: [
      [1, 8],
      [2, 3]
    ],
    5: [
      [1, 5],
      [2, 6],
      [3, 10]
    ]
  };

  bool findIfConnect(int room1, int room2) {
    List<List<int>> x = thisdict[room1];
    for (var i = 0; i < x.length; i++) {
      if (x[i][0] == room2) {
        return true;
      }
    }
    return false;
  }

  int finddist(int room1, int room2) {
    List<List<int>> x = thisdict[room1];
    for (var i = 0; i < x.length; i++) {
      if (x[i][0] == room2) {
        return x[i][0];
      }
    }
    return null;
  }

  void addconnection(int room1, int room2, int dist) {
    thisdict[room1].add([room2, dist]);
    thisdict[room2].add([room1, dist]);
  }

  void addroom(int room) {
    thisdict[room] = new List<List<int>>();
  }

  void updatedist(int room1, int room2, int dist) {
    for (var i = 0; i < thisdict[room1].length; i++) {
      if (thisdict[room1][i][0] == room2) {
        thisdict[room1][i] = [room2, dist];
        break;
      }
    }
    for (var j = 0; j < thisdict[room2].length; j++) {
      if (thisdict[room2][j][0] == room1) {
        thisdict[room2][j] = [room1, dist];
        break;
      }
    }
  }

  void shortestDistDijkstras(int room1, int room2) {
    List<List<Object>> unfinished = new List<List<Object>>();
    Map<int, List<Object>> finished = {};

    thisdict.forEach((key, value) {
      unfinished.add([key, double.infinity, "none"]);
      finished.addAll({
        key: [double.infinity, "none"]
      });
    });

    for (var i = 0; i < unfinished.length; i++) {
      List<List<Object>> swap = new List<List<Object>>();

      if (unfinished[i][0] == room1) {
        unfinished[i][1] = 0;
        swap.add(unfinished[0]);
        swap.add(unfinished[1]);
        if (swap[0] != swap[1]) {
          unfinished[0] = swap[1];
          unfinished.add(swap[0]);
        }
        break;
      }
    }

    finished[room1][0] = 0;

    while (unfinished.length != 0) {
      double minDist = double.infinity;
      for (var room in unfinished) {
        if (double.parse(room[1]) < minDist) {
          minDist = double.parse(room[1]);
        }
      }

      for (var room in unfinished) {
        if (double.parse(room[1]) == minDist) {
          unfinished.remove(room);
          unfinished.insert(0, [room]);
          break;
        }
      }

      for (var unvisitedNodeShortestConnectionData
          in thisdict[unfinished[0][0]]) {
        int newDist = unvisitedNodeShortestConnectionData[1] + unfinished[0][1];
        if (newDist < finished[unvisitedNodeShortestConnectionData[0]][0]) {
          finished[unvisitedNodeShortestConnectionData[0]][0] = newDist;
          finished[unvisitedNodeShortestConnectionData[0]][1] =
              unfinished[0][0];
        }
      }

      int roomIndex = 0;
      for (var room in unfinished) {
        int roomNumber = room[0];
        unfinished[roomIndex][1] = finished[roomNumber][0];
        unfinished[roomIndex][2] = finished[roomNumber][1];
        roomIndex++;
      }

      unfinished.remove(unfinished[0]);
    }

    print(finished);

    List<int> output = [room2];
    int output2 = 0;
    bool path = false;

    while (!path) {
      List<Object> addon = finished[output[output.length - 1]];
      output.add(addon[1]);
      output2 += addon[0];

      if (output.last == room1) {
        path = true;
      }
    }

    print(output);
    print(output2);
  }
}
