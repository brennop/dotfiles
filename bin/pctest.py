#!/usr/bin/env python 

import sys
from subprocess import Popen, PIPE 

if __name__ == "__main__":
    if 3 < len(sys.argv) < 2:
        print("Uso: pctest.py testfile [a.out]")

    _, test, binary, *_ = [*sys.argv, "a.out"]

    with open(test) as file:
        teststr = file.read()

        _, *tests = teststr.split("Input\nCopy");

    for i, test in enumerate(tests):
        _input, _output = map(str.strip, test.split("Output\nCopy"))

        print("running test {}".format(i))

        p = Popen(["./" + binary], stdout=PIPE, stdin=PIPE, stderr=PIPE)
        result, error = p.communicate(input=_input.encode())

        print("expected: ", _output)
        print("received: ", result.decode())
        if error:
            print("error: ", error.decode())

