// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retiro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$retiroProviderHash() => r'04269c3f2dfd84ef1e61559dc33cfa558b7ea922';

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

/// See also [retiroProvider].
@ProviderFor(retiroProvider)
const retiroProviderProvider = RetiroProviderFamily();

/// See also [retiroProvider].
class RetiroProviderFamily extends Family<Retiro> {
  /// See also [retiroProvider].
  const RetiroProviderFamily();

  /// See also [retiroProvider].
  RetiroProviderProvider call(
    Retiro retiro,
  ) {
    return RetiroProviderProvider(
      retiro,
    );
  }

  @override
  RetiroProviderProvider getProviderOverride(
    covariant RetiroProviderProvider provider,
  ) {
    return call(
      provider.retiro,
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
  String? get name => r'retiroProviderProvider';
}

/// See also [retiroProvider].
class RetiroProviderProvider extends AutoDisposeProvider<Retiro> {
  /// See also [retiroProvider].
  RetiroProviderProvider(
    Retiro retiro,
  ) : this._internal(
          (ref) => retiroProvider(
            ref as RetiroProviderRef,
            retiro,
          ),
          from: retiroProviderProvider,
          name: r'retiroProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$retiroProviderHash,
          dependencies: RetiroProviderFamily._dependencies,
          allTransitiveDependencies:
              RetiroProviderFamily._allTransitiveDependencies,
          retiro: retiro,
        );

  RetiroProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.retiro,
  }) : super.internal();

  final Retiro retiro;

  @override
  Override overrideWith(
    Retiro Function(RetiroProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RetiroProviderProvider._internal(
        (ref) => create(ref as RetiroProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        retiro: retiro,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Retiro> createElement() {
    return _RetiroProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RetiroProviderProvider && other.retiro == retiro;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, retiro.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RetiroProviderRef on AutoDisposeProviderRef<Retiro> {
  /// The parameter `retiro` of this provider.
  Retiro get retiro;
}

class _RetiroProviderProviderElement extends AutoDisposeProviderElement<Retiro>
    with RetiroProviderRef {
  _RetiroProviderProviderElement(super.provider);

  @override
  Retiro get retiro => (origin as RetiroProviderProvider).retiro;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
