#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "${DIR}" > /dev/null
# Use the embedded python interpreter
PYBIN="$DIR/python-env/bin/python3"

# Activate the venv inside the Python process
export VIRTUAL_ENV="$DIR/python-env"
export PATH="$DIR/python-env/bin:$PATH"

# Launch your app
exec "$PYBIN" - <<EOF
import os, runpy, sys

# Activate venv in this interpreter
activate_this = os.path.join(os.environ["VIRTUAL_ENV"], "bin", "activate_this.py")
exec(open(activate_this).read(), {'__file__': activate_this})

# Run gradio app
sys.argv = ["gradio_app.py", "--port", "7860"]
runpy.run_path(os.path.join("$DIR", "gradio_app.py"), run_name="__main__")
EOF
popd > /dev/null
