local M = {}

function M.setup(arduino_language_server)
	return {
		cmd = { "arduino-language-server", "--stdio" },
	}
end

return M
