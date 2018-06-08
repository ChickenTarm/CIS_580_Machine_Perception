function tests = test_conv_matrix_1d
  tests = functiontests(localfunctions);
end


function test_sanity(testCase)
  M = conv_matrix_1d([1,2,3]', 6);
  verifyEqual(testCase, size(M), [4,6], ...
              'wrong dimensions!');
  M = conv_matrix_1d([1,2,3]', 3);
  verifyEqual(testCase, size(M), [1,3], ...
              'wrong dimensions!');
end


function setupOnce(testCase)
  testCase.TestData.EPS = 1e-6;
end
