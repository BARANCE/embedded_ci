#include "CppUTest/TestHarness.h"
#include "CppUTest/CommandLineTestRunner.h"
#include "CppUTestExt/MockSupport.h"

int main(int argc, char** p_argv) {
    return CommandLineTestRunner::RunAllTests(argc, p_argv);
}