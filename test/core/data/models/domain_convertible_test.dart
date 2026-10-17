import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:flutter_test/flutter_test.dart';

/// A simple domain class for testing purposes.
class const TestDomainEntity(final String id);

/// A concrete implementation of [DomainConvertible] for testing.
class const TestDto(final String id)
    implements DomainConvertible<TestDomainEntity> {
  @override
  TestDomainEntity toDomain() {
    return TestDomainEntity(id);
  }
}

void main() {
  group('DomainConvertible', () {
    test('should convert implementing class to expected domain type', () {
      const dto = TestDto('123');
      final result = dto.toDomain();

      expect(result, isA<TestDomainEntity>());
      expect(result.id, '123');
    });
  });
}
