// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_cart_provaider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$creditCartProvaiderHash() =>
    r'5e066172393a1dd280b7845a90479b6108ed2360';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [creditCartProvaider].
@ProviderFor(creditCartProvaider)
const creditCartProvaiderProvider = CreditCartProvaiderFamily();

/// See also [creditCartProvaider].
class CreditCartProvaiderFamily extends Family<CreditCardEntity> {
  /// See also [creditCartProvaider].
  const CreditCartProvaiderFamily();

  /// See also [creditCartProvaider].
  CreditCartProvaiderProvider call(
    CreditCardEntity creditCardEntity,
  ) {
    return CreditCartProvaiderProvider(
      creditCardEntity,
    );
  }

  @override
  CreditCartProvaiderProvider getProviderOverride(
    covariant CreditCartProvaiderProvider provider,
  ) {
    return call(
      provider.creditCardEntity,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'creditCartProvaiderProvider';
}

/// See also [creditCartProvaider].
class CreditCartProvaiderProvider extends Provider<CreditCardEntity> {
  /// See also [creditCartProvaider].
  CreditCartProvaiderProvider(
    CreditCardEntity creditCardEntity,
  ) : this._internal(
          (ref) => creditCartProvaider(
            ref as CreditCartProvaiderRef,
            creditCardEntity,
          ),
          from: creditCartProvaiderProvider,
          name: r'creditCartProvaiderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$creditCartProvaiderHash,
          dependencies: CreditCartProvaiderFamily._dependencies,
          allTransitiveDependencies:
              CreditCartProvaiderFamily._allTransitiveDependencies,
          creditCardEntity: creditCardEntity,
        );

  CreditCartProvaiderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.creditCardEntity,
  }) : super.internal();

  final CreditCardEntity creditCardEntity;

  @override
  Override overrideWith(
    CreditCardEntity Function(CreditCartProvaiderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreditCartProvaiderProvider._internal(
        (ref) => create(ref as CreditCartProvaiderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        creditCardEntity: creditCardEntity,
      ),
    );
  }

  @override
  ProviderElement<CreditCardEntity> createElement() {
    return _CreditCartProvaiderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreditCartProvaiderProvider &&
        other.creditCardEntity == creditCardEntity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, creditCardEntity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreditCartProvaiderRef on ProviderRef<CreditCardEntity> {
  /// The parameter `creditCardEntity` of this provider.
  CreditCardEntity get creditCardEntity;
}

class _CreditCartProvaiderProviderElement
    extends ProviderElement<CreditCardEntity> with CreditCartProvaiderRef {
  _CreditCartProvaiderProviderElement(super.provider);

  @override
  CreditCardEntity get creditCardEntity =>
      (origin as CreditCartProvaiderProvider).creditCardEntity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
