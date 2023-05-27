# local_library

Simple local library application (with emphasis on IOS design :) ).

Test access: 
 - admin: mrrooots abc
 - user: a a

App store all information remotely using [Supabase](https://supabase.com/) database and storage.
Database access via pure http requests according to [PosgREST](https://postgrest.org/en/stable/api.html) documenation. 
Implemented own simple [SupabaseAPI](https://github.com/MrRooots/local_library/blob/master/lib/services/supabase_api.dart) with helper function.

Icons and illustrations: flutter default and [icons8](https://icons8.com/)

# Screens (Pages)
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
  
# Previews (under development)
  - Images stored in previews [folder](https://github.com/MrRooots/local_library/tree/master/previews)
