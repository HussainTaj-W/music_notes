part of music_notes;

abstract class KeySignature {
  final int number;
  final Accidentals accidental;

  KeySignature(this.number, this.accidental)
      : assert(number != null),
        assert(accidental != null);

  List<Tonality> tonalities;
}