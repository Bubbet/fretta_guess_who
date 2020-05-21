loco = FindMetaTable("CNavArea")

loco.OldIsOpen = loco.IsOpen
function loco:IsOpen( area )
	local val = self:OldIsOpen(area)
	print("isarea?", val)
	return true
end