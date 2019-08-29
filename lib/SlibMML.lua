-----------------------------------------------
-- SoraMame library of MML decode & play for W4.00.03
-- Copyright (c) 2019, AoiSaya
-- All rights reserved.
-- 2019/08/19 rev.0.02
-----------------------------------------------
local SlibMML = {
}
------------------------------------------------
-- Breakされていない（動作継続OK）ことを確認する関数
--	 ret = noBreak()
-- 使い方：
--	 ret = noBreak()
-- 戻り値retは true:動作継続、false:Breakせよ
------------------------------------------------
function SlibMML:noBreak()
  return (fa.sharedmemory("read", 0x00, 0x01, "") ~= "!")
end

fa.sharedmemory("write", 0x00, 0x01, "-")

------------------------------------------------
-- MMLのコマンドを分解する関数
--	 cmd,val,i = getMMLcmd(mml,i)
-- 引数
-- mml: MML文字列
-- i  : MML文字列をコマンド解釈する位置
-- 戻り値
-- cmd: MMLコマンド
-- val: cmdに伴う数字
-- i  : 次のコマンドの位置
-- 使い方：
--	 cmd,val,i = getMMLcmd("C4DEFG",i)
------------------------------------------------
function SlibMML:getMMLcmd(mml,i)
	local cmd, opt, val, dot, num

	cmd = mml:sub(i,i)
	opt = mml:sub(i+1,i+1)
	if opt=="+" or opt=="-" then
		cmd = cmd..opt
		i = i+1
	elseif opt=="#" then
		cmd = cmd.."+"
		i = i+1
	end
	val = 0
	dot = 0
	num = 0
	while self.noBreak() do
		i = i+1
		opt = mml:sub(i,i)
		num = tonumber(opt)
		if opt=="." then
			dot = dot*2; val = 1/(1/val+1/dot)
		elseif num then
			val = val*10+num; dot = val
		else
			break
		end
	end

	return cmd,val,i
end

------------------------------------------------
-- MMLを演奏する関数
--	 PlayMML(mml)
-- 引数
-- mml: MML文字列
-- 使い方：
--	PlayMML("C4DEFG,D4EFGA")
------------------------------------------------
function SlibMML:playMML(mml)
	local i, n, end_cnt, number
	local rtime_start
	local pch, cch, ret, rtime1, rtime2, k, wait
	local Nch = 5
	local Nwt = Nch*2+1
	local ch={}
	local wt={}
	local wti={}
	local P_SCALE=3*5*7*128
	local newtmp, counttmp, tmp

	local ftbl={} -- target frequency table
	ftbl["r"]  = 0
	ftbl["c-"] = 246.942
	ftbl["c"]  = 261.626
	ftbl["c+"] = 277.183
	ftbl["d-"] = ftbl["c+"]
	ftbl["d"]  = 293.665
	ftbl["d+"] = 311.127
	ftbl["e-"] = ftbl["d+"]
	ftbl["e"]  = 329.628
	ftbl["e+"] = ftbl["f"]
	ftbl["f-"] = ftbl["e"]
	ftbl["f"]  = 349.228
	ftbl["f+"] = 369.994
	ftbl["g-"] = ftbl["f+"]
	ftbl["g"]  = 391.995
	ftbl["g+"] = 415.305
	ftbl["a-"] = ftbl["g+"]
	ftbl["a"]  = 440.000
	ftbl["a+"] = 466.164
	ftbl["b-"] = ftbl["a+"]
	ftbl["b"]  = 493.883
	ftbl["b+"] = 523.251

	local ntbl={} -- command N table
	ntbl[0] = "c"
	ntbl[1] = "c+"
	ntbl[2] = "d"
	ntbl[3] = "d+"
	ntbl[4] = "e"
	ntbl[5] = "f"
	ntbl[6] = "f+"
	ntbl[7] = "g"
	ntbl[8] = "g+"
	ntbl[9] = "a"
	ntbl[10]= "a+"
	ntbl[11]= "b"

	local ctbl={} -- command table
	ctbl[" "] = function(ch,v) end
	ctbl["o"] = function(ch,v) ch.oct = v; ch.noc = ch.oct; end
	ctbl["<"] = function(ch,v) ch.oct = ch.oct+1; ch.noc = ch.oct; end
	ctbl[">"] = function(ch,v) ch.oct = ch.oct-1; ch.noc = ch.oct; end
	ctbl["~"] = function(ch,v) ch.noc = ch.oct+1; end
	ctbl["_"] = function(ch,v) ch.noc = ch.oct-1; end
	ctbl["l"] = function(ch,v) ch.len = v; end
	ctbl["t"] = function(ch,v) ch.newtmp = v; end
	ctbl["v"] = function(ch,v) ch.vol = v; end
	ctbl["@"] = function(ch,v) ch.duty = v; end
	ctbl["q"] = function(ch,v) ch.gate = v/100.0; end
	-- not support
	ctbl["["] = function(ch,v) end
	ctbl["]"] = function(ch,v) end
	ctbl["*"] = function(ch,v) end
	ctbl["y"] = function(ch,v) end
	ctbl["&"] = function(ch,v) end
	ctbl["m"] = function(ch,v) end
	ctbl["p"] = function(ch,v) end
	ctbl["s"] = function(ch,v) end
--

	local function decodeMML(ch)
		local	cmd, val, i, frq;

		while 1 do
			if	ch.i > ch.n then
				return 0
			end
			cmd,val,ch.i = self:getMMLcmd(ch.mml,ch.i)
			if cmd=="n" then
				i = val%12
				cmd = ntbl[i];
				ch.noc = (val-i)/12+1;
				val = 0
			end
			if cmd=="p" then
				cmd = "r"
			end
			frq = ftbl[cmd]
			if frq~=nil then
				break
			else
				ctbl[cmd](ch,val)
			end
		end
		if val==0 then val=ch.len end
		ch.cmd = cmd
		ch.frq = frq * 2^(ch.noc-4)
		ch.count1 = ch.count3
		ch.count2 = ch.count1 + P_SCALE/val*ch.gate
		ch.count3 = ch.count1 + P_SCALE/val

		return 1
	end

-- main
	for i=1,Nch do
		fa.pwm("init",i-1,1)
		fa.pwm("stop",i-1)
	end

--channel init
	newtmp = 120
	counttmp = 0

	mml = mml:lower()
	for i=1,Nch do
		ch[i] = {}
		ch[i].i = 1
		ch[i].count1 = 0
		ch[i].count2 = 0
		ch[i].count3 = 0

		ch[i].pch = i-1
		ch[i].no  = i
		ch[i].oct = 4
		ch[i].noc = 4
		ch[i].len = 4
		ch[i].tmp = newtmp
		ch[i].vol = 11.625
		ch[i].duty = 50
		ch[i].gate = 0.6
		ch[i].cmd = ""
		ch[i].newtmp = 0

		n = mml:find(",")
		if n then
			ch[i].mml = mml:sub(1,n-1)
			mml = mml:sub(n+1)
		else
			ch[i].mml = mml
			mml = ""
		end
		ch[i].n = #ch[i].mml
	end

-- wait table init
	for i=1,Nwt do
		wt[i] = {}
		wt[i].rtime = (i<=Nch) and 0 or 1E99
		wt[i].no	= i
		wt[i].pch	= {i-1}
		wt[i].beep = 0
	end

	end_cnt = 0
	number = 0

	collectgarbage()
	rtime_start = os.clock()*1000

	while self.noBreak() do
		wti = table.remove(wt,1)

		if wti.beep==1 then
			for i,pch in ipairs(wti.pch) do
				fa.pwm("start",pch)
			end
		else
			cch  = ch[wti.no]
			fa.pwm("stop",cch.pch)

			ret = decodeMML(cch)

			if ret==0 then
				end_cnt = end_cnt+1
				if end_cnt>=Nch then
					break
				end
			else
				fa.pwm("duty",cch.pch,cch.frq,cch.duty)

				if cch.newtmp>0 then
					newtmp = cch.newtmp
					cch.newtmp = 0
					counttmp = cch.count1
				end
				if cch.tmp~=newtmp then
					if cch.count1>=counttmp then
						tmp = counttmp*newtmp/cch.tmp
						cch.tmp = newtmp
						cch.count1 = tmp + (cch.count1-counttmp)
						cch.count2 = tmp + (cch.count2-counttmp)
						cch.count3 = tmp + (cch.count3-counttmp)
					end
				end

				rtime1 = 240000*cch.count1/(P_SCALE*cch.tmp)+rtime_start
				rtime2 = 240000*cch.count2/(P_SCALE*cch.tmp)+rtime_start

				k = 1
				if cch.frq==0 then
					k = 2
					rtime1 = rtime2
				end
				for i=1,Nwt do
					if wt[i].rtime >= rtime1 then
						if k==1 and wt[i].rtime == rtime1 then
							table.insert(wt[i].pch,cch.pch)
						else
							wti = {}
							wti.no = cch.no
							wti.pch = {cch.pch}
							wti.beep = k
							wti.rtime = rtime1
							table.insert(wt,i,wti)
						end
						if k==2 then break end
						k = 2
						rtime1 = rtime2
					end
				end
			end
			collectgarbage()
		end
		wait = wt[1].rtime - os.clock()*1000+0.01
		if wait>0 then
			sleep(wait)
		end
	end

	for i=1,5 do
		fa.pwm("stop",i-1)
	end

	return
--]]
end

collectgarbage()
return SlibMML

