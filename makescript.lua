-- Compile script
os.execute("luac  -o mlslib.bin mlslib.lua")
-- Load binary (compiled) script
local inp = assert(io.open('mlslib.bin', "rb"))
local data = inp:read("*all")
inp:close()
-- Convert compiled script into C file
local out = assert(io.open('mlslib_lua.c', 'w'))
out:write(string.format("static const int mlslib_lua_len = %d;\n", #data));
out:write("static const char mlslib_lua_data[] = {\n");
for i = 1, #data do
	if i == #data then
		out:write(string.format("0x%.2X", data:byte(i)));
	else
		out:write(string.format("0x%.2X, ", data:byte(i)));
	end

	if i % 16 == 0 then
		out:write("\n");
	end
end
out:write("};\n");
out:close()
print('mlslib_lua.c file created')