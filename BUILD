package(default_testonly = True)

load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_test")
load("@io_bazel_rules_closure//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "arithmetic_module_lib",
    srcs = ["JS/arithmetic_module.js"],
    deps = ["@io_bazel_rules_closure//closure/library"],
)

closure_js_test(
    name = "js_test",
    timeout = "short",
    srcs = ["JS/arithmetic_module_test.js"],
    entry_points = ["goog:arithmetic_module_test"],
    deps = [
        ":arithmetic_module_lib",
        "@io_bazel_rules_closure//closure/library:testing",
    ],
)

load(":phpUnit.bzl", "phpUnit")

phpUnit(
    name = "php_test",
    file = "PHP/EmailTest.php",
    source = "PHP/Email.php",
)