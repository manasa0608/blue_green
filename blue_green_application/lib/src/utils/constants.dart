import '../models/generic_model.dart';

const localhostUrl = 'http://localhost:8080';

const host = 'localhost';
const database = 'bluegreen';
const username = 'manasas';
const password = 'manasa';

var genericComponents = [
  GenericComponent(10, [], [6], 1),
  GenericComponent(20, [], [6], 2),
  GenericComponent(30, [], [7], 3),
  GenericComponent(45, [], [7], 4),
  GenericComponent(55, [], [7], 5),
  GenericComponent(30, [1, 2], [8], 6),
  GenericComponent(130, [3, 4, 5], [8], 7),
  GenericComponent(160, [6, 7], [], 8),
];
