-- obfuscated @ discord.gg/25ms, obfuscation: ib2 fork
return (function(...)
    local o, e, a = table, string, bit
    local C, f, t, s, L, E, r, D, h, d, l =
        e.byte,
        e.char,
        e.sub,
        o.concat,
        o.insert,
        math.ldexp,
        getfenv and getfenv() or _ENV,
        setmetatable,
        select,
        unpack or o.unpack,
        tonumber
    local i =
        (function(i)
        local e, c, n, l, I, d, C = 1, function(n)
                local e = ""
                for l = 1, #n, 1 do
                    e = e .. f(C(n, l) - (-2))
                end
                return l(e, 36)
            end, "", "", {}, 256, {}
        for e = 0, d - 1 do
            C[e] = f(e)
        end
        local function h()
            local n = c(t(i, e, e))
            e = e + 1
            local l = c(t(i, e, e + n - 1))
            e = e + n
            return l
        end
        n = f(h())
        I[1] = n
        while e < #i do
            local e = h()
            if C[e] then
                l = C[e]
            else
                l = n .. t(n, 1, 1)
            end
            C[d] = n .. t(l, 1, 1)
            I[#I + 1], n, d = l, l, d + 1
        end
        return o.concat(I)
    end)(
        "03R03I05303L03M05303I02T02N02J02R03L03C05701X02R03602@02R03403?02F02P05C04.05702B03505K01J02K03203705I05K05M05O03L03P05702602I02N02V05K03503L04/05702?02R03202I05N02N03602R02Q02@03602L03402N02T05C05E05302?03702K05J05L05N05C03B05703@06Q02H03503202N06203F05701T03703403402R02K03601T05A05K02N03L03D05701M02L02P02N02I06606?05K06305701V02K02N02O02I06M03I03J03L07405301I02F07L02E02N02K05O03K05705702/01Q05D05702A02N03406T0360260?T03605505701I02R02N02Q07Q05701N02N02U01U02F0350360?I0?K0?M03I0/Q01D0?P0?C03I02A0@302J01T02E02R02P02H0?B05702D07W02I0@R0@T0@V03H05701P03402F02T02F0?402I02?06?07V0@D0?A0440A50A70A@0AB02B03602F06I03602V0AD02V0AF0@/07D0?D02L02L02H06M0AN0AP0?F02V05403G0@10B/0B102Q01X07N06H06?07R0530?L05403N05703207V02I02I0?105307I03303702F07I0?M03J03E0570400410?@0C40530400BI03I0BJ0?M03L0@H05703J03I0CC0?L03O0530CF0640CF0CF03M0520530CM03I0CP0570740CF03O01R0CG03I05E0CF0?L0CU0530D20530460D00CC0570CC0CH0?M0510CE0570CA0BR03I01N02L02Q0370?706B0640530B30AQ0B60?M0DS0530BH0CD0CK0C503I04E0E20CN0E40E60C@0CD0CF0E10ED0E30DJ0E.0DM0DO0DQ03L0A40530BD05B0BF02V0DU0B50@H0E.03I0E00E10E70530E50C40E70F10E70CA0DH0EE0F.0DC0DC0AX03I0?.06@03402@02P0A703203606B0E001T02L07K03402L0BP06A06C05701W0A?02E06L0340FO0FQ0FS0?70340@H03A0?M02?0F?0F/0E?0F20C40F40C40?L0GG0CF0DB0C.0F?0F@0530CJ0540@M0@O05A0A10@U0@00530GT02J0@W0530@R0?T07B0G003L0B?0530FX02K02Q0FX0340@D0@R0AP0@505Q0?D03702J0?I02L02F02Q02?0B/0?W0@.03L0FC0H/0HM06L01M0?502R02I0C.04@0?M04A0E30F001W0GE0CX0C00CX0GE0D503I0CJ0EC07D0EC0CB0GH05704E0IA0IL0CI0ID0D10IF0CQ0IU0CO0IW0450C50I70GC0IP0GE0IS0C40A40E70IG0J?0CT0J/0GF0IQ0DI0530I70?L0IL0J40?L0JM0IH03X0C40430IN0IG0JR0J.0570J00IJ0GE0FA0D30IO0JF0540IH0260C403W0E30IG0K?0CF0J40IL0CC0GJ0CT03I04004F0D00BL05703T0C40DE03O0K60CF0D@0IL0IG0KU0GD0JJ0KH0KJ0KH0GQ0530KO0D40EA03O0C00?L04K0IV0570LB0JV0D?0C507D0L/0FA0JN0570LI0CD0DE0F60DG0E20530HJ0CG0@M0H306R02P0H60FC0AT0AV0?X06R02J06B0GL02K02R03@03L03S0FW0AP0G001U02R03505O0HB0?I0FL05V0@D0@F0MI0?Q0H@0MF05K02A02V03205C0560530?30HL0FV06W0AE02N0@D0FX02I0G00MW0N.0DK01V02U02P02I03702Q07307507707@07B05C0E.0M20N70@/0L301T01W0M505C0G?05302602L0350?F02F0FP0?A0O003I0MO0@E0?J05C0H?0OA0350MH0MJ07J02Q0MM01P02S03L0L30M407J0360C.04?0I60I?0E40JF0E70KR0C40BL0KV0IW0P30JC0570CS03I0LN0@H0LP0C101S0EA0CA04E0I50JN0GL0EA0K10LK0CD0560IL0570P60PC03I0P604.02A0EA0560CC0400210D00L30F10DD03I0640Q60D00G?0HJ0?L0BL0Q10K40@M0QA0CC06V0530PT0GD0BL0BL07R0F10QP03I0C00F10L30C00P?0E30F10640640QR0CR0Q?0QU0?M0CJ0CJ0EV0640F60K40RC03I0LB0D004L0C407D0IG0RJ0KC0IA0Q003I0B?0F10560560A40J40L30HJ0KO0560CJ0D40IW0KX03I01L0KH0@H0RL0I?0CC0560LQ0F703I0@M0H103I0LX0H50?00OF0HA0HC0BW0HF02E0HH03L0LU01I0HL0HN0HP0HR02L0HT0340@/0F103I02502H06K0?I02N0250NK02S0?70M/0250H502F03?02R02502K0T102502I07U07W0OP05702F07A0SQ0@60EN05H0HG02I02Q07I02K03L0GL01J03501R0EL0650@.05N0?701V02J0?F0H60E.0?30?50?702Q0C.0470K20E30IC0P20LC0QM0LH0OX0D00PN0P.0US0L.0IN0L10RQ0KN0Q/0L70K60?L0IT0530IG0IT0IG0B?0K.0PL0K40DE0F00K40JN0L10BL0N00L40KL0V@0D00LE0570IG0VW0400PF0560KM0QO0Q405304O0PV0IH0?M0740VR0CJ0IG04I0GF0530740G?0640L107R0O@03I0KO07407R0J60740KB0C40KA0WV0IW0WF0RO0SG03I0G?0740L?0X104G0UV03I0X70LF03I0X/05307D0CW0IM0740CA03O0A405603Q0JS0IW0XN0K.0VR0FA0SD0DF0SF0XN0GR07E0?H0M.0H60QL0?S0?U05H0M40@/0VR0@20@40GX03I0I.02E1/.C02E03706T0TT0530TV02N0TX0QL05G0?W0670FF06B0SN0AA0SP0HE0?G0ST0O@0SW0HM0TN0HP1/.K03I1/.A0NA02E0RD0DC0SV0SX1//40HQ0HS1/.70HV0?R0@P0I.02R0I002O0I203L0420@X06Q0U202A02L02C02F0MA03206Q0?W0HO07K03L0O@0O20O40AO0FP0SI0A.0BP0GV0@V0NV0NX07N0SI0@?02T02K0?F0NJ05C0E00@?0@A0@C0OC0620LU1/.Q0DM03705T07T07V1/0A0U50E.02C0@T06P03404W0U60570M@0MB0IL02.03L0IL02/0@H0000OW0CD0J40GM0X50GP0X?0II0LG0V003I0500KP0OW0J30P/0L70IT07R0J@0IW1/250KI0KK0GK0?M0D@0?L0GL04004R0KH0VR0RT0KH0BL0C70W?0L30570S20IO1/1S0RA0R?0R60@H0W30640XS03.0UX0QL0570I70EX0IH0WF0740520CF07R0IG1/3A0P705302U0JE0EW0X10CX0K607R1/3H0P40571/3O0V107R0XG04E0K?07R0WM0?M0IK0CD07R0LN0F10C01/3U0530C00C00G?1/2N0B?0@M0570C00B?0CI0E/03I0RN0WX0571/4K0IG1/3R0P10C01/3R0VD0IW1/3R0J407D0C005E03G04P1/3J04B0RK1/3F03I1/530XB1/4V0IA0XF0WG0PA1/5D1/4A0KK0A40R.0VS07D0A40CI0K607D1/511/3P0531/5P0GD0B?07D1/5F03I05Q0FC0WO0RR1/5X1/231/6104N0X?1/650XB1/5S1/5D0D71/4T0570B60EC0I70B?0PL1/650A41/4D04T1/610JN0P10B?0PF1/5Q03I1/6R0XE0IX0VX0IW1/6E0JH1/610XS1/6J0X10571/6M1/4G0VU0B?01J0K@0IW1/7A0K.1/6B1/551/7/03I1/6G0W?0VM1/610B?0RS0IA05Q07R0EM02B1/6105Q0A40X50A40KS1/4L0O11/?003I1/4S0I705Q0JK1/7P1/6205Q0X505Q1/7T1/2605R1/?20220J11/621/2P1/6506D0EX1/6M05Q1/6O0C005Q1/?H1/?E0531/?T1/6V1/7F0IG1/7/0J41/7Q03I0EM02O03I06D0W30F106D1/@A0GD1/@B0EM0LT1/6206D0F105Q05Q1/2N05306D0JK1/@M1/@603I0C30GQ06D02E0C405Q0IG1/@V1/7E1/7B1/6D1/?I06D0E.04E0561/@B1//S05706D0VO0C603I0JR1/7L0C70C70AI0F10C30B?0J00F11//S0B?0XX1/AD1//S0F61/AH1/@Q0F11/AV0C70GQ0C70370WV1/551/B21/5?0C51/650561/@L03I1/650?L0EX1/650CC1/4D07D1/7F0X505E1/311/?U03I1/BM1/550300C40XK0W?1//S0K10IG1/BV0531/650BL0F61/650CJ0PL1/2.0QF0XV0LS0S?0CG0FC01I0BA0B20AO0DV0?@03L0AI0530A60A?0AA07W0ES0AR0NS0@D0DK1/CS0360IL0SH0E002P0@S0@U0BO0G50NE0?40?606M1/.C1/.E1//606R0HB02L02J1//B0/I04T1//B0?O0SI0?E0?G0MQ1/060650O30O51/0B1/CK03I1/CM0AL1/CP1/CG0B51/CV0R?04J0PE0W@0PR0251/E50VU0CJ0QN0IG0P60IG0MD1/6F0W@0?M0RX0W@0J60CJ0D70XB0D71/EE1/?I1/1U0@X1/E?0640X50CJ0JB0XB0JB1/EQ0CF0W00X20D00F00CF0G?0G?1/B@0WH1/7K0KI0D61/EH0?M0G?05E0F61/4D0GD0740741/EV0530G?1/3E0WB0IW1/3E1/F10V11/4H0O00I71/2R0F003V0W@0CJ1/4D0EV1/FG0V.0XI0CD05E0VJ1/3J0XS1/471/FC1/2Q0R70@H1/2P0EB0?M1/DU1/7I0E11/1P0DH1/1R0W?1/BN1/ED0IW1/ES0LR0I?0I71/C@0T60DH0J61/4I1/BN1/2?03I1/H.0PR0J20@H04U1/?W0PN1/HB1/EI0IA0CA0560PX1/2/0CI0E50IL1/2B03I02N0JG0571/HS0K41/HU0E11/HL0VD0C51/H@0VX0DC0OF1/CD0B006M0EO06G1/.S1/CI0NR0N61/CT1/@E1/DW1/CO0AC1/IE1/CW0CV0DC1/D/1/D102H1/D30?00UK1/D60UN1/D@06K1/.F0L31/DC02Q1/DE1/DG1/DI0CD1/DK0@M1/DM0H30OD1/DP0O11/DR1/140UB1/CL0AK1/II1/E10PS04H1/E40QN1/H20P60J60BL1/3E0XB1/3E1/GO0W30I@0W?1/C10IH0C00BL0XG0XB0XG1/3D1/?I1/JN02D1/GT1/G31/K11/611/BN0VH1/551/3E1/F30640GL04E0CL0R61/FA1/F40W31/2N0X40CD0641/G@0570WN0GD1/F?0R60GQ0640XQ1/F40IG1/L31/K60X00CF0BL1/G.0W?0PH0J00QT1/4D1/GK0R/0PR1/FP0EA0@H0741/GC05E1/GE0W?1/330UW0EE0PR0MD1/341/GP0IA1/1Q0K60UW1/6S0PT1/I21/LX1/H11/E70E21/5M0571/@.0IW1/EP1/271/I10SF1/GO1/LJ1/HD0J50V10KE1/K00C41/@N1/?21/MQ1/L71/701/LJ0JL0FA1/HL0CO0L71/HO0DH0DB1/HV1/LL0531/N40PL1/N40?M1/I/0V/0531/M50F?1/JW1/E30GN0GC1/MH0GM1/LJ0I?01K0C10OV1/C@0T50JG1/2N1/2E0ED1/AC0K/0GD0F51/FD0D01/LQ1/2B0?L1/NU0R00C?0VO0KK0W20?M01M0V?1/O50K41/@O0DA0EA1/2N0BL1/LH0CC1/K/1/2N0561/A51/I00560G?0QS0C41/LG1/GH04U1/1S05E07R1/MK0CJ0C007D04U0JR0CJ0B?0A41/P/0W@05Q06D1/PC0CJ0C71/P21/1S0C30EX0E.0561/PC0641//S0JR1/PP03I0AI1/PS0R50J00XN1/PT0520XN03K1/7A1/KX03O0E51/K31/LL02P1/KW0?M1/QA0C?0GP0E51/FI0IN03I1/QD1/F40571/QK0XJ0E507R0CC0PN1/QK0WN1/QK0W31/Q60R70PQ1/Q@1/GH1/QM0PS1/2Q0E507D1/JP0531/QV1/QC1/I30BI1/7A0B?0L31/QX0A40CS0O01/R@1/R21/1S1/RL0I?1/QK1/5I1/QJ0570OF1/RR1/I01/RN1/6/1/QK0R?0E505Q0G?1/N/1/RU1/2W1/R?1/IM1/RN1/2P1/QK1/@E1/QX06D1/K51/S60R51/RN1/331/QK1/S@0571/SB0E50C70D70BJ1/QK0LU1/S406D0571/650C31/BA01T1/@R0K/0CC1/G01/ND0SF"
    )
    local e, o, n, l = 1, a and a.bxor or function(e, n)
                local l, o = 1, 0
                while e > 0 and n > 0 do
                    local t, d = e % 2, n % 2
                    if t ~= d then
                        o = o + l
                    end
                    e, n, l = (e - t) / 2, (n - d) / 2, l * 2
                end
                if e < n then
                    e = n
                end
                while e > 0 do
                    local n = e % 2
                    if n > 0 then
                        o = o + l
                    end
                    e, l = (e - n) / 2, l * 2
                end
                return o
            end, 200, function(n, e, l)
            if l then
                local e = (n / 2 ^ (e - 1)) % 2 ^ ((l - 1) - (e - 1) + 1)
                return e - e % 1
            else
                local e = 2 ^ (e - 1)
                return (n % (e + e) >= e) and 1 or 0
            end
        end
    local n, c, I = function()
            local l, t, d, C = C(i, e, e + 3)
            l, t, d, C = o(l, n), o(t, n), o(d, n), o(C, n)
            e = e + 4
            return (C * 16777216) + (d * 65536) + (t * 256) + l
        end, function()
            local n = o(C(i, e, e), n)
            e = e + 1
            return n
        end, function()
            local t, l = C(i, e, e + 2)
            t, l = o(t, n), o(l, n)
            e = e + 2
            return (l * 256) + t
        end
    local function a()
        local o = n()
        local e = n()
        local t = 1
        local o = (l(e, 1, 20) * (2 ^ 32)) + o
        local n = l(e, 21, 31)
        local e = ((-1) ^ l(e, 32))
        if (n == 0) then
            if (o == 0) then
                return e * 0
            else
                n = 1
                t = 0
            end
        elseif (n == 2047) then
            return (o == 0) and (e * (1 / 0)) or (e * (0 / 0))
        end
        return E(e, n - 1023) * (t + (o / (2 ^ 52)))
    end
    local e, i = n, function(l)
            local d
            if (not l) then
                l = n()
                if (l == 0) then
                    return ""
                end
            end
            d = t(i, e, e + l - 1)
            e = e + l
            local n = {}
            for e = 1, #d do
                n[e] = f(o(C(t(d, e, e)), 200))
            end
            return s(n)
        end
    local e, E = n, function(...)
            return {...}, h("#", ...)
        end
    local function s()
        local C, t, e = {}, {}, {}
        local f = {C, t, nil, e}
        local e, o = n(), {}
        for l = 1, e do
            local n, e = c()
            if (n == 0) then
                e = (c() ~= 0)
            elseif (n == 2) then
                e = a()
            elseif (n == 3) then
                e = i()
            end
            o[l] = e
        end
        for e = 1, n() do
            t[e - 1] = s()
        end
        f[3] = c()
        for f = 1, n() do
            local e = c()
            if (l(e, 1, 1) == 0) then
                local t, d, e = l(e, 2, 3), l(e, 4, 6), {I(), I(), nil, nil}
                if (t == 0) then
                    e[3] = I()
                    e[4] = I()
                elseif (t == 1) then
                    e[3] = n()
                elseif (t == 2) then
                    e[3] = n() - (2 ^ 16)
                elseif (t == 3) then
                    e[3] = n() - (2 ^ 16)
                    e[4] = I()
                end
                if (l(d, 1, 1) == 1) then
                    e[2] = o[e[2]]
                end
                if (l(d, 2, 2) == 1) then
                    e[3] = o[e[3]]
                end
                if (l(d, 3, 3) == 1) then
                    e[4] = o[e[4]]
                end
                C[f] = e
            end
        end
        return f
    end
    local function c(e, C, I)
        local l, n, e = e[1], e[2], e[3]
        return function(...)
            local o, h, t, a, n, f, r, E, s, i, l = l, n, e, E, 1, -1, {}, {...}, h("#", ...) - 1, {}, {}
            for e = 0, s do
                if (e >= t) then
                    r[e - t] = E[e + 1]
                else
                    l[e] = E[e + 1]
                end
            end
            local e = s - t + 1
            local e
            local t
            while true do
                e = o[n]
                t = e[1]
                if t <= 49 then
                    if t <= 24 then
                        if t <= 11 then
                            if t <= 5 then
                                if t <= 2 then
                                    if t <= 0 then
                                        local n = e[2]
                                        local o = l[e[3]]
                                        l[n + 1] = o
                                        l[n] = o[e[4]]
                                    elseif t > 1 then
                                        local n = e[2]
                                        local o = l[n]
                                        for e = n + 1, e[3] do
                                            L(o, l[e])
                                        end
                                    else
                                        local t
                                        l[e[2]] = l[e[3]][e[4]]
                                        n = n + 1
                                        e = o[n]
                                        l[e[2]] = e[3]
                                        n = n + 1
                                        e = o[n]
                                        l[e[2]] = e[3]
                                        n = n + 1
                                        e = o[n]
                                        t = e[2]
                                        l[t] = l[t](d(l, t + 1, e[3]))
                                        n = n + 1
                                        e = o[n]
                                        l[e[2]] = C[e[3]]
                                        n = n + 1
                                        e = o[n]
                                        l[e[2]] = l[e[3]][e[4]]
                                        n = n + 1
                                        e = o[n]
                                        if (l[e[2]] <= l[e[4]]) then
                                            n = e[3]
                                        else
                                            n = n + 1
                                        end
                                    end
                                elseif t <= 3 then
                                    do
                                        return l[e[2]]
                                    end
                                elseif t > 4 then
                                    if l[e[2]] then
                                        n = n + 1
                                    else
                                        n = e[3]
                                    end
                                else
                                    local C
                                    local t
                                    t = e[2]
                                    C = l[e[3]]
                                    l[t + 1] = C
                                    l[t] = C[e[4]]
                                    n = n + 1
                                    e = o[n]
                                    t = e[2]
                                    l[t] = l[t](l[t + 1])
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = I[e[3]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    t = e[2]
                                    l[t] = l[t](d(l, t + 1, e[3]))
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]] - l[e[4]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    if (l[e[2]] < l[e[4]]) then
                                        n = e[3]
                                    else
                                        n = n + 1
                                    end
                                end
                            elseif t <= 8 then
                                if t <= 6 then
                                    local t
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = e[3]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = e[3]
                                    n = n + 1
                                    e = o[n]
                                    t = e[2]
                                    l[t] = l[t](d(l, t + 1, e[3]))
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = C[e[3]]
                                    n = n + 1
                                    e = o[n]
                                    l[e[2]] = l[e[3]][e[4]]
                                    n = n + 1
                                    e = o[n]
                                    if (l[e[2]] <= l[e[4]]) then
                                        n = e[3]
                                    else
                                        n = n + 1
                                    end
                                elseif t > 7 then
                                    local n = e[2]
                                    l[n] = l[n](d(l, n + 1, e[3]))
                                else
                                    local e = e[2]
                                    local o, n = a(l[e](l[e + 1]))
                                    f = n + e - 1
                                    local n = 0
                                    for e = e, f do
                                        n = n + 1
                                        l[e] = o[n]
                                    end
                                end
                            elseif t <= 9 then
                                local o = e[2]
                                local t, n = {l[o](d(l, o + 1, f))}, 0
                                for e = o, e[4] do
                                    n = n + 1
                                    l[e] = t[n]
                                end
                            elseif t > 10 then
                                local t
                                l[e[2]] = C[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = C[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                do
                                    return l[t](d(l, t + 1, e[3]))
                                end
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                do
                                    return d(l, t, f)
                                end
                                n = n + 1
                                e = o[n]
                                do
                                    return
                                end
                            else
                                local o = e[2]
                                local t, n = {l[o](d(l, o + 1, f))}, 0
                                for e = o, e[4] do
                                    n = n + 1
                                    l[e] = t[n]
                                end
                            end
                        elseif t <= 17 then
                            if t <= 14 then
                                if t <= 12 then
                                    if not l[e[2]] then
                                        n = n + 1
                                    else
                                        n = e[3]
                                    end
                                elseif t == 13 then
                                    l[e[2]] = (e[3] ~= 0)
                                else
                                    l[e[2]] = e[3]
                                end
                            elseif t <= 15 then
                                local t = e[2]
                                local d = e[4]
                                local o = t + 2
                                local t = {l[t](l[t + 1], l[o])}
                                for e = 1, d do
                                    l[o + e] = t[e]
                                end
                                local t = t[1]
                                if t then
                                    l[o] = t
                                    n = e[3]
                                else
                                    n = n + 1
                                end
                            elseif t > 16 then
                                l[e[2]] = {}
                            else
                                local n = e[2]
                                local t = {l[n]()}
                                local o = e[4]
                                local e = 0
                                for n = n, o do
                                    e = e + 1
                                    l[n] = t[e]
                                end
                            end
                        elseif t <= 20 then
                            if t <= 18 then
                                do
                                    return
                                end
                            elseif t > 19 then
                                local o = e[2]
                                local n = l[e[3]]
                                l[o + 1] = n
                                l[o] = n[e[4]]
                            else
                                local f, C
                                local t
                                l[e[2]] = I[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = I[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                f, C = {l[t](d(l, t + 1, e[3]))}, 0
                                for e = t, e[4] do
                                    C = C + 1
                                    l[e] = f[C]
                                end
                                n = n + 1
                                e = o[n]
                                if not l[e[2]] then
                                    n = n + 1
                                else
                                    n = e[3]
                                end
                            end
                        elseif t <= 22 then
                            if t > 21 then
                                l[e[2]][e[3]] = l[e[4]]
                            else
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = {}
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                            end
                        elseif t > 23 then
                            if not l[e[2]] then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        else
                            local t
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return l[t](d(l, t + 1, e[3]))
                            end
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return d(l, t, f)
                            end
                            n = n + 1
                            e = o[n]
                            do
                                return
                            end
                        end
                    elseif t <= 36 then
                        if t <= 30 then
                            if t <= 27 then
                                if t <= 25 then
                                    n = e[3]
                                elseif t > 26 then
                                    local n = e[2]
                                    l[n] = l[n](d(l, n + 1, e[3]))
                                else
                                    local n = e[2]
                                    do
                                        return l[n](d(l, n + 1, e[3]))
                                    end
                                end
                            elseif t <= 28 then
                                l[e[2]]()
                            elseif t == 29 then
                                local t
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                do
                                    return l[t](d(l, t + 1, e[3]))
                                end
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                do
                                    return d(l, t, f)
                                end
                                n = n + 1
                                e = o[n]
                                do
                                    return
                                end
                            else
                                local C
                                local t
                                t = e[2]
                                C = l[e[3]]
                                l[t + 1] = C
                                l[t] = C[e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                l[t] = l[t](d(l, t + 1, e[3]))
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                C = l[e[3]]
                                l[t + 1] = C
                                l[t] = C[e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = e[3]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                l[t] = l[t](d(l, t + 1, e[3]))
                                n = n + 1
                                e = o[n]
                                if not l[e[2]] then
                                    n = n + 1
                                else
                                    n = e[3]
                                end
                            end
                        elseif t <= 33 then
                            if t <= 31 then
                                if (l[e[2]] ~= l[e[4]]) then
                                    n = n + 1
                                else
                                    n = e[3]
                                end
                            elseif t > 32 then
                                l[e[2]] = e[3]
                            else
                                local f = h[e[3]]
                                local d
                                local t = {}
                                d =
                                    D(
                                    {},
                                    {__index = function(n, e)
                                            local e = t[e]
                                            return e[1][e[2]]
                                        end, __newindex = function(l, e, n)
                                            local e = t[e]
                                            e[1][e[2]] = n
                                        end}
                                )
                                for d = 1, e[4] do
                                    n = n + 1
                                    local e = o[n]
                                    if e[1] == 99 then
                                        t[d - 1] = {l, e[3]}
                                    else
                                        t[d - 1] = {C, e[3]}
                                    end
                                    i[#i + 1] = t
                                end
                                l[e[2]] = c(f, d, I)
                            end
                        elseif t <= 34 then
                            local e = e[2]
                            l[e] = l[e](l[e + 1])
                        elseif t == 35 then
                            l[e[2]] = l[e[3]] - l[e[4]]
                        else
                            if (l[e[2]] == l[e[4]]) then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        end
                    elseif t <= 42 then
                        if t <= 39 then
                            if t <= 37 then
                                l[e[2]] = C[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]]()
                                n = n + 1
                                e = o[n]
                                l[e[2]] = C[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]]()
                                n = n + 1
                                e = o[n]
                                do
                                    return
                                end
                            elseif t == 38 then
                                n = e[3]
                            else
                                l[e[2]] = (e[3] ~= 0)
                                n = n + 1
                            end
                        elseif t <= 40 then
                            for e = e[2], e[3] do
                                l[e] = nil
                            end
                        elseif t > 41 then
                            local C
                            local t
                            l[e[2]] = I[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            C = l[e[3]]
                            l[t + 1] = C
                            l[t] = C[e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = e[3]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            l[t] = l[t](d(l, t + 1, e[3]))
                            n = n + 1
                            e = o[n]
                            l[e[2]] = I[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            C = l[e[3]]
                            l[t + 1] = C
                            l[t] = C[e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = e[3]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            l[t] = l[t](d(l, t + 1, e[3]))
                            n = n + 1
                            e = o[n]
                            l[e[2]] = I[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            C = l[e[3]]
                            l[t + 1] = C
                            l[t] = C[e[4]]
                        else
                            if (l[e[2]] < l[e[4]]) then
                                n = e[3]
                            else
                                n = n + 1
                            end
                        end
                    elseif t <= 45 then
                        if t <= 43 then
                            local d
                            local t
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            l[t] = l[t]()
                            n = n + 1
                            e = o[n]
                            l[e[2]] = {}
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            d = l[t]
                            for e = t + 1, e[3] do
                                L(d, l[e])
                            end
                        elseif t == 44 then
                            l[e[2]] = C[e[3]]
                        else
                            local t = e[2]
                            local d = e[4]
                            local o = t + 2
                            local t = {l[t](l[t + 1], l[o])}
                            for e = 1, d do
                                l[o + e] = t[e]
                            end
                            local t = t[1]
                            if t then
                                l[o] = t
                                n = e[3]
                            else
                                n = n + 1
                            end
                        end
                    elseif t <= 47 then
                        if t > 46 then
                            if (l[e[2]] ~= l[e[4]]) then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        else
                            local n = e[2]
                            do
                                return l[n](d(l, n + 1, e[3]))
                            end
                        end
                    elseif t == 48 then
                        local h = h[e[3]]
                        local f
                        local t = {}
                        f =
                            D(
                            {},
                            {__index = function(n, e)
                                    local e = t[e]
                                    return e[1][e[2]]
                                end, __newindex = function(l, e, n)
                                    local e = t[e]
                                    e[1][e[2]] = n
                                end}
                        )
                        for d = 1, e[4] do
                            n = n + 1
                            local e = o[n]
                            if e[1] == 99 then
                                t[d - 1] = {l, e[3]}
                            else
                                t[d - 1] = {C, e[3]}
                            end
                            i[#i + 1] = t
                        end
                        l[e[2]] = c(h, f, I)
                    else
                        if (e[2] < l[e[4]]) then
                            n = e[3]
                        else
                            n = n + 1
                        end
                    end
                elseif t <= 74 then
                    if t <= 61 then
                        if t <= 55 then
                            if t <= 52 then
                                if t <= 50 then
                                    if (l[e[2]] < l[e[4]]) then
                                        n = e[3]
                                    else
                                        n = n + 1
                                    end
                                elseif t > 51 then
                                    l[e[2]] = c(h[e[3]], nil, I)
                                else
                                    if (l[e[2]] < l[e[4]]) then
                                        n = n + 1
                                    else
                                        n = e[3]
                                    end
                                end
                            elseif t <= 53 then
                                l[e[2]] = {}
                            elseif t > 54 then
                                do
                                    return
                                end
                            else
                                local e = e[2]
                                do
                                    return l[e], l[e + 1]
                                end
                            end
                        elseif t <= 58 then
                            if t <= 56 then
                                local o = l[e[4]]
                                if not o then
                                    n = n + 1
                                else
                                    l[e[2]] = o
                                    n = e[3]
                                end
                            elseif t == 57 then
                                l[e[2]] = l[e[3]]
                            else
                                local e = e[2]
                                local o, n = a(l[e](l[e + 1]))
                                f = n + e - 1
                                local n = 0
                                for e = e, f do
                                    n = n + 1
                                    l[e] = o[n]
                                end
                            end
                        elseif t <= 59 then
                            if (e[2] < l[e[4]]) then
                                n = e[3]
                            else
                                n = n + 1
                            end
                        elseif t > 60 then
                            local t, t
                            local i
                            local c, L
                            local h
                            local t
                            l[e[2]] = I[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = I[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            h = l[e[3]]
                            l[t + 1] = h
                            l[t] = h[e[4]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            c, L = a(l[t](l[t + 1]))
                            f = L + t - 1
                            i = 0
                            for e = t, f do
                                i = i + 1
                                l[e] = c[i]
                            end
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            c, i = {l[t](d(l, t + 1, f))}, 0
                            for e = t, e[4] do
                                i = i + 1
                                l[e] = c[i]
                            end
                            n = n + 1
                            e = o[n]
                            n = e[3]
                        else
                            local t
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return l[t](d(l, t + 1, e[3]))
                            end
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return d(l, t, f)
                            end
                            n = n + 1
                            e = o[n]
                            do
                                return
                            end
                        end
                    elseif t <= 67 then
                        if t <= 64 then
                            if t <= 62 then
                                local e = e[2]
                                do
                                    return d(l, e, f)
                                end
                            elseif t > 63 then
                                for e = e[2], e[3] do
                                    l[e] = nil
                                end
                            else
                                local e = e[2]
                                l[e] = l[e](l[e + 1])
                            end
                        elseif t <= 65 then
                            local o = l[e[4]]
                            if not o then
                                n = n + 1
                            else
                                l[e[2]] = o
                                n = e[3]
                            end
                        elseif t > 66 then
                            l[e[2]]()
                        else
                            l[e[2]] = I[e[3]]
                        end
                    elseif t <= 70 then
                        if t <= 68 then
                            if (l[e[2]] == l[e[4]]) then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        elseif t == 69 then
                            local e = e[2]
                            do
                                return l[e], l[e + 1]
                            end
                        else
                            l[e[2]] = l[e[3]][e[4]]
                        end
                    elseif t <= 72 then
                        if t == 71 then
                            l[e[2]] = (e[3] ~= 0)
                        else
                            l[e[2]][e[3]] = e[4]
                        end
                    elseif t == 73 then
                        l[e[2]] = c(h[e[3]], nil, I)
                    else
                        if (l[e[2]] ~= e[4]) then
                            n = n + 1
                        else
                            n = e[3]
                        end
                    end
                elseif t <= 86 then
                    if t <= 80 then
                        if t <= 77 then
                            if t <= 75 then
                                l[e[2]] = (e[3] ~= 0)
                                n = n + 1
                            elseif t == 76 then
                                local C
                                local t
                                t = e[2]
                                l[t] = l[t](d(l, t + 1, e[3]))
                                n = n + 1
                                e = o[n]
                                l[e[2]] = I[e[3]]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                C = l[e[3]]
                                l[t + 1] = C
                                l[t] = C[e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = e[3]
                                n = n + 1
                                e = o[n]
                                t = e[2]
                                l[t] = l[t](d(l, t + 1, e[3]))
                                n = n + 1
                                e = o[n]
                                l[e[2]] = I[e[3]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = l[e[3]][e[4]]
                                n = n + 1
                                e = o[n]
                                l[e[2]] = {}
                                n = n + 1
                                e = o[n]
                                l[e[2]][e[3]] = e[4]
                            else
                                if (l[e[2]] <= l[e[4]]) then
                                    n = e[3]
                                else
                                    n = n + 1
                                end
                            end
                        elseif t <= 78 then
                            l[e[2]] = l[e[3]] - l[e[4]]
                        elseif t > 79 then
                            if l[e[2]] then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        else
                            local o = e[2]
                            local t, n = {l[o](d(l, o + 1, e[3]))}, 0
                            for e = o, e[4] do
                                n = n + 1
                                l[e] = t[n]
                            end
                        end
                    elseif t <= 83 then
                        if t <= 81 then
                            if (l[e[2]] <= l[e[4]]) then
                                n = e[3]
                            else
                                n = n + 1
                            end
                        elseif t > 82 then
                            local e = e[2]
                            do
                                return d(l, e, f)
                            end
                        else
                            local t
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = C[e[3]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            l[e[2]] = l[e[3]][e[4]]
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return l[t](d(l, t + 1, e[3]))
                            end
                            n = n + 1
                            e = o[n]
                            t = e[2]
                            do
                                return d(l, t, f)
                            end
                            n = n + 1
                            e = o[n]
                            do
                                return
                            end
                        end
                    elseif t <= 84 then
                        l[e[2]][e[3]] = l[e[4]]
                    elseif t > 85 then
                        if (l[e[2]] ~= e[4]) then
                            n = n + 1
                        else
                            n = e[3]
                        end
                    else
                        local n = e[2]
                        local t, o = {l[n](d(l, n + 1, e[3]))}, 0
                        for e = n, e[4] do
                            o = o + 1
                            l[e] = t[o]
                        end
                    end
                elseif t <= 92 then
                    if t <= 89 then
                        if t <= 87 then
                            local n = e[2]
                            local o = {l[n]()}
                            local t = e[4]
                            local e = 0
                            for n = n, t do
                                e = e + 1
                                l[n] = o[e]
                            end
                        elseif t == 88 then
                            if (l[e[2]] < l[e[4]]) then
                                n = n + 1
                            else
                                n = e[3]
                            end
                        else
                            local e = e[2]
                            l[e] = l[e]()
                        end
                    elseif t <= 90 then
                        l[e[2]] = I[e[3]]
                    elseif t == 91 then
                        local f
                        local t
                        l[e[2]] = I[e[3]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]][e[3]] = l[e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = I[e[3]]
                        n = n + 1
                        e = o[n]
                        t = e[2]
                        f = l[e[3]]
                        l[t + 1] = f
                        l[t] = f[e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = C[e[3]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = C[e[3]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]][e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]] - l[e[4]]
                        n = n + 1
                        e = o[n]
                        l[e[2]] = l[e[3]]
                        n = n + 1
                        e = o[n]
                        t = e[2]
                        l[t] = l[t](d(l, t + 1, e[3]))
                        n = n + 1
                        e = o[n]
                        if (l[e[2]] ~= e[4]) then
                            n = n + 1
                        else
                            n = e[3]
                        end
                    else
                        l[e[2]][e[3]] = e[4]
                    end
                elseif t <= 95 then
                    if t <= 93 then
                        do
                            return l[e[2]]
                        end
                    elseif t > 94 then
                        local e = e[2]
                        l[e] = l[e]()
                    else
                        l[e[2]] = l[e[3]][e[4]]
                    end
                elseif t <= 97 then
                    if t > 96 then
                        l[e[2]] = C[e[3]]
                    else
                        local n = e[2]
                        local o = l[n]
                        for e = n + 1, e[3] do
                            L(o, l[e])
                        end
                    end
                elseif t == 98 then
                    l[e[2]] = C[e[3]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = l[e[3]][e[4]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = l[e[3]][e[4]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = l[e[3]] - l[e[4]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = l[e[3]][e[4]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = C[e[3]]
                    n = n + 1
                    e = o[n]
                    l[e[2]] = l[e[3]][e[4]]
                    n = n + 1
                    e = o[n]
                    if (l[e[2]] < l[e[4]]) then
                        n = n + 1
                    else
                        n = e[3]
                    end
                else
                    l[e[2]] = l[e[3]]
                end
                n = n + 1
            end
        end
    end
    return c(s(), {}, r)(...)
end)(...)
