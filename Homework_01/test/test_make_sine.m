function tests = test_make_sine
  tests = functiontests(localfunctions);
end


function test_sanity(testCase)
  Fs = 4;
  for tfin=[10-(1/4), 10.1, 9.9]
    [y, t] = make_sine(1, 1, 0, Fs, tfin);
    verifyEqual(testCase, length(y), length(t), ...
                'y and t should have same length!');
    verifyLessThanOrEqual(testCase, t(end), tfin, ...
                'final t should be <= tfin!');
    if mod(tfin, 1/Fs) == 0
      verifyLength(testCase, t, round(tfin*Fs + 1), ...
                   'wrong output length!');
    else
      verifyLength(testCase, t, floor(tfin*Fs) + 1, ...
                   'wrong output length!');
    end
  end
end


function setupOnce(testCase)
  testCase.TestData.EPS = 1e-6;
end
