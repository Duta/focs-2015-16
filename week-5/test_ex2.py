import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

if __name__ == '__main__':
  testIdTemp = 'exercise-2'
  testId = testIdTemp[-1]
  test.test('46798', '5', testId)