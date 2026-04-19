
if not bit32 then
  bit32 = {}
  function bit32.bxor(a, b)
    local r, bit = 0, 1
    while a > 0 or b > 0 do
      local ab, bb = a % 2, b % 2
      if ab ~= bb then r = r + bit end
      a = (a - ab) / 2; b = (b - bb) / 2; bit = bit * 2
    end
    return r
  end
end

-- ---------- trace recorder ----------
local _tracefh = io.open([[C:\\Users\\user\\Downloads\\OpXOyuApWKTlFzrV\\scripts\\deobf\\galactic_trace.txt]], "w")
local function tr(...) _tracefh:write(...); _tracefh:write("\n"); _tracefh:flush() end

local function makeProxy(name)
  local mt = {}
  local t = {}
  mt.__index = function(_, k)
    tr("INDEX  ", name, " -> ", tostring(k))
    local v
    if k == "HttpGet" or k == "HttpGetAsync" then
      v = function(self, url)
        tr("CALL   ", name, ":", k, "(", tostring(url), ")")
        return "-- simulated HttpGet body --"
      end
    elseif k == "GetService" then
      v = function(self, svc)
        tr("CALL   ", name, ":GetService(", tostring(svc), ")")
        return makeProxy("game."..tostring(svc))
      end
    elseif k == "IsStudio" then
      v = function(self) tr("CALL   ", name, ":IsStudio()"); return false end
    elseif k == "IsRunning" or k == "IsClient" then
      v = function(self) tr("CALL   ", name, ":", k, "()"); return true end
    elseif k == "IsServer" or k == "IsEdit" then
      v = function(self) tr("CALL   ", name, ":", k, "()"); return false end
    elseif k == "IsLoaded" then
      v = function(self) tr("CALL   ", name, ":IsLoaded()"); return true end
    elseif k == "WaitForChild" or k == "FindFirstChild" then
      v = function(self, c) tr("CALL   ", name, ":", k, "(", tostring(c), ")"); return makeProxy(name.."."..tostring(c)) end
    elseif k == "LocalPlayer" then
      v = makeProxy(name..".LocalPlayer")
    elseif k == "UserId" or k == "GameId" or k == "PlaceId" then
      v = 12345
    else
      v = makeProxy(name.."."..tostring(k))
    end
    rawset(_G_proxy_cache, name.."/"..tostring(k), v)
    return v
  end
  mt.__newindex = function(_, k, v)
    tr("SET    ", name, ".", tostring(k), " = ", tostring(v))
  end
  mt.__call = function(_, ...)
    local args = {...}
    tr("CALLALL ", name, "(#=", #args, ")")
    return nil
  end
  mt.__tostring = function() return "<proxy "..name..">" end
  setmetatable(t, mt)
  return t
end

_G_proxy_cache = {}
game        = makeProxy("game")
workspace   = makeProxy("workspace")
script      = makeProxy("script")
shared      = {}
_genv       = {}

function typeof(v) return type(v) end
function wait(t) return t or 0 end
task = { wait = function(t) return t or 0 end, spawn = function(f) pcall(f) end,
         defer = function(f) pcall(f) end, delay = function(_,f) pcall(f) end }

function getgenv() return _genv end
function getrenv() return _G end
-- getfenv shadowed below to fake source name

-- Fake debug so anti-debug checks pass. Roblox's debug.info / debug.traceback
-- should look benign (no "runner" / "deobf" etc. substrings).
debug = debug or {}
local _orig_info = debug.info
debug.info = function(a, b)
  tr("CALL   debug.info(", tostring(a), ",", tostring(b), ")")
  if b == "s" then return "LocalScript" end
  if b == "l" then return 1 end
  if b == "n" then return "" end
  return "LocalScript"
end
debug.traceback = function(msg, level)
  tr("CALL   debug.traceback(", tostring(msg), ",", tostring(level), ")")
  -- make it look like a benign Roblox traceback. Include a :<digit>: so match works.
  return "Stack Begin\nScript 'LocalScript', Line 1\nStack End"
end

-- Wrap the VM entry point in pcall so we keep the trace even on anti-debug throws.
local _real_error = error
function error(msg, level)
  tr("ERROR  thrown: ", tostring(msg))
  -- swallow the error to continue logging (but this breaks control flow; callers
  -- may still infinite-loop if we do this). Rethrow for now.
  _real_error(msg, level)
end

-- loadstring gets the fetched payload. Log it, don't actually execute.
function loadstring(s, chunkname)
  tr("LOADSTRING body length=", #tostring(s))
  -- save body
  local fh = io.open([[C:\\Users\\user\\Downloads\\OpXOyuApWKTlFzrV\\scripts\\deobf\\galactic_trace.txt]]..".body", "w")
  fh:write(tostring(s))
  fh:close()
  return function(...) tr("EXECUTE loadstring-returned-chunk"); return nil end
end

-- Dump `a` after decoder finishes, so we have the string table available even if
-- the VM later errors out.
-- (We do that by appending a hook into the obfuscated source below.)

-- ======== ORIGINAL OBFUSCATED SCRIPT ========
--[[This File Was Protected By Galactic Protection v1.6]] return(function(...)local a={"-iNelIOdHbDNpssS9Pw==";"}_]4f9?/k","-HPjemvdSvMU0jM0kZVi=";"}m5^c<mZqo@@I-3tTe","}Vj8uB>Aig[K-AKV","}%fnr#K8","-fRSFsAl=";"}($BelKfnb/q91V^(?BX1%\'742\"4M;H(SOP?5!WnkKT\'kZON\',,ONf4$(hl&Lq\"J*4i#R>ID_\\QS%qh84TPs(nTckDgTcFsfTc]Vj>AgZ4ihmtm%qhFVTs8Nb`\\&S8b50/,Ts/aQi:1[o%X,ooiq1^p","}pDZ2>%kI<","-X76zmw==";"-7NNKbMtwPPe5Z7du","}P0\":GGW\"BVmZ2";"-wrPQPvP56pNuvoX4","}\"/[Rg\"%","}i&","}qJ)QP%+Pg","}P\\`fIKZJGf?_OUtcIQ","-jttCbV0YfAa=";"}`/";"-wVSwZVSXsrdcfK==","}O0W>-[-pL)`2<_[";"}%kI3ciIahp,VeS/mVN.UiIa(F";"-jVSRIpd+fl0qPp6xbsT=";"-HHGRDtULPpVXstPUHljl7RPAjuP0sl0LsRGAwpU9ipa=","}OW781?h2ZHVqX8<ihD";"}?3P%T9m%pY","}9di72%+W6t(P";"-sAOimAt6","-fV0LfK==";"}cEVAeip>[5V<_C";"-";"-jttqsAOJPAOz";"}?3PXW(C`ao";"-wV0LfpdY";"}?3Pu*(:3";"}GRhYM%ENX","}?3P%)Kaa#X","}iq1^pK`:9U\"][";"-7MNDb6a=","}(hMbB","-X76QfAQ=","}(uc1<\"_gq]T.N/1";"-Z6SJZVSXsrdcfK==","-7RthbRY=","-ZRzhvASX7w==","-frdJfa==","-woG0Ivt7sV64ZNGSsa==";"-P6Aj460ObDUr6RvJIY==","}9RbWs\"/KB7","-bGd6doNcDoMsfo0e";"}NXoA_Dh0\'","-jMUw7lMBsa=="}local function J(J)return a[J+6552]end for J,y in ipairs({{1,52},{1,11},{12,52}})do while y[1]<y[2]do a[y[1]],a[y[2]],y[1],y[2]=a[y[2]],a[y[1]],y[1]+1,y[2]-1 end end do local J=string.len local y=string.sub local O=table.insert local R={z=35,K=16;["1"]=24;v=63;u=29;["2"]=4;Y=32;x=6,o=13,["8"]=1,Q=40;["7"]=61,h=37,l=12;N=27,I=49;E=17;d=55;b=58;S=7,["9"]=18,["6"]=47;J=42;t=31,H=44,M=15;m=57;w=48,["/"]=34,A=30;a=0,["3"]=21,T=36;W=5;L=41;F=38,U=3;k=10;["+"]=9;p=28;R=14;r=46,["0"]=23,j=51;q=22,D=45;g=25;n=2;y=26,B=33,["5"]=20;["4"]=50,P=59,e=19,C=8;V=62,c=39,O=43,f=56;G=11,Z=53;i=52;s=60;X=54}local c=type local U=string.char local X=math.floor local u=a local P=table.concat local d={["."]=10;O=78;["4"]=8;["\'"]=44,V=81,o=1,A=3,["0"]=29,f=53;J=20,u=6,n=9;["\""]=75,L=18;["="]=34,["&"]=47,E=48,Q=43,k=23;I=46,g=83;p=70,[";"]=80;s=15;["/"]=14,d=37,["\\"]=7,["6"]=22,U=35,h=39;W=33;a=31;t=65,["^"]=30;_=67,T=57;C=38,["?"]=66,["]"]=41;r=0;["5"]=55;["#"]=17;[":"]=40,K=79;[","]=52;q=73;["3"]=16,l=25;M=54;H=27;["2"]=11;[">"]=59,D=56,c=64;["!"]=21,[")"]=42;R=36,["1"]=13,j=49,["@"]=63,B=82,G=68,i=74,["-"]=28;Z=26;["`"]=58,["("]=76,S=32;F=4;Y=2;["8"]=5,["+"]=51,e=45;["<"]=50;P=69,["*"]=19,m=62,N=61,X=24;["7"]=84;["["]=71,b=60;["$"]=12,["9"]=77,["%"]=72}for a=1,#u,1 do local L=u[a]if c(L)=="string"then local c=y(L,1,1)if c=="-"then L=y(L,2)local c=J(L)local d={}local h=1 local D=0 local V=0 while h<=c do local a=y(L,h,h)local J=R[a]if J then D=D+J*(64^((3-V)))V=V+1 if V==4 then V=0 local a=X(D/65536)local J=X((D%65536)/256)local y=D%256 O(d,U(a,J,y))D=0 end elseif a=="="then O(d,U(X(D/65536)))if h>=c or y(L,h+1,h+1)~="="then O(d,U(X((D%65536)/256)))end break end h=h+1 end u[a]=P(d)elseif c=="}"then L=y(L,2)local R=J(L)local c={}local h=1 while h<=R do local a=(R-h)+1 local J=a>=5 and 5 or a local u=0 local P=J>1 for a=0,4,1 do local O if a<J then local J=y(L,h+a,h+a)O=d[J]if not O then P=false break end else O=84 end u=u*85+O end if P then local a=X(u/16777216)%256 local y=X(u/65536)%256 local R=X(u/256)%256 local P=u%256 if J==5 then O(c,U(a,y,R,P))elseif J==4 then O(c,U(a,y,R))elseif J==3 then O(c,U(a,y))elseif J==2 then O(c,U(a))end end h=h+J end u[a]=P(c)end end end end do local J=a local y=132 for a=1,#J,1 do local O=J[a]if type(O)=="string"then local R={}for a=1,#O,1 do R[a]=string.char(bit32.bxor(string.byte(O,a),y))end J[a]=table.concat(R)end end end return(function(X,c,U,u,R,a,O,i,L,V,K,P,D,t,B,d,h,y)h,V,P,d,y,B,D,t,K,i,L=0,function(a)local J,y=1,a[1]while y do d[y],J=d[y]-1,J+1 if d[y]==0 then d[y],P[y]=nil,nil end y=a[J]end end,{},{},function(y,R,c,U)local d,K,L,V,P,e,h,u,l,D,B while y do if y<6465912 then if 4061690>y then if y<2860652 then if 168891>y then P,u=J(-6519),J(-6535)y=a[u]u=y(P)u,y={},a[J(-6520)]elseif y<1079356 then V=J(-6544)u=a[V]B=J(-6534)K=a[B]l,B=J(-6526),J(-6501)D=K[B]B=1 K={D(B,l)}V=u(O(K))u=1 y=V~=u y=y and 9913343 or 6315003 elseif y<1890984 then u=J(-6509)u=L[u]u=u(L)y=not u y=y and 8188736 or 3823604 else u,y=J(-6542),J(-6527)y=V[y]y=y(V,u)l,K,u=J(-6544),y,J(-6502)y=a[u]B=a[l]l={B(K)}B=J(-6544)u=y(O(l))u=a[B]B=u(K)u=1 y=B~=u y=y and 13430102 or 3825493 end else if 3824548>y then y=J(-6506)y=L[y]y=y(L)y=y and 10826545 or 6543377 elseif 3888287>y then y,K=15705550,nil else y={d()}u={O(y)}y=a[J(-6528)]end end else if y<5739377 then if 4368625>y then y,u=a[J(-6536)],{}elseif y<4831325 then y=J(-6504)y=L[y]y=y(L)y=y and 13286411 or 9798032 elseif 5227753>y then P,L=R,J(-6512)h=a[L]y=t(63338,{})d,L=y,J(-6548)u=h[L]h=J(-6511)y=u[h]h,L=y,J(-6512)u=a[L]L=J(-6523)L=u[L]L=L(u)y=not L y=y and 6388448 or 6120948 else y,u=a[J(-6543)],{}end else if y<6217975 then u=J(-6512)y=a[u]L,u=J(-6550),J(-6521)u=y[u]u=u(y,L)L=u u=J(-6508)u=L[u]u=u(L)y=not u y=y and 5357806 or 4564950 elseif 6351725>y then u=J(-6549)y=a[u]D=i(10401288,{})K={y(D)}u,V=K[1],K[2]D=u y=not D y=y and 1897700 or 15705550 else y,u=a[J(-6551)],{}end end end else if y>11199396 then if y<13845789 then if y<12429329 then V,D=J(-6539),J(-6539)u=h[V]V=h[D]y=u~=V y=y and 3951081 or 14261477 elseif y<13358256 then y,u=a[J(-6518)],{}else y={d()}u={O(y)}y=a[J(-6540)]end else if y<14983513 then D=J(-6534)V=a[D]D=J(-6514)u=V[D]D=J(-6522)V=u()u=J(-6547)u=V[u]u=u(V,D)y=not u y=y and 8212182 or 274445 elseif y<16036220 then K,D,u=J(-6517),nil,J(-6525)y=a[u]l,L=J(-6533),nil u=y()d,e,y,B=nil,J(-6541),J(-6529),J(-6512)u[y]=K u=J(-6503)y=a[u]h=nil K=a[B]e=K[e]B={e(K,l)}u=y(O(B))y=u()y,V,u=a[J(-6538)],nil,{}else y={d()}u={O(y)}y=a[J(-6546)]end end else if 9855687>y then if y<7366056 then D=J(-6512)V=a[D]D=J(-6505)u=V[D]K=J(-6512)D=a[K]K=J(-6507)V=D[K]y=u==V y=y and 16366890 or 11572247 elseif 8200459>y then u,y={},a[J(-6545)]elseif y<9005107 then y={d()}u={O(y)}y=a[J(-6537)]else y=J(-6515)y=L[y]y=y(L)y=y and 4172300 or 1884268 end else if 10157315>y then y={d()}u={O(y)}y=a[J(-6530)]elseif 10613916>y then P,u=J(-6510),J(-6535)y=a[u]u=y(P)y,u=a[J(-6516)],{}else y,u=a[J(-6524)],{}end end end end end y=#U return O(u)end,function(a,J)local O=D(J)local R=function(...)return y(a,{...},J,O)end return R end,function(a)for J=1,#a,1 do d[a[J]]=1+d[a[J]]end if R then local y=R(true)local O=U(y)O[J(-6532)],O[J(-6531)],O[J(-6500)]=a,V,function()return-3329993 end return y else return c({},{[J(-6531)]=V;[J(-6532)]=a,[J(-6500)]=function()return-3329993 end})end end,function(a,J)local O=D(J)local R=function(R,c)return y(a,{R;c},J,O)end return R end,function(a)d[a]=d[a]-1 if 0==d[a]then d[a],P[a]=nil,nil end end,function(a,J)local O=D(J)local R=function(R)return y(a,{R},J,O)end return R end,function()h=h+1 d[h]=1 return h end return(B(5097701,{}))(O(u))end)(select,setmetatable,getmetatable,{...},newproxy,getfenv and getfenv()or _ENV,unpack or table[J(-6513)])end)(...)
