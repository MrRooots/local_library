import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_library/data/data_sources/local/customer_local_data_source.dart';
import 'package:local_library/data/data_sources/remote/book_remote_data_source.dart';
import 'package:local_library/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:local_library/data/data_sources/remote/customer_remote_data_source.dart';
import 'package:local_library/data/data_sources/remote/request_remote_data_source.dart';
import 'package:local_library/data/repositories/book_repository_impl.dart';
import 'package:local_library/data/repositories/cart_repository_impl.dart';
import 'package:local_library/data/repositories/customer_repository_impl.dart';
import 'package:local_library/data/repositories/image_repository_impl.dart';
import 'package:local_library/domain/repositories/book_repository.dart';
import 'package:local_library/domain/repositories/cart_repository.dart';
import 'package:local_library/domain/repositories/customer_repository.dart';
import 'package:local_library/domain/repositories/image_repository.dart';
import 'package:local_library/domain/usecases/book/add_book_to_cart.dart';
import 'package:local_library/domain/usecases/book/check_availability.dart';
import 'package:local_library/domain/usecases/book/load_books.dart';
import 'package:local_library/domain/usecases/book/remove_book_from_cart.dart';
import 'package:local_library/domain/usecases/book/update_book.dart';
import 'package:local_library/domain/usecases/cart/get_customer_cart.dart';
import 'package:local_library/domain/usecases/customer/login_customer_with_cache.dart';
import 'package:local_library/domain/usecases/customer/login_customer_with_data.dart';
import 'package:local_library/domain/usecases/customer/logout_customer.dart';
import 'package:local_library/domain/usecases/customer/register_customer.dart';
import 'package:local_library/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:local_library/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:local_library/presentation/bloc/customer_cart_bloc/customer_cart_bloc.dart';
import 'package:local_library/presentation/bloc/customer_login/customer_login_bloc.dart';
import 'package:local_library/presentation/bloc/customer_register/customer_register_bloc.dart';
import 'package:local_library/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:local_library/presentation/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:local_library/presentation/bloc/update_book_bloc/update_book_bloc.dart';
import 'package:local_library/services/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

/// Register BLoC's and Cubits
void registerBLoC() {
  sl.registerFactory(() => CustomerLoginBloc(
        loginCustomerWithData: sl(),
        loginCustomerWithCache: sl(),
      ));

  sl.registerFactory(() => AuthenticationBloc(logoutCustomer: sl()));

  sl.registerFactory(() => CustomerRegisterBloc(registerCustomer: sl()));

  sl.registerFactory(() => NavigationBloc());

  sl.registerFactory(() => ImageBloc(repository: sl()));

  sl.registerFactory(() => BooksBloc(loadBooks: sl()));

  sl.registerFactory(() => UpdateBookBloc(updateBook: sl()));

  sl.registerFactory(() => CustomerCartBloc(
        checkAvailability: sl(),
        loadCustomerCart: sl(),
        addBookToCart: sl(),
        removeBookFromCart: sl(),
      ));
}

/// Register use cases
void registerUseCases() {
  sl.registerLazySingleton(() => LoginCustomerWithCache(repository: sl()));

  sl.registerLazySingleton(() => LoginCustomerWithData(repository: sl()));

  sl.registerLazySingleton(() => LogoutCustomer(repository: sl()));

  sl.registerLazySingleton(() => LoadBooks(repository: sl()));

  sl.registerLazySingleton(() => RegisterCustomer(repository: sl()));

  sl.registerLazySingleton(() => LoadCustomerCartUseCase(repository: sl()));

  sl.registerLazySingleton(() => CheckAvailabilityUseCase(repository: sl()));

  sl.registerLazySingleton(() => AddBookToCartUseCase(repository: sl()));

  sl.registerLazySingleton(() => RemoveBookFromCartUseCase(repository: sl()));

  sl.registerLazySingleton(() => UpdateBookUseCase(repository: sl()));
}

/// Register repositoriee
void registerRepositories() {
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(
      networkInfo: sl(),
      customerRemoteDS: sl(),
      customerLocalDS: sl(),
      requestRemoteDS: sl(),
    ),
  );

  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      networkInfo: sl(),
      cartRemoteDS: sl(),
      requestRemoteDS: sl(),
    ),
  );
}

/// Register data sources
void registerDataSources() {
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CustomerLocalDataSource>(
    () => UserLocalDataSourceImpl(localStorage: sl()),
  );

  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<RequestRemoteDataSource>(
    () => RequestRemoteDatasourceImpl(client: sl()),
  );
}

/// Register core services
Future<void> registerCoreServices() async {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));

  final SharedPreferences localStorage = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => localStorage);

  sl.registerLazySingleton(() => InternetConnectionChecker());
}

/// Initialize all application internal dependencies
Future<void> initializeDependencies() async {
  // BLoCs
  registerBLoC();

  // Usecases
  registerUseCases();

  // Repositories
  registerRepositories();

  // Data sources
  registerDataSources();

  // Core and services
  await registerCoreServices();
}
