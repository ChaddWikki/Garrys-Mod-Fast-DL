--Just to check if this module was added previously.
InsomniaInterface.Fonts = true

for i=7, 21 do
	surface.CreateFont("Montreal" .. i, {
		font = "Montreal",
		size = i
	})
end