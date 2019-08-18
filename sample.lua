----------------------------------------------
-- Sample of SlibMML.lua for W4.00.03
-- Copyright (c) 2018, AoiSaya
-- All rights reserved.
-- 2019/08/18 rev.0.01
-----------------------------------------------
local script_path = function()
	local  str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local myDir  = script_path()
pwm=require (myDir.."lib/SlibMML")

local comma =","
local music={}

--カエルの歌
music[1]= ""
.. "CDEFEDCR EFGAGFER CRCRCRCR L8CCDDEEFF L4EDC"
.. comma
.. "RRRRRRRR CDEFEDCR EFGAGFER CRCRCRCR L8CCDDEEFF L4EDC"
.. comma
.. "RRRRRRRR RRRRRRRR CDEFEDCR EFGAGFER CRCRCRCR L8CCDDEEFF L4EDC"
.. comma
.. "RRRRRRRR RRRRRRRR RRRRRRRR CDEFEDCR EFGAGFER CRCRCRCR L8CCDDEEFF L4EDC"
.. comma
.. "RRRRRRRR RRRRRRRR RRRRRRRR RRRRRRRR CDEFEDCR EFGAGFER CRCRCRCR L8CCDDEEFF L4EDC"

--ボレロ
music[2]=
		  "q60"
	   .. "r1r2"
	   .. "r1r2"
	   .. "l8<c2.>b<cdc>ba"
	   .. "<c4c>a<c2.>b<c>"
	   .. "agefg1"
	   .. "rfedefgag1"
	   .. "rabagfed"
	   .. "edc4r4cde4f4"
	   .. "d2g1"
	   .. "g1."
	   .. "<d2.rc>bab<c"
	   .. "dc>b4r<c>ba<c>baf4."
	   .. "fff4a4<c>ab<c>"
	   .. "f4fff4a4bgaf"
	   .. "d4dcd2.dd"
	   .. "d4f4afged4dc"
	   .. "d2.dcd4ef"
	   .. "g1rfed"
	   .. "c2"
	   .. comma
	   .. "q20@10l12"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grrggggrrggggrrgrr"
	   .. "grrggggrrggggggggg"
	   .. "grr2r2"

--Ievan Polkka
music[3]= ""
.. "<f+c+f+c+8e8f+c+f+c+8e8f+c+f+c+8e8f+c+f+l8c+e<f+>f+<c+>f+<f+>f+<c+ef+>f+<c+>f+<f+>f+<c+ef+>f+<c+>f+<f+>f+<c+ef+>f+<c+>f+<f+2v10f+4c+ef+4c+ec+4ec+f+4c+ef+4c+ef+4c+ec+4ec+f+4c+ef+>a<c+ec+4c+ec+4ec+f+4c+ef+>a<c+ec+4c+ec+>g+<ec+f+2>f+4c+ef+4c+ec+4ec+f+4c+ef+4c+ef+4c+ec+4ec+f+4c+e<f+4c+ec+4c+ec+4ec+f+4c+ef+4c+ec+4c+ec+4ec+f+4f+4>e4c-de4c-dc-4dc-e4c-de4c-de4c-dc-4dc-e4c-degc-d<b4b>degc-d<b4b>degc-degc-degegeee16e16ev13<e4c-de4c-dc-4dc-e4c-de4c-de4c-dc-4dc-e4c-de>g<c-d<b4b>dc-4dc-e4c-de>g<c-d<b4b>dc->f+<dc-e2f+4c+ef+4c+ec+4ec+f+4c+ef+4c+ef+4c+ec+4ec+f+4c+ef+>a<c+ec+4c+ec+4ec+f+4c+ef+>a<c+ec+4c+ec+>g+<ec+f+2>f+>c+f+c+<f+>c+f+c+<c+g+>c+<ef+>c+f+c+<f+>c+f+c+<f+>c+f+c+<c+g+>c+<ef+>c+f+c+<f+>c+f+c+<c+g+>c+<ec+g+>c+<ef+>c+f+c+<f+>c+f+c+<c+g+>c+<ec+g+>c+e<f+4"
.. comma
.. "r8l4>f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+f+l8f+f+4.&f+16v12<f+16c+f+f+l16f+g+aaf+f+8f+f+al8g+eeg+af+f+l16f+f+c+8f+8f+8eg+a8f+f+8f+f+a>c+c+c+<baal8g+af+f+f+16f+16>c+c+<bag+e16el16eeg+bbbbaag+g+a8f+f+f+8c+f+l8>c+c+<bag+eel16eg+bbbba8g+8a8f+f+f+8.>f+c+8f+8f+8.g+aaf+8f+8f+ag+8e8e8e8g+g+f+8f+8.f+c+8f+8f+8.g+a8f+f+8f+f+a>c+c+c+<ba8g+8a8f+f+f+8f+al8>c+c+<bag+l16eee8eg+bbbbaag+g+a8f+f+f+8.f+l8>c+c+<bag+l16eee8eg+bbbbaag+g+a8f+f+f+8.<f+c-8e8e8ef+ggee8eegl8f+ddf+geel16eec-8e8e8df+g8ee8eegbbbaggl8f+geee16e16bbagf+d16dl16ddf+l8bbagf+d16dl16ddf+l8bbagbbagbbbbbbl16bbbev14c-8e8e8ef+ggee8eegl8f+ddf+geel16eec-8e8e8df+g8ee8eegbbbaggl8f+geee16e16bbagf+d16dl16ddf+aaaaggf+f+g8eee8<g>el8bbagf+ddl16df+aaaag8f+8g8ee4f+c+8f+8f+8f+g+aaf+f+8f+f+al8g+eeg+af+f+l16f+f+c+8f+8f+8eg+a8f+f+8f+f+a>c+c+c+<baal8g+af+f+f+16f+16>c+c+<bag+e16el16eeg+bbbbaag+g+a8f+f+f+8c+f+l8>c+c+<bag+eel16eg+bbbba8g+8a8f+f+f+8.>f+c+8f+8f+8f+g+aaf+f+8f+f+al8g+eeg+af+f+l16f+f+c+8f+8f+8eg+a8f+f+8f+f+a>c+c+c+<baal8g+af+f+f+16f+16>c+c+<bag+e16el16eeg+bbbbaag+g+a8f+f+f+8c+f+l8>c+c+<bag+eel16eg+t100bbbba8g+8a8f+f+f+4"
.. comma
.. "r8aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa8a.&a16r8.v9<aaaa8r8g+baaaaaa8r8>c+<baa8r8>e<ag+g+>dc+<aa8r8>c+<ag+g+8r8>c+<b8al1.rrrrrr2>f+4r8l4<ggggf+agggggg8r8bagg8r8>d<gf+f+8r8>d<gf+f+>d<g>d<g8r8>dddd8r8v12<gggg8r8f+agggggg8r8bagg>d<gf+f+8r8b+bg2bgf+f+ba8g2r8aaaa8r8g+baa8r8aaaa8r8>c+<baa8r8>e<ag+g+8r8>dc+<aa>c+<ag+g+8r8>c+<b8a2r8>aaaa8r8g+baa8r8aaaa8r8>c+<baa8r8>e<ag+g+8r8>dc+<aa8r8>c+<ag+g+8r8>c+<b8"

-- Original MML code by silfia (http://lightwing.ddo.jp/silfia/mmldat/), and arranged by Saya
--We wish you a Merry Christmas
music[4]= "o5rt120deaf+g2dgl8gagf+l4eeeal8abagl4f+ddbl8bb+bal4gedeaf+g2r2"..
		  "v15t200dgl8gagf+l4eeeal8abagl4f+ddbl8bb+bal4gedeaf+g2dgggf+2f+gf+ed2abag<d>ddeaf+g2"..
		  "t220dgl8gagf+l4eeeal8abagl4f+ddbl8bb+bal4gedeaf+g2dgl8gagf+"..
		  "l4eeeal8abagl4f+ddbl8bb+bal4gedeaf+g2dgggf+2f+gf+ed2abag<d>d"..
		  "t180dt160et140at120f+t100g2t80eb+bag2."

--ジングルベル
music[5]= "o5r4l8g<edc>g4.gg<edc>a2a<fed>b4.b<ggfde4."..
		  ">gg<edc>g4.gg<edc>a4.aa<fedggggagfdc4g4eee4eee4egc.d16e2fff.f16feeeeddcd4g4"..
		  "eee4eee4egc.d16e2fff.f16feeeggfdc4r4fff.f16feeel4ggabl8b+gaeb+gaeb+gaeb+gae<e1"

--サンタが町にやってくる
music[6]= "o5l4rt140v15b<d>gba<c2ag1r2.l8.rd16c-c16d4d4rd16ef+16g4g2c-c16"..
		  "l4ddde8.d16cc2c-d>gbab+2f+g1.r.l16r<dc-8.cd4d4r8.de8.f+g4g2c-8.c"..
		  "l4ddde8.d16cc2c-d>gbab+2f+g1.r<gagf+gee2gagf+ge2.abag+af+f+f+f+8.g16agf+edr"..
		  "l8.d4&dd16c-c16d4d4rd16ef+16g4g2c-c16"..
		  "l4ddde8.d16cc2c-d>gbab+2f+g1.r2b<d>gbab+2.b<d>gbab+2.b<d>gba<c2ag1&g2."

--もろびとこぞりて
music[7]= "o5l4rt80b+b8.a16g.f8edc.g8a.a8b.l8b<c2.rcc>bagg.f16e<cc>bagg.f16eeeee"..
		  "l16efg4.fed8d8d8def4.edl8cb+4ag.f16efe4d4c2"..
		  "t130r2.rl32fgabl4b+b8.a16g.f8edc.g8a.a8b.l8bb+2.l32fgab<"..
		  "l8c.>b.agg.f16e<cc>bagg.f16eeeeel16efg4.fed8d8d8def4.ed"..
		  "l8cb+4ag.f16efl4edc2"

for i=1,7 do
	pwm:playMML(music[i])
	sleep(1000)
end
