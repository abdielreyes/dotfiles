local status, scroll = pcall(require, "neoscroll")

if not status then
	return
end
require("neoscroll").setup({
	easing_function = "cubic", -- Default easing function
	-- Set any other options as needed
})
