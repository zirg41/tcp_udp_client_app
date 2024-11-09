// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tcp_udp_client_app/core/config/environment.dart' as _i5;
import 'package:tcp_udp_client_app/core/utils/device_info_service.dart' as _i3;
import 'package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart'
    as _i4;

const String _DEV = 'DEV';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singletonAsync<_i3.DeviceInfoService>(() {
      final i = _i3.DeviceInfoService();
      return i.initialize().then((_) => i);
    });
    gh.singleton<_i4.TcpCubit>(() => _i4.TcpCubit());
    gh.factory<_i5.Environment>(
      () => const _i5.DevEnvironment(),
      registerFor: {_DEV},
    );
    return this;
  }
}
