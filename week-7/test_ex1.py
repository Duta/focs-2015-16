import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

if __name__ == '__main__':
  testIdTemp = 'exercise-1'
  testId = testIdTemp[-1]
  test.test_yum('47478', '7', testId)
