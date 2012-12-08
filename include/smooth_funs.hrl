-ifndef(smooth_funs_included).
-define(smooth_funs_included, 1).

-define(compose(Funs), smooth_funs:compose(Funs)).
-define(compose(F,G), smooth_funs:compose(F,G)).
-define(curry(F, A), smooth_funs:curry(F, A)).
-define(curry(F, A, B), smooth_funs:curry(F, A, B)).

-endif.
