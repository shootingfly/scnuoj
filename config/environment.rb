# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
SITE_NAME =  "SCNUOJ"
DEFAULT_THEME = "readable"
DEFAULT_MODE = "C"
DEFAULT_KEYMAP = "sublime"
DEFAULT_LOCALE = "en"
DEFAULT_CODE_THEME = "3024-day"

ALLOW_LANGUAGES = %w(C C++ Java Python2 Python3 Ruby Go PHP Scala)
SLOWS = %w(Ruby Perl Java Python)

CODE_FILE = {
    "C" => "main.c",
    "C++" => "main.cpp",
    "Ruby" => "main.rb",
    "Java" => "Main.java",
    "Perl" => "main.pl",
    "Python2" => "main.py",
    "Python3" => "main.py"
}
BUILD_CMD = {
    "C" => "gcc main.c -o main",
    "C++" => "g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main",
    "Ruby"  => "ruby -c main.rb",
    "Java" =>"javac Main.java",
    "Perl" =>"perl -c main.pl",
    "Python2" => 'python2 -m py_compile main.py', 
    "Python3" => "python3 -m py_compile main.py"       
}
EXE_CMD = {
    "C" => "./main",
    "C++" => "./main",
    "Ruby" => "ruby main.rb",
    "Java" => "java Main",
    "Perl" => "perl main.pl",
    "Python2"=> "python2 main.pyc",
    "Python3" => "python3 main.pyc"
}
# Result
AC = "Accepted"
CE = "Compile Error"
RE = "Runtime Error"
TE = "Time Limit Exceeded"
ME = "Memory Limit Exceeded"
PE = "Presentation Error"
OE = "Output Limit Exceeded"
WA = "Wrong Answer"
# Path
USER_PATH = "#{Rails.public_path}/users"
TMP_PATH= "#{Rails.public_path}/tmpfile"
# Contest
JUDGE_PATH_C = "#{Rails.public_path}/judges/contests"
ERROR_PATH_C = "#{Rails.public_path}/errors/contests"
# Problem
JUDGE_PATH = "#{Rails.public_path}/judges/problems"
ERROR_PATH = "#{Rails.public_path}/errors/problems"
TEST_PATH = "#{Rails.public_path}/problems/testdatas"