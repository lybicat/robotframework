import functools
from threading import current_thread


class Memorized(object):
    """Decorator. Caches a function's return value each time it is called.
    If called later with the same arguments, the cached value is returned
    (not reevaluated).
    """
    def __init__(self, func):
        self.func = func
        self.cache = {}

    def __call__(self, *args):
        if args in self.cache:
            return self.cache[args]
        else:
            value = self.func(*args)
            self.cache[args] = value
            return value

    def __get__(self, obj, objtype):
        """Support instance methods."""
        return functools.partial(self.__call__, obj)


@Memorized
class ParallelLogNode(object):
    def __init__(self, name):
        self.name = name
        self.start_keyword = None
        self.log_message = []
        self.end_keyword = None
        self.children = []

    @Memorized
    def add_child(self, obj):
        self.children.append(obj)


def post_order(n, children, obj):
    getattr(obj, 'start_keyword')(n.start_keyword)
    if not children:
        map(lambda x: getattr(obj, 'message')(x), n.log_message)
        return
    for c in children:
        post_order(c, c.children, obj)
        getattr(obj, 'end_keyword')(c.end_keyword)


def lazy_writer(f):
    def deco(self, arg):
        cur_thread_name = current_thread().name
        if cur_thread_name == 'MainThread':
            f(self, arg)
        else:
            if f.__name__ is 'log_message':
                ori = getattr(ParallelLogNode(cur_thread_name), f.__name__)
                ori.append(arg)
                arg = ori
            setattr(ParallelLogNode(cur_thread_name), f.__name__, arg)
    return deco
