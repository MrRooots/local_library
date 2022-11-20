# local_library

Simple local library application.

App store all information remotely using [Supabase](https://supabase.com/) database and storage.
Database access via pure http requests according to [PosgREST](https://postgrest.org/en/stable/api.html) documenation

Icons and illustrations: flutter default and [icons8](https://icons8.com/)

# Screens (all related logic is implemented in the application)
  - [splash](https://github.com/MrRooots/local_library/blob/master/lib/presentation/pages/splash.dart) (all data loading)
  - [login](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/login) (remote verifying credentials)
  - [register](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/register) (remote account creation)
  - [profile](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/profile) (display all profile data)
  - [books list](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/books_list) (dsiplay list of books)
  - [book details](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/book_details) (display book details)
  - [cart](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/cart) (cart is synchronized with database)
  - [book edit](https://github.com/MrRooots/local_library/tree/master/lib/presentation/pages/book_management) (allow to modify some book data if you are admin or moderator)
  - search (not yet implemented)
  - placed orders (not yet implemented)
  
# Previews

<h2 align="center"> Login and profile </h2>

<p align="center">
  <img width="35%" src="https://user-images.githubusercontent.com/46628524/202442678-2edce1f5-ba36-4614-acc6-fdd8c46cf6b9.png">
  <img width="35%" src="https://user-images.githubusercontent.com/46628524/202443131-e49bd43d-24db-40ba-ae5a-a0174fee31ea.png">
</p>

<h2 align="center"> Books list and cart with selected books </h2>

<p align="center">
  <img width="35%" src="https://user-images.githubusercontent.com/46628524/202443164-6fbf1f98-7e70-4ce2-9d7a-2997fb4e94ae.png">
  <img width="35%" src="https://user-images.githubusercontent.com/46628524/202443174-7a0f862d-c809-4930-a624-660c2455d469.png">
</p>
