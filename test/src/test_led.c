#include "CppUTest/CommandLineTestRunner.h"
#include "led.h"

TEST_GROUP(TestLed)
{
};

TEST(TestLed, TestApproval)
{
    int ret;
    ret = led();
    CHECK_EQUAL(0, ret);
}