import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';

class SnRelationshipProvider {
  late final SnNetworkProvider _sn;

  SnRelationshipProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  Future<void> updateRelationship(
    int relatedId,
    int status,
    Map<String, dynamic> permNodes,
  ) async {
    await _sn.client.put('/cgi/id/users/me/relations/$relatedId', data: {
      'status': status,
      'perm_nodes': permNodes,
    });
  }

  Future<void> deleteRelationship(int relatedId) async {
    await _sn.client.delete('/cgi/id/users/me/relations/$relatedId');
  }

  Future<void> acceptFriendRequest(int relatedId) async {
    await _sn.client.post('/cgi/id/users/me/relations/$relatedId/accept');
  }

  Future<void> declineFriendRequest(int relatedId) async {
    await _sn.client.post('/cgi/id/users/me/relations/$relatedId/decline');
  }
}
