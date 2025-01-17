part of 'models.dart';

class EventData extends Equatable {
  final int? id;
  final String? state;
  final String? title;
  final String? desc;
  final String? date;
  final String? credit;
  EventData(
      {this.id, this.state, this.title, this.desc, this.date, this.credit});

  @override
  // TODO: implement props
  List<Object?> get props => [id, state, desc, title, date, credit];
}