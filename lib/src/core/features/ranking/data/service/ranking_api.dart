class RankingApi {
  Future<List<Map<String, dynamic>>> fetchRankingUsers() async {
    // Mock data - simulating API delay
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      {
        'id': '1',
        'name': 'Alex Johnson',
        'imageUrl': 'https://i.pravatar.cc/150?img=1',
        'rank': 1,
        'score': 5000,
      },
      {
        'id': '2',
        'name': 'Sarah Williams',
        'imageUrl': 'https://i.pravatar.cc/150?img=2',
        'rank': 2,
        'score': 4800,
      },
      {
        'id': '3',
        'name': 'Michael Brown',
        'imageUrl': 'https://i.pravatar.cc/150?img=3',
        'rank': 3,
        'score': 4500,
      },
      {
        'id': '4',
        'name': 'Emily Davis',
        'imageUrl': 'https://i.pravatar.cc/150?img=4',
        'rank': 4,
        'score': 4200,
      },
      {
        'id': '5',
        'name': 'Test User',
        'imageUrl': 'https://i.pravatar.cc/150?img=5',
        'rank': 5,
        'score': 1250,
      },
      {
        'id': '6',
        'name': 'David Miller',
        'imageUrl': 'https://i.pravatar.cc/150?img=6',
        'rank': 6,
        'score': 3800,
      },
      {
        'id': '7',
        'name': 'Jessica Wilson',
        'imageUrl': 'https://i.pravatar.cc/150?img=7',
        'rank': 7,
        'score': 3500,
      },
      {
        'id': '8',
        'name': 'James Moore',
        'imageUrl': 'https://i.pravatar.cc/150?img=8',
        'rank': 8,
        'score': 3200,
      },
      {
        'id': '9',
        'name': 'Lisa Taylor',
        'imageUrl': 'https://i.pravatar.cc/150?img=9',
        'rank': 9,
        'score': 3000,
      },
      {
        'id': '10',
        'name': 'Robert Anderson',
        'imageUrl': 'https://i.pravatar.cc/150?img=10',
        'rank': 10,
        'score': 2800,
      },
    ];
  }
}
