local ok_status, auto_save = pcall(require, 'auto-save')
if not ok_status then
  return
end

--- empty setup using defaults
auto_save.setup()
