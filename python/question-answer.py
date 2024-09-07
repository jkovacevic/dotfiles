import sys
import random

DELIMITER = "?"

class Question():

    def __init__(self, q, a):
        self.q = q
        self.a = a

def parse_questions(path):
    question_list = []
    with open(path, "r") as f:
        for line in f:
            s = line.split(DELIMITER)
            if len(s) == 1:
                print("Unable to find delimiter: '{}'' in question: {}. Unable to parse - skipping the question.".format(DELIMITER, line))
                continue
            if len(s) > 2:
                print("Multiple delimiters: '{}' in question: {}. Unable to parse - skipping the question.".format(DELIMITER, line))
                continue
            q, a = s[0].strip() + DELIMITER, s[1].strip()
            question = Question(q, a)
            question_list.append(question)
    return question_list


def main():
    assert len(sys.argv) == 2, "Expecting path to questions text file."
    questions_path = sys.argv[1]
    print("Loading questions from: {}".format(questions_path))
    question_list = parse_questions(questions_path)
    
    while True:
        random_question = random.choice(question_list)
        print(random_question.q, end="")
        input()
        print(random_question.a)
        input()


if __name__ == '__main__':
    main()