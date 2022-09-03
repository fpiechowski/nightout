import 'package:duration/duration.dart';

const String hangingOutId = "hangingOut";
const String goingOutId = "goingOut";
const String unknownId = "unknown";

abstract class GroupStatus with Comparable<GroupStatus> {
  GroupStatus(this.label);

  abstract final String id;

  final String label;

  factory GroupStatus.hangingOut() => HangingOutGroupStatus();

  factory GroupStatus.unknown() => UnknownGroupStatus();

  factory GroupStatus.goingOut(DateTime dateTime) =>
      GoingOutGroupStatus(dateTime);

  static GroupStatus fromId(String id, {DateTime? goingOutDateTime}) {
    switch (id) {
      case hangingOutId:
        return HangingOutGroupStatus();
      case goingOutId:
        return GoingOutGroupStatus(goingOutDateTime!);
      case unknownId:
        return UnknownGroupStatus();
      default:
        throw "Unknown GroupStatus ID";
    }
  }
}

class HangingOutGroupStatus extends GroupStatus {
  HangingOutGroupStatus() : super("Hanging out");

  @override
  final String id = "hangingOut";

  @override
  int compareTo(GroupStatus other) {
    final int comparison;

    switch (other.runtimeType) {
      case HangingOutGroupStatus:
        comparison = 0;
        break;
      case UnknownGroupStatus:
        comparison = -2;
        break;
      case GoingOutGroupStatus:
        comparison = -1;
        break;
      default:
        throw "unknown GroupStatus type ${other.runtimeType}";
    }

    return comparison;
  }
}

class GoingOutGroupStatus extends GroupStatus {
  @override
  final String id = "goingOut";

  final DateTime dateTime;

  GoingOutGroupStatus(this.dateTime)
      : super(
      "Out in ${prettyDuration(DateTime.now().difference(dateTime).abs(), tersity: DurationTersity.minute)}");

  @override
  int compareTo(GroupStatus other) {
    final int comparison;

    switch (other.runtimeType) {
      case HangingOutGroupStatus:
        comparison = 1;
        break;
      case GoingOutGroupStatus:
        comparison =
            dateTime.compareTo((other as GoingOutGroupStatus).dateTime);
        break;
      case UnknownGroupStatus:
        comparison = -1;
        break;
      default:
        throw "unknown GroupStatus type ${other.runtimeType}";
    }

    return comparison;
  }
}

class UnknownGroupStatus extends GroupStatus {
  @override
  final String id = "unknown";

  UnknownGroupStatus() : super("Unknown");

  @override
  int compareTo(GroupStatus other) {
    final int comparison;

    switch (other.runtimeType) {
      case UnknownGroupStatus:
        comparison = 0;
        break;
      case GoingOutGroupStatus:
        comparison = 1;
        break;
      case HangingOutGroupStatus:
        comparison = 2;
        break;
      default:
        throw "unknown GroupStatus type ${other.runtimeType}";
    }

    return comparison;
  }
}
