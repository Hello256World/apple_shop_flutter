import 'package:apple_shop_flutter/bloc/comment/comment_event.dart';
import 'package:apple_shop_flutter/bloc/comment/comment_state.dart';
import 'package:apple_shop_flutter/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentLoadingState()) {
    on<CommentResposneEvent>((event, emit) async {
      var comments = await _commentRepository.getProductComments(event.productId);
      emit(CommentResposneState(comments));
    });
  }
}
