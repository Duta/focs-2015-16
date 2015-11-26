import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

if __name__ == '__main__':
  testIdTemp = 'exercise-3b'
  testId = testIdTemp[9:]
  test.test_yum('48164', '9', testId)
