
if not bit32 then
  bit32 = {}
  function bit32.bxor(a, b)
    local r, bit = 0, 1
    while a > 0 or b > 0 do
      local ab = a % 2
      local bb = b % 2
      if ab ~= bb then r = r + bit end
      a = (a - ab) / 2
      b = (b - bb) / 2
      bit = bit * 2
    end
    return r
  end
end
--[[This File Was Protected By Galactic Protection v1.6]] return(function(...)local a={"-iNelIOdHbDNpssS9Pw==";"}_]4f9?/k","-HPjemvdSvMU0jM0kZVi=";"}m5^c<mZqo@@I-3tTe","}Vj8uB>Aig[K-AKV","}%fnr#K8","-fRSFsAl=";"}($BelKfnb/q91V^(?BX1%\'742\"4M;H(SOP?5!WnkKT\'kZON\',,ONf4$(hl&Lq\"J*4i#R>ID_\\QS%qh84TPs(nTckDgTcFsfTc]Vj>AgZ4ihmtm%qhFVTs8Nb`\\&S8b50/,Ts/aQi:1[o%X,ooiq1^p","}pDZ2>%kI<","-X76zmw==";"-7NNKbMtwPPe5Z7du","}P0\":GGW\"BVmZ2";"-wrPQPvP56pNuvoX4","}\"/[Rg\"%","}i&","}qJ)QP%+Pg","}P\\`fIKZJGf?_OUtcIQ","-jttCbV0YfAa=";"}`/";"-wVSwZVSXsrdcfK==","}O0W>-[-pL)`2<_[";"}%kI3ciIahp,VeS/mVN.UiIa(F";"-jVSRIpd+fl0qPp6xbsT=";"-HHGRDtULPpVXstPUHljl7RPAjuP0sl0LsRGAwpU9ipa=","}OW781?h2ZHVqX8<ihD";"}?3P%T9m%pY","}9di72%+W6t(P";"-sAOimAt6","-fV0LfK==";"}cEVAeip>[5V<_C";"-";"-jttqsAOJPAOz";"}?3PXW(C`ao";"-wV0LfpdY";"}?3Pu*(:3";"}GRhYM%ENX","}?3P%)Kaa#X","}iq1^pK`:9U\"][";"-7MNDb6a=","}(hMbB","-X76QfAQ=","}(uc1<\"_gq]T.N/1";"-Z6SJZVSXsrdcfK==","-7RthbRY=","-ZRzhvASX7w==","-frdJfa==","-woG0Ivt7sV64ZNGSsa==";"-P6Aj460ObDUr6RvJIY==","}9RbWs\"/KB7","-bGd6doNcDoMsfo0e";"}NXoA_Dh0\'","-jMUw7lMBsa=="}local function J(J)return a[J+6552]end for J,y in ipairs({{1,52},{1,11},{12,52}})do while y[1]<y[2]do a[y[1]],a[y[2]],y[1],y[2]=a[y[2]],a[y[1]],y[1]+1,y[2]-1 end end do local J=string.len local y=string.sub local O=table.insert local R={z=35,K=16;["1"]=24;v=63;u=29;["2"]=4;Y=32;x=6,o=13,["8"]=1,Q=40;["7"]=61,h=37,l=12;N=27,I=49;E=17;d=55;b=58;S=7,["9"]=18,["6"]=47;J=42;t=31,H=44,M=15;m=57;w=48,["/"]=34,A=30;a=0,["3"]=21,T=36;W=5;L=41;F=38,U=3;k=10;["+"]=9;p=28;R=14;r=46,["0"]=23,j=51;q=22,D=45;g=25;n=2;y=26,B=33,["5"]=20;["4"]=50,P=59,e=19,C=8;V=62,c=39,O=43,f=56;G=11,Z=53;i=52;s=60;X=54}local c=type local U=string.char local X=math.floor local u=a local P=table.concat local d={["."]=10;O=78;["4"]=8;["\'"]=44,V=81,o=1,A=3,["0"]=29,f=53;J=20,u=6,n=9;["\""]=75,L=18;["="]=34,["&"]=47,E=48,Q=43,k=23;I=46,g=83;p=70,[";"]=80;s=15;["/"]=14,d=37,["\\"]=7,["6"]=22,U=35,h=39;W=33;a=31;t=65,["^"]=30;_=67,T=57;C=38,["?"]=66,["]"]=41;r=0;["5"]=55;["#"]=17;[":"]=40,K=79;[","]=52;q=73;["3"]=16,l=25;M=54;H=27;["2"]=11;[">"]=59,D=56,c=64;["!"]=21,[")"]=42;R=36,["1"]=13,j=49,["@"]=63,B=82,G=68,i=74,["-"]=28;Z=26;["`"]=58,["("]=76,S=32;F=4;Y=2;["8"]=5,["+"]=51,e=45;["<"]=50;P=69,["*"]=19,m=62,N=61,X=24;["7"]=84;["["]=71,b=60;["$"]=12,["9"]=77,["%"]=72}for a=1,#u,1 do local L=u[a]if c(L)=="string"then local c=y(L,1,1)if c=="-"then L=y(L,2)local c=J(L)local d={}local h=1 local D=0 local V=0 while h<=c do local a=y(L,h,h)local J=R[a]if J then D=D+J*(64^((3-V)))V=V+1 if V==4 then V=0 local a=X(D/65536)local J=X((D%65536)/256)local y=D%256 O(d,U(a,J,y))D=0 end elseif a=="="then O(d,U(X(D/65536)))if h>=c or y(L,h+1,h+1)~="="then O(d,U(X((D%65536)/256)))end break end h=h+1 end u[a]=P(d)elseif c=="}"then L=y(L,2)local R=J(L)local c={}local h=1 while h<=R do local a=(R-h)+1 local J=a>=5 and 5 or a local u=0 local P=J>1 for a=0,4,1 do local O if a<J then local J=y(L,h+a,h+a)O=d[J]if not O then P=false break end else O=84 end u=u*85+O end if P then local a=X(u/16777216)%256 local y=X(u/65536)%256 local R=X(u/256)%256 local P=u%256 if J==5 then O(c,U(a,y,R,P))elseif J==4 then O(c,U(a,y,R))elseif J==3 then O(c,U(a,y))elseif J==2 then O(c,U(a))end end h=h+J end u[a]=P(c)end end end end do local J=a local y=132 for a=1,#J,1 do local O=J[a]if type(O)=="string"then local R={}for a=1,#O,1 do R[a]=string.char(bit32.bxor(string.byte(O,a),y))end J[a]=table.concat(R)end end end 

do
  local fh = io.open([[C:\\Users\\user\\Downloads\\OpXOyuApWKTlFzrV\\scripts\\deobf\\galactic_strings.txt]], "w")
  for i, v in ipairs(a) do
    if type(v) == "string" then
      local s = v
      s = s:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\r","\\r"):gsub("\n","\\n"):gsub("\t","\\t")
      s = s:gsub("[\1-\31\127-\255]", function(c) return string.format("\\%d", string.byte(c)) end)
      fh:write(string.format("[%d]=\"%s\"\n", i, s))
    else
      fh:write(string.format("[%d]=<%s>%s\n", i, type(v), tostring(v)))
    end
  end
  fh:close()
  io.write("DUMPED ", #a, " entries\n")
  os.exit(0)
end

end)(...)
