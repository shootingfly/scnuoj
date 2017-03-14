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

ALLOW_LANGUAGES = %w(C C++ Java Crystal Ruby Python2 Python3 Go Lua)
SLOWS = %w(Ruby Python2 Python3 Lua)
NPROC = `ps -u 1000 | wc -l`.to_i
CODE_FILE = {
    "C" => "main.c",
    "C++" => "main.cpp",
    "Java" => "Main.java",
    "Crystal" => "main.cr",
    "Ruby" => "main.rb",
    "Python2" => "main.py",
    "Python3" => "main.py",
    "Go" => "main.go",
    "Lua" => "main.lua"
}
BUILD_CMD = {
    "C" => "gcc main.c -o main",
    "C++" => "g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main",
    "Java" =>"javac Main.java",
    "Crystal" => "crystal build main.cr",
    "Ruby"  => "ruby -c main.rb",
    "Python2" => 'python2 -m py_compile main.py', 
    "Python3" => "python3 -m py_compile main.py",
    "Go" => "go build -ldflags '-s -w' main.go",
    "Lua" => ""
}
EXE_CMD = {
    "C" => "./main",
    "C++" => "./main",
    "Java" => "java Main",
    "Crystal" => "./main",
    "Ruby" => "ruby main.rb",
    "Python2"=> "python2 main.py",
    "Python3" => "python3 main.py",
    "Go" => "./main",
    "Lua" => "lua main.lua"
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
HASH = {
    AC => "ac",
    CE => "ce",
    RE => "re",
    TE => "te",
    ME => "me",
    PE => "pe",
    OE => "oe",
    WA => "wa"
}
# Path
USER_PATH = "#{Rails.public_path}/users"
TMP_PATH= "#{Rails.public_path}/tmpfile"
# Contest
JUDGE_PATH_C = "#{Rails.public_path}/judges/contests"
ERROR_PATH_C = "#{Rails.public_path}/errors/contests"
# Problem
JUDGE_PATH = "#{Rails.public_path}/judges"
ERROR_PATH = "#{Rails.public_path}/errors/problems"
TEST_PATH = "#{Rails.public_path}/problems/testdatas"