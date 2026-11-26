/// A DTO that maps to the domain model [R]. Repositories call [toDomain] so
/// notifiers never see a DTO.
abstract interface class DomainConvertible<R> {
  R toDomain();
}
