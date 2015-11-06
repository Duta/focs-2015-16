import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

if __name__ == '__main__':
  testIdTemp = 'exercise-3'
  testId = testIdTemp[-1]
  test.test('47113', '6', testId)
