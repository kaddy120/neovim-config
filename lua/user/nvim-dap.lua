-- Enable dap 
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- use nvim-dap events to open and close the windows automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- set dap log levvel to Trace
dap.set_log_level('TRACE')

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
  if config.preLaunchTask then
    local async = require('plenary.async')
    local notify = require('notify').async

    async.run(function()
      ---@diagnostic disable-next-line: missing-parameter
      notify('Running [' .. config.preLaunchTask .. ']').events.close()
    end, function()
        vim.fn.system(config.preLaunchTask)
        config.type = 'pwa-node'
        dap.run(config)
      end)
  end
end

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      rootPath = "${workspaceFolder}",
      skipFiles = { '<node_internals>/**' },
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = "Attach",
      type = "pwa-node",
      request = "attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      localRoot = "./",
      restart = true,
      resolveSourceMapLocations = {"${workspaceFolder}/**", "!**/node_modules/**"},
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      trace = true,
      protocol = 'insepector',
    },
    {
      name = 'Debug Main Process (Electron)',
      type = 'pwa-node',
      request = 'launch',
      program = '${workspaceFolder}/node_modules/.bin/electron',
      args = {
        '${workspaceFolder}/dist/index.js',
      },
      outFiles = {
        '${workspaceFolder}/dist/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/dist/**/*.js',
        '${workspaceFolder}/dist/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Compile & Debug Simple TS',
      type = custom_adapter,
      request = 'launch',
      preLaunchTask = 'npm run build-ts',
      -- preLaunchTask = 'tsc',
      program = '${workspaceFolder}/out/index.js',
      -- program = '${file}/',
      -- args = {
      --   '${workspaceFolder}/out/helloworld.js',
      -- },
      outFiles = {
        '${workspaceFolder}/out/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/out/**/*.js',
        '${workspaceFolder}/out/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Mocha Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/mocha/bin/mocha.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    }
  }
end

require("dapui").setup()

require("nvim-dap-virtual-text").setup{
  virt_text_win_col = 80,
  highlight_changed_variables = true
}
