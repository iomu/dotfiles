local M = {}
local vscodeLldbPath = nil

function M.setVSCodeLldbPath(value)
    vscodeLldbPath = value
end

function M.getVSCodeLldbPath()
    return vscodeLldbPath
end

return M
