--!strict
--!native

return function(value: any) : boolean
	return type(value) == "table" and value.kind ~= nil
end