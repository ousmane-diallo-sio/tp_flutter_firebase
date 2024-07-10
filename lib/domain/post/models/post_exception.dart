class PostException implements Exception {}

class NoPostFoundException extends PostException {}

class GetPostsException extends PostException {}

class CreatePostException extends PostException {}

class UpdatePostException extends PostException {}

class UnknownException extends PostException {}
