import os, sys
sys.path.insert(0, os.path.abspath('..'))
import test, validator

exercise_numbers = {
	"exercise-1": test.one,
	"exercise-2": test.two,
	"problem": test.prob,
}

if __name__ == '__main__':

	assert "exercise-2" in exercise_numbers, "Unknown exercise name."
	testid = exercise_numbers["exercise-2"]

	test.test('46042', '0', testid)
