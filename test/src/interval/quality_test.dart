import 'dart:collection' show SplayTreeSet;

import 'package:music_notes/music_notes.dart';
import 'package:test/test.dart';

void main() {
  group('Quality', () {
    group('.parse()', () {
      test('throws a FormatException when source is invalid', () {
        expect(() => PerfectQuality.parse('x'), throwsFormatException);
        expect(() => PerfectQuality.parse('a'), throwsFormatException);
        expect(() => PerfectQuality.parse('Abc'), throwsFormatException);
        expect(() => PerfectQuality.parse('abc'), throwsFormatException);
        expect(() => PerfectQuality.parse('mm'), throwsFormatException);
        expect(() => PerfectQuality.parse('MM'), throwsFormatException);
        expect(() => PerfectQuality.parse('p'), throwsFormatException);
        expect(() => PerfectQuality.parse('PP'), throwsFormatException);
        expect(() => PerfectQuality.parse('D'), throwsFormatException);
        expect(() => PerfectQuality.parse('Def'), throwsFormatException);
        expect(() => PerfectQuality.parse('def'), throwsFormatException);

        expect(() => ImperfectQuality.parse('x'), throwsFormatException);
        expect(() => ImperfectQuality.parse('a'), throwsFormatException);
        expect(() => ImperfectQuality.parse('Abc'), throwsFormatException);
        expect(() => ImperfectQuality.parse('abc'), throwsFormatException);
        expect(() => ImperfectQuality.parse('mm'), throwsFormatException);
        expect(() => ImperfectQuality.parse('MM'), throwsFormatException);
        expect(() => ImperfectQuality.parse('p'), throwsFormatException);
        expect(() => ImperfectQuality.parse('PP'), throwsFormatException);
        expect(() => ImperfectQuality.parse('D'), throwsFormatException);
        expect(() => ImperfectQuality.parse('Def'), throwsFormatException);
        expect(() => ImperfectQuality.parse('def'), throwsFormatException);
      });

      test('parses source as a PerfectQuality and return its value', () {
        expect(PerfectQuality.parse('AAA'), PerfectQuality.triplyAugmented);
        expect(PerfectQuality.parse('A'), PerfectQuality.augmented);
        expect(PerfectQuality.parse('P'), PerfectQuality.perfect);
        expect(PerfectQuality.parse('d'), PerfectQuality.diminished);
        expect(PerfectQuality.parse('ddd'), PerfectQuality.triplyDiminished);
      });

      test('parses source as an ImperfectQuality and return its value', () {
        expect(
          ImperfectQuality.parse('AAA'),
          ImperfectQuality.triplyAugmented,
        );
        expect(ImperfectQuality.parse('A'), ImperfectQuality.augmented);
        expect(ImperfectQuality.parse('M'), ImperfectQuality.major);
        expect(ImperfectQuality.parse('m'), ImperfectQuality.minor);
        expect(ImperfectQuality.parse('d'), ImperfectQuality.diminished);
        expect(
          ImperfectQuality.parse('ddd'),
          ImperfectQuality.triplyDiminished,
        );
      });
    });

    group('.inverted', () {
      test('returns the inverted of this Quality', () {
        expect(
          PerfectQuality.triplyDiminished.inverted,
          PerfectQuality.triplyAugmented,
        );
        expect(PerfectQuality.diminished.inverted, PerfectQuality.augmented);
        expect(PerfectQuality.perfect.inverted, PerfectQuality.perfect);
        expect(PerfectQuality.augmented.inverted, PerfectQuality.diminished);
        expect(
          PerfectQuality.triplyAugmented.inverted,
          PerfectQuality.triplyDiminished,
        );

        expect(
          ImperfectQuality.doublyDiminished.inverted,
          ImperfectQuality.doublyAugmented,
        );
        expect(
          ImperfectQuality.diminished.inverted,
          ImperfectQuality.augmented,
        );
        expect(ImperfectQuality.minor.inverted, ImperfectQuality.major);
        expect(ImperfectQuality.major.inverted, ImperfectQuality.minor);
        expect(
          ImperfectQuality.augmented.inverted,
          ImperfectQuality.diminished,
        );
        expect(
          ImperfectQuality.doublyAugmented.inverted,
          ImperfectQuality.doublyDiminished,
        );
      });
    });

    group('.toString()', () {
      test('returns a string representation of this Quality', () {
        expect(PerfectQuality.triplyDiminished.toString(), 'ddd');
        expect(PerfectQuality.doublyDiminished.toString(), 'dd');
        expect(PerfectQuality.diminished.toString(), 'd');
        expect(PerfectQuality.perfect.toString(), 'P');
        expect(PerfectQuality.augmented.toString(), 'A');
        expect(PerfectQuality.doublyAugmented.toString(), 'AA');
        expect(PerfectQuality.triplyAugmented.toString(), 'AAA');

        expect(ImperfectQuality.triplyDiminished.toString(), 'ddd');
        expect(ImperfectQuality.doublyDiminished.toString(), 'dd');
        expect(ImperfectQuality.diminished.toString(), 'd');
        expect(ImperfectQuality.minor.toString(), 'm');
        expect(ImperfectQuality.major.toString(), 'M');
        expect(ImperfectQuality.augmented.toString(), 'A');
        expect(ImperfectQuality.doublyAugmented.toString(), 'AA');
        expect(ImperfectQuality.triplyAugmented.toString(), 'AAA');
      });
    });

    group('.hashCode', () {
      test('ignores equal Quality instances in a Set', () {
        final collection = {
          const PerfectQuality(5),
          const ImperfectQuality(5),
          PerfectQuality.diminished,
          PerfectQuality.perfect,
          ImperfectQuality.minor,
        };
        collection.addAll(collection);
        expect(collection.toList(), const [
          PerfectQuality(5),
          ImperfectQuality(5),
          PerfectQuality.diminished,
          PerfectQuality.perfect,
          ImperfectQuality.minor,
        ]);
      });
    });

    group('.compareTo()', () {
      test('sorts Qualities in a collection', () {
        final orderedSet = SplayTreeSet<Quality>.of({
          const PerfectQuality(5),
          const ImperfectQuality(5),
          ImperfectQuality.major,
          PerfectQuality.perfect,
          PerfectQuality.diminished,
          ImperfectQuality.diminished,
          ImperfectQuality.augmented,
        });
        expect(orderedSet.toList(), const [
          ImperfectQuality.diminished,
          PerfectQuality.diminished,
          PerfectQuality.perfect,
          ImperfectQuality.major,
          ImperfectQuality.augmented,
          ImperfectQuality(5),
          PerfectQuality(5),
        ]);
      });
    });
  });
}
