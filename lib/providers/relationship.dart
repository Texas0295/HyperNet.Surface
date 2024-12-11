import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/account.dart';

class SnRelationshipProvider {
  late final SnNetworkProvider _sn;

  SnRelationshipProvider(BuildContext context) {
    _sn = context.read<SnNetworkProvider>();
  }

  Future<SnRelationship?> getRelationship(int relatedId) async {
    try {
      final resp = await _sn.client.get('/cgi/id/users/me/relations/$relatedId');
      return SnRelationship.fromJson(resp.data);
    } catch (err) {
      return null;
    }
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
