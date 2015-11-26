import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

if __name__ == '__main__':
  testIdTemp = 'exercise-3a'
  testId = testIdTemp[9:]
  test.test('48163', '9', testId)
