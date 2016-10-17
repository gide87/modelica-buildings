# Python module with test functions.
# These functions are used to test the Modelica Python interface.
# They are not meaningful, but rather kept simple to test whether
# the interface is correct.
#
# Make sure that the python path is set, such as by running
# export PYTHONPATH=`pwd`


def r2p2_r2(uR, uS, yS, parR, parS):
    f = open("r2_r2.txt", 'w')
    f.write("The input names are: " + str(uS[0]) + ", " + str(uS[1]) + "." +
            " The output names are: " + str(yS[0]) + ", " + str(yS[1]) + "." + 
            " The parameter names are: " + str(parS[0]) + ", " + str(parS[1]))
    f.close()
    return [uR[0] *parR[0],  uR[1]*parR[1]]



