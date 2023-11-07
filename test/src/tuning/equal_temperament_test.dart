import 'package:music_notes/music_notes.dart';
import 'package:test/test.dart';

void main() {
  group('EqualTemperament', () {
    group('.edo', () {
      test('should return the EDO for this EqualTemperament', () {
        expect(const EqualTemperament.edo12().edo, 12);
        expect(const EqualTemperament.edo19().edo, 19);
      });
    });

    group('.ratioFromSemitones()', () {
      test('should return the Ratio from semitones for this EqualTemperament',
          () {
        expect(
          const EqualTemperament.edo12().ratioFromSemitones(),
          const Ratio(1.0594630943592953),
        );
        expect(
          const EqualTemperament.edo12().ratioFromSemitones(12),
          const Ratio(2),
        );

        expect(
          const EqualTemperament.edo19().ratioFromSemitones(),
          const Ratio(1.0371550444461919),
        );
        expect(
          const EqualTemperament.edo19().ratioFromSemitones(19),
          const Ratio(2),
        );
      });
    });

    group('.ratio()', () {
      test(
        'should return the Ratio from a PositionedNote in this '
        'EqualTemperament',
        () {
          const edo12 = EqualTemperament.edo12();
          expect(
            edo12.ratio(Note.g.inOctave(4)),
            const Ratio(0.8908987181403393),
          );
          expect(edo12.ratio(Note.a.inOctave(4)), const Ratio(1));
          expect(
            edo12.ratio(Note.b.flat.inOctave(4)),
            const Ratio(1.0594630943592953),
          );
          expect(edo12.ratio(Note.a.inOctave(5)), const Ratio(2));
          expect(edo12.ratio(Note.a.inOctave(6)), const Ratio(4));
        },
      );
    });

    group('.generator', () {
      test(
        'should return the number of cents for the generator at Interval.P5 in '
        'this EqualTemperament',
        () {
          expect(const EqualTemperament.edo12().generator, const Cent(700));
          expect(
            const EqualTemperament.edo19().generator,
            const Cent(694.7368421052632),
          );
        },
      );
    });

    group('operator ==', () {
      test('should compare this EqualTemperament to other', () {
        // ignore: prefer_const_constructors
        expect(EqualTemperament.edo12(), EqualTemperament.edo12());
        expect(
          const EqualTemperament.edo12(),
          isNot(const EqualTemperament.edo19()),
        );
      });
    });

    group('.toString()', () {
      test(
        'should return the string representation of this EqualTemperament',
        () {
          expect(
            const EqualTemperament.edo12().toString(),
            'EDO 12 (2 2 1 2 2 2 1)',
          );
          expect(
            const EqualTemperament.edo19().toString(),
            'EDO 19 (3 3 2 3 3 3 2)',
          );
        },
      );
    });

    group('.hashCode', () {
      test('should return the same hashCode for equal EqualTemperaments', () {
        expect(
          // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
          EqualTemperament(steps: [1, 2]).hashCode,
          // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
          EqualTemperament(steps: [1, 2]).hashCode,
        );
      });

      test(
        'should return different hashCodes for different EqualTemperaments',
        () {
          expect(
            const EqualTemperament.edo12().hashCode,
            isNot(const EqualTemperament.edo19().hashCode),
          );
          expect(
            const EqualTemperament(steps: [1, 2]).hashCode,
            isNot(const EqualTemperament(steps: [2, 1]).hashCode),
          );
        },
      );
    });
  });
}