# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
SITE_NAME =  "SCNUOJ"
DEFAULT_THEME = "cosmo"
DEFAULT_MODE = "ruby"
DEFAULT_KEYMAP = "sublime"
DEFAULT_LOCALE = "en"

CODE_FILE = {
    "C" => "main.c",
    "C++" => "main.cpp",
    "Ruby" => "main.rb",
    "Java" => "Main.java",
    "Perl" => "main.pl",
    "Python" => "main.py"
}

SLOW_LANGUAGES = %w(Ruby Perl Java Python)

BUILD_CMD = {
    "C" => "gcc main.c -o main",
    "C++" => "g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main",
    "Ruby"  => "ruby -c main.rb",
    "Java" =>"javac Main.java",
    "Perl" =>"perl -c main.pl",
    "Python" => 'python2 -m py_compile main.py',                
}

EXE_CMD = {
    "C" => "./main",
    "C++" => "./main",
    "Ruby" => "ruby main.rb",
    "Java" => "java Main",
    "Perl" => "perl main.pl",
    "Python"=> "python2 main.pyc"
}

CE = "Compile Error"
RE = "Runtime Error"
TE = "Time Limit Exceeded"
ME = "Memory Limit Exceeded"
AC = "Accepted"
PE = "Presentation Error"
OE = "Output Limit Exceeded"
WA = "Wrong Answer"
USER_PATH = "#{Rails.public_path}/users"
TMP_PATH= "#{Rails.public_path}/tmpfile"
JUDGE_PATH = "#{Rails.public_path}/judge"
ERROR_PATH = "#{Rails.public_path}/errors"
TEST_PATH = "#{Rails.public_path}/uploads/problem/testdata"