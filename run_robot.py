from dotenv import load_dotenv
import subprocess
import os

load_dotenv()

subprocess.run(["robot", "tests/suits/"])
