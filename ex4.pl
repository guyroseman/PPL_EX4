/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).
sub_list([X|Xs], [X|Ys]) :- sub_list(Xs, Ys).   % keep the head of List
sub_list(Xs, [_|Ys]) :- sub_list(Xs, Ys).       % drop the head of List
sub_list([], []).


% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.

% swap_elem mirrors a single item: a list is mirrored recursively, an atom is left as is.
% The cut commits to the "item is a list" case before falling through to the atom case.
swap_elem([H|T], R) :- !, swap_list([H|T], R).
swap_elem(X, X).

% swap_list reverses the list (via an accumulator) while mirroring every element.
swap_list(List, Inv) :- swap_list(List, [], Inv).
swap_list([], Acc, Acc).
swap_list([H|T], Acc, Inv) :- swap_elem(H, SH), swap_list(T, [SH|Acc], Inv).



% Signature: sub_tree(?Subtree, +Tree)/2
% Purpose: Tree contains Subtree.
% Trees are tree(Value, Left, Right); void is the empty tree and is not a subtree.
% Enumerates subtrees of the left child, then of the right child, then the tree itself.
sub_tree(Sub, tree(_, L, _)) :- sub_tree(Sub, L).
sub_tree(Sub, tree(_, _, R)) :- sub_tree(Sub, R).
sub_tree(tree(V, L, R), tree(V, L, R)).


% Signature: swap_tree(+Tree, ?InversedTree)/2
% Purpose: InversedTree is the ‘mirror’ representation of Tree.
% At every node the left and right subtrees are swapped, recursively.
swap_tree(void, void).
swap_tree(tree(V, L, R), tree(V, SR, SL)) :- swap_tree(L, SL), swap_tree(R, SR).
