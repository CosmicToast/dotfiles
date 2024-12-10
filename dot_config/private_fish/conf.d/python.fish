set -Uuq IPYTHONDIR || set -Uu IPYTHONDIR ~/.local/python/ipython
set -Uuq JUPYTER_CONFIG_DIR || set -Uu JUPYTER_CONFIG_DIR ~/.local/python/jupyter
set -Uuq UV_PYTHON_BIN_DIR || set -Uu UV_PYTHON_BIN_DIR ~/.local/python/bin
set -Uuq UV_PYTHON_INSTALL_DIR || set -Uu UV_PYTHON_INSTALL_DIR ~/.local/python/interpreters
set -Uuq UV_TOOL_BIN_DIR || set -Uu UV_TOOL_BIN_DIR ~/.local/python/bin
set -Uuq UV_TOOL_DIR || set -Uu UV_TOOL_DIR ~/.local/python/tools
setux IPYTHONDIR JUPYTER_CONFIG_DIR UV_PYTHON_BIN_DIR UV_PYTHON_INSTALL_DIR UV_TOOL_BIN_DIR UV_TOOL_DIR
