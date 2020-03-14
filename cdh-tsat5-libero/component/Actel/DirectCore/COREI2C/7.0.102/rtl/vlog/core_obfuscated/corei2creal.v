// Copyright (c) 2009  Actel Corp.                             --
// Revision: CoreI2C v6.0  18Aug2009
// SVN Revision Information:
// SVN $Revision: 15636 $
`timescale 1ns/1ns
module
COREI2CREAL
#
(
parameter
FAMILY
=
17
,
parameter
OPERATING_MODE
=
0
,
parameter
BAUD_RATE_FIXED
=
0
,
parameter
BAUD_RATE_VALUE
=
3
'b
000
,
parameter
BCLK_ENABLED
=
1
,
parameter
GLITCHREG_NUM
=
3
,
parameter
SMB_EN
=
0
,
parameter
IPMI_EN
=
1
,
parameter
FREQUENCY
=
30
,
parameter
FIXED_SLAVE0_ADDR_EN
=
0
,
parameter
FIXED_SLAVE0_ADDR_VALUE
=
8
'h
00
,
parameter
ADD_SLAVE1_ADDRESS_EN
=
1
,
parameter
FIXED_SLAVE1_ADDR_EN
=
0
,
parameter
FIXED_SLAVE1_ADDR_VALUE
=
8
'h
00
)
(
input
pulse_215us,
input
[
7
:
0
]
seradr0,
input
[
7
:
0
]
seradr1,
input
seradr1apb0,
input
PRESETN,
input
PCLK,
input
BCLKe,
input
PSEL,
input
PENABLE,
input
PWRITE,
input
[
4
:
0
]
PADDR,
input
[
7
:
0
]
PWDATA,
output
[
7
:
0
]
PRDATA,
output
INT,
input
SCLI,
input
SDAI,
output
SCLO,
output
SDAO,
input
SMBALERT_NI,
output
SMBALERT_NO,
output
SMBA_INT,
input
SMBSUS_NI,
output
SMBSUS_NO,
output
SMBS_INT
)
;
localparam
CI2CI0l
=
4
;
localparam
[
CI2CI0l
-
1
:
0
]
CI2Cl0l
=
GLITCHREG_NUM
+
2
;
localparam
CI2CO1l
=
OPERATING_MODE
[
1
]
;
localparam
CI2CI1l
=
OPERATING_MODE
[
0
]
;
parameter
[
4
:
0
]
CI2Cl1l
=
5
'b
00000
;
parameter
[
7
:
0
]
CI2COO0
=
8
'b
00000000
;
parameter
[
4
:
0
]
CI2CIO0
=
5
'b
00100
;
parameter
[
7
:
0
]
CI2ClO0
=
8
'b
11111000
;
parameter
[
4
:
0
]
CI2COI0
=
5
'b
01000
;
parameter
[
7
:
0
]
CI2CII0
=
8
'b
00000000
;
parameter
[
4
:
0
]
CI2ClI0
=
5
'b
10000
;
parameter
[
7
:
0
]
CI2COl0
=
8
'b
01X1X000
;
parameter
[
4
:
0
]
CI2CII
=
5
'b
01100
;
parameter
[
7
:
0
]
CI2ClI
=
8
'b
00000000
;
parameter
[
4
:
0
]
CI2COl
=
5
'b
11100
;
parameter
[
7
:
0
]
CI2CIl
=
8
'b
00000000
;
parameter
[
4
:
0
]
CI2CIl0
=
0
;
parameter
[
4
:
0
]
CI2Cll0
=
1
;
parameter
[
4
:
0
]
CI2CO00
=
29
;
parameter
[
4
:
0
]
CI2CI00
=
2
;
parameter
[
4
:
0
]
CI2Cl00
=
3
;
parameter
[
4
:
0
]
CI2CO10
=
4
;
parameter
[
4
:
0
]
CI2CI10
=
5
;
parameter
[
4
:
0
]
CI2Cl10
=
6
;
parameter
[
4
:
0
]
CI2COO1
=
7
;
parameter
[
4
:
0
]
CI2CIO1
=
8
;
parameter
[
4
:
0
]
CI2ClO1
=
9
;
parameter
[
4
:
0
]
CI2COI1
=
10
;
parameter
[
4
:
0
]
CI2CII1
=
11
;
parameter
[
4
:
0
]
CI2ClI1
=
12
;
parameter
[
4
:
0
]
CI2COl1
=
13
;
parameter
[
4
:
0
]
CI2CIl1
=
14
;
parameter
[
4
:
0
]
CI2Cll1
=
15
;
parameter
[
4
:
0
]
CI2CO01
=
16
;
parameter
[
4
:
0
]
CI2CI01
=
17
;
parameter
[
4
:
0
]
CI2Cl01
=
18
;
parameter
[
4
:
0
]
CI2CO11
=
19
;
parameter
[
4
:
0
]
CI2CI11
=
20
;
parameter
[
4
:
0
]
CI2Cl11
=
21
;
parameter
[
4
:
0
]
CI2COOOI
=
22
;
parameter
[
4
:
0
]
CI2CIOOI
=
23
;
parameter
[
4
:
0
]
CI2ClOOI
=
24
;
parameter
[
4
:
0
]
CI2COIOI
=
25
;
parameter
[
4
:
0
]
CI2CIIOI
=
26
;
parameter
[
4
:
0
]
CI2ClIOI
=
27
;
parameter
[
4
:
0
]
CI2COlOI
=
28
;
parameter
[
2
:
0
]
CI2CIlOI
=
0
;
parameter
[
2
:
0
]
CI2CllOI
=
1
;
parameter
[
2
:
0
]
CI2CO0OI
=
2
;
parameter
[
2
:
0
]
CI2CI0OI
=
3
;
parameter
[
2
:
0
]
CI2Cl0OI
=
4
;
parameter
[
2
:
0
]
CI2CO1OI
=
5
;
parameter
[
2
:
0
]
CI2CI1OI
=
6
;
parameter
[
2
:
0
]
CI2Cl1OI
=
0
;
parameter
[
2
:
0
]
CI2COOII
=
1
;
parameter
[
2
:
0
]
CI2CIOII
=
2
;
parameter
[
2
:
0
]
CI2ClOII
=
3
;
parameter
[
2
:
0
]
CI2COIII
=
4
;
parameter
[
2
:
0
]
CI2CIIII
=
5
;
parameter
[
2
:
0
]
CI2ClIII
=
6
;
parameter
[
2
:
0
]
CI2COlII
=
7
;
parameter
[
2
:
0
]
CI2CIlII
=
0
;
parameter
[
2
:
0
]
CI2CllII
=
1
;
parameter
[
2
:
0
]
CI2CO0II
=
2
;
parameter
[
2
:
0
]
CI2CI0II
=
3
;
parameter
[
2
:
0
]
CI2Cl0II
=
4
;
parameter
[
2
:
0
]
CI2CO1II
=
5
;
parameter
[
2
:
0
]
CI2CI1II
=
6
;
parameter
CI2Cl1II
=
8
;
parameter
CI2COOlI
=
7
;
wire
[
7
:
0
]
CI2CIOlI
=
8
'b
10100100
;
reg
[
7
:
0
]
CI2ClOlI
;
wire
CI2COIlI
;
wire
[
6
:
0
]
CI2CIIlI
=
7
'b
1110110
;
reg
[
6
:
0
]
CI2ClIlI
;
wire
CI2COllI
;
wire
[
3
:
0
]
CI2CIllI
=
4
'b
1111
;
reg
[
3
:
0
]
CI2ClllI
;
wire
CI2CO0lI
;
wire
CI2CI0lI
;
assign
INT
=
CI2CI0lI
;
reg
[
2
:
0
]
CI2Cl0lI
; ///* synthesis syn_state_machine = 0 */ ;// Master/slave mode detection FSM state
reg
[
2
:
0
]
CI2CO1lI
;
reg
[
2
:
0
]
CI2CI1lI
; ///* synthesis syn_state_machine = 0 */ ;// Clock synchronization FSM
reg
[
2
:
0
]
CI2Cl1lI
;
reg
[
2
:
0
]
CI2COO0I
; ///* synthesis syn_state_machine = 0 */ ;// stop/start detector FSM
reg
[
2
:
0
]
CI2CIO0I
;
reg
[
4
:
0
]
CI2ClO0I
/* synthesis syn_state_machine = 0 */
;
reg
[
4
:
0
]
CI2COI0I
;
reg
[
7
:
0
]
CI2CII0I
;
reg
[
7
:
0
]
CI2ClI0I
;
reg
[
4
:
0
]
CI2COl0I
;
reg
CI2CIl0I
;
reg
CI2Cll0I
;
wire
CI2CO00I
;
reg
CI2CI00I
;
wire
CI2Cl00I
;
reg
CI2CO10I
;
reg
CI2CI10I
;
reg
CI2Cl10I
;
wire
[
2
:
0
]
CI2COO1I
;
wire
CI2CIO1I
;
wire
CI2ClO1I
;
wire
CI2COI1I
;
wire
CI2CII1I
;
wire
CI2ClI1I
,
CI2COl1I
;
reg
CI2CIl1I
,
CI2Cll1I
,
CI2CO01I
;
reg
CI2CI01I
;
reg
CI2Cl01I
;
wire
CI2CO11I
;
wire
CI2CI11I
;
reg
CI2Cl11I
,
CI2COOOl
;
reg
CI2CIOOl
,
CI2ClOOl
;
reg
CI2COIOl
;
reg
CI2CIIOl
;
reg
CI2ClIOl
;
reg
CI2COlOl
;
reg
[
GLITCHREG_NUM
-
1
:
0
]
CI2CIlOl
;
reg
CI2CllOl
;
reg
[
GLITCHREG_NUM
-
1
:
0
]
CI2CO0Ol
;
reg
CI2CI0Ol
;
reg
CI2Cl0Ol
;
reg
CI2CO1Ol
;
reg
CI2CI1Ol
;
reg
CI2Cl1Ol
;
reg
[
3
:
0
]
CI2COOIl
;
reg
CI2CIOIl
;
reg
[
3
:
0
]
CI2ClOIl
;
reg
CI2COIIl
;
reg
CI2CIIIl
;
reg
CI2ClIIl
;
wire
CI2COlIl
;
wire
CI2CIlIl
;
wire
CI2CllIl
;
reg
[
3
:
0
]
CI2CO0Il
;
reg
CI2CI0Il
;
reg
[
CI2CI0l
-
1
:
0
]
CI2Cl0Il
;
reg
CI2CO1Il
;
reg
CI2CI1Il
;
reg
CI2Cl1Il
;
wire
CI2COOll
;
reg
CI2CIOll
;
reg
CI2ClOll
;
assign
SDAO
=
CI2CI1Il
;
assign
SCLO
=
(
CI2ClI1I
)
?
1
'b
0
:
CI2Cl1Il
;
assign
CI2CI0lI
=
CI2COOll
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2COIll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CI1Il
<=
1
'b
1
;
end
else
begin
if
(
(
!
CI2CIO1I
)
|
(
CI2Cl0lI
==
CI2CI0II
)
|
(
CI2Cl0lI
==
CI2CIlII
&
!
CI2Cl0Ol
)
)
begin
CI2CI1Il
<=
1
'b
1
;
end
else
if
(
(
CI2Cl0lI
==
CI2CllII
|
CI2Cl0lI
==
CI2Cl0II
|
CI2Cl0lI
==
CI2CI1II
)
|
(
CI2Cl0Ol
&
CI2CO1Ol
)
)
begin
CI2CI1Il
<=
1
'b
0
;
end
else
if
(
CI2ClO0I
==
CI2Cl10
)
begin
CI2CI1Il
<=
1
'b
1
;
end
else
if
(
(
(
(
CI2ClO0I
==
CI2COO1
|
CI2ClO0I
==
CI2ClO1
)
&&
(
CI2CO1l
==
0
)
)
|
CI2ClO0I
==
CI2CII1
|
CI2ClO0I
==
CI2ClI1
|
CI2ClO0I
==
CI2Cll1
|
CI2ClO0I
==
CI2COl1
|
CI2ClO0I
==
CI2CIl1
|
CI2ClO0I
==
CI2CI01
)
&
(
CI2CO0Il
==
4
'b
0111
|
CI2CO0Il
==
4
'b
1000
)
)
begin
if
(
CI2CO0Il
==
4
'b
0111
&
CI2CI1Ol
)
begin
CI2CI1Il
<=
~
CI2COlOl
;
end
end
else
if
(
CI2ClO0I
==
CI2CIl0
|
CI2ClO0I
==
CI2Cll0
|
CI2ClO0I
==
CI2CI00
|
CI2ClO0I
==
CI2Cl00
|
CI2ClO0I
==
CI2CO10
|
CI2ClO0I
==
CI2CI10
|
(
(
CI2ClO0I
==
CI2CI11
|
CI2ClO0I
==
CI2Cl11
|
CI2ClO0I
==
CI2COOOI
)
&&
(
CI2CO1l
==
0
)
)
)
begin
if
(
CI2CO0Il
<
4
'b
1000
|
CI2CO0Il
==
4
'b
1001
)
begin
CI2CI1Il
<=
CI2COIOl
;
end
else
begin
CI2CI1Il
<=
1
'b
1
;
end
end
else
begin
CI2CI1Il
<=
1
'b
1
;
end
end
end
assign
CI2COO1I
=
BAUD_RATE_FIXED
==
1
?
BAUD_RATE_VALUE
:
{
CI2CII0I
[
7
]
,
CI2CII0I
[
1
:
0
]
}
;
assign
CI2CIO1I
=
CI2CII0I
[
6
]
&
CI2Cl01I
;
generate
if
(
CI2CI1l
==
0
)
begin
assign
CI2ClO1I
=
CI2CII0I
[
5
]
&
(
~
CI2COI1I
)
;
assign
CI2COI1I
=
CI2CII0I
[
4
]
;
end
else
begin
assign
CI2ClO1I
=
1
'b
0
;
assign
CI2COI1I
=
1
'b
0
;
end
endgenerate
assign
CI2COOll
=
CI2CII0I
[
3
]
;
assign
CI2CII1I
=
CI2CII0I
[
2
]
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CIIll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CII0I
<=
CI2COO0
;
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2Cl1l
)
)
begin
CI2CII0I
<=
PWDATA
;
end
else
begin
if
(
(
CI2CIO1I
)
&
(
(
(
CI2Cl0lI
==
CI2CllII
|
CI2Cl0lI
==
CI2CI1II
)
&
(
CI2COO0I
==
CI2CI0OI
)
)
|
(
(
CI2CO0Il
==
4
'b
1000
&
CI2Cl1Ol
)
&
(
CI2CI0Il
|
CI2Cl0Ol
)
)
|
(
(
CI2CO0Il
==
4
'b
0000
|
CI2CO0Il
==
4
'b
1001
)
&
(
CI2COO0I
==
CI2CI0OI
|
CI2COO0I
==
CI2CO1OI
)
&
(
CI2Cl0Ol
)
)
|
(
(
CI2CO0Il
==
4
'b
0001
|
CI2CO0Il
==
4
'b
0010
|
CI2CO0Il
==
4
'b
0011
|
CI2CO0Il
==
4
'b
0100
|
CI2CO0Il
==
4
'b
0101
|
CI2CO0Il
==
4
'b
0110
|
CI2CO0Il
==
4
'b
0111
|
CI2CO0Il
==
4
'b
1000
)
&
(
CI2COO0I
==
CI2CI0OI
|
CI2COO0I
==
CI2CO1OI
)
&
(
CI2CI0Il
|
CI2Cl0Ol
)
)
|
(
(
(
CI2COl1I
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
)
|
(
(
(
CI2COIlI
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
)
|
(
(
(
CI2COllI
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
&&
(
CI2ClO0I
!=
CI2ClIOI
)
)
)
|
(
(
(
CI2CO0lI
==
1
'b
1
)
&&
(
CI2CI11I
==
1
)
)
)
|
(
(
(
CI2CI01I
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
)
|
(
(
CI2Cl0lI
==
CI2Cl0II
&
CI2CI0Ol
&
CI2COlIl
)
)
)
)
begin
CI2CII0I
[
3
]
<=
1
'b
1
;
end
if
(
(
CI2Cl0lI
==
CI2Cl0II
&
CI2CIlIl
)
|
(
CI2COO0I
==
CI2CO1OI
)
|
(
!
CI2CI0Il
&
CI2COI1I
)
|
(
!
CI2CIO1I
)
)
begin
CI2CII0I
[
4
]
<=
1
'b
0
;
end
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2ClIll
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClI0I
<=
CI2CII0
;
CI2ClIOl
<=
1
'b
1
;
CI2COlOl
<=
1
'b
1
;
CI2COIOl
<=
1
'b
1
;
CI2CIIOl
<=
1
'b
1
;
end
else
begin
if
(
!
CI2CIO1I
)
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
end
end
else
begin
if
(
CI2COO0I
==
CI2CI0OI
)
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
end
CI2COIOl
<=
1
'b
0
;
CI2CIIOl
<=
1
'b
0
;
end
else
if
(
CI2ClO0I
==
CI2CIl0
|
CI2ClO0I
==
CI2Cll0
|
CI2ClO0I
==
CI2CI00
|
CI2ClO0I
==
CI2Cl00
|
CI2ClO0I
==
CI2CO10
|
CI2ClO0I
==
CI2CI10
|
(
(
CI2ClO0I
==
CI2CI11
|
CI2ClO0I
==
CI2Cl11
|
CI2ClO0I
==
CI2COOOI
)
&&
(
CI2CO1l
==
0
)
)
)
begin
if
(
CI2COOll
)
begin
CI2ClIOl
<=
1
'b
1
;
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
CI2CIIOl
<=
PWDATA
[
7
]
;
end
else
begin
if
(
!
CI2CI0Ol
)
begin
CI2COIOl
<=
CI2CIIOl
;
end
else
begin
CI2COIOl
<=
1
'b
1
;
end
end
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
CI2COIOl
<=
PWDATA
[
7
]
;
end
else
begin
if
(
CI2Cl1Ol
)
begin
CI2ClI0I
<=
{
CI2ClI0I
[
6
:
0
]
,
CI2ClIOl
}
;
CI2ClIOl
<=
CI2CllOl
;
end
if
(
CI2CI1Ol
)
begin
CI2COIOl
<=
CI2ClI0I
[
7
]
;
CI2CIIOl
<=
1
'b
1
;
end
end
end
end
else
if
(
(
(
CI2ClO0I
==
CI2COO1
|
CI2ClO0I
==
CI2ClO1
)
&&
(
CI2CO1l
==
0
)
)
|
CI2ClO0I
==
CI2CII1
|
CI2ClO0I
==
CI2ClI1
|
CI2ClO0I
==
CI2Cll1
|
CI2ClO0I
==
CI2COl1
|
CI2ClO0I
==
CI2CIl1
|
CI2ClO0I
==
CI2CI01
)
begin
if
(
CI2COOll
)
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2Cl1l
)
)
begin
CI2COlOl
<=
PWDATA
[
2
]
;
end
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
end
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
end
else
if
(
CI2Cl1Ol
)
begin
CI2ClI0I
<=
{
CI2ClI0I
[
6
:
0
]
,
CI2ClIOl
}
;
CI2ClIOl
<=
CI2CllOl
;
end
end
CI2COIOl
<=
1
'b
1
;
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2COI0
)
)
begin
CI2ClI0I
<=
PWDATA
;
end
else
if
(
CI2Cl1Ol
)
begin
CI2ClI0I
<=
{
CI2ClI0I
[
6
:
0
]
,
CI2ClIOl
}
;
CI2ClIOl
<=
CI2CllOl
;
end
CI2COIOl
<=
1
'b
1
;
end
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2COlll
if
(
PRESETN
==
1
'b
0
)
begin
CI2COl0I
[
4
:
0
]
<=
CI2ClO0
[
4
:
0
]
;
end
else
begin
if
(
CI2COOll
)
begin
case
(
CI2ClO0I
)
CI2CIl0
:
begin
CI2COl0I
<=
5
'b
00001
;
end
CI2Cll0
:
begin
CI2COl0I
<=
5
'b
00010
;
end
CI2CI00
:
begin
CI2COl0I
<=
5
'b
00011
;
end
CI2Cl00
:
begin
CI2COl0I
<=
5
'b
00100
;
end
CI2CO10
:
begin
CI2COl0I
<=
5
'b
00101
;
end
CI2CI10
:
begin
CI2COl0I
<=
5
'b
00110
;
end
CI2Cl10
:
begin
CI2COl0I
<=
5
'b
00111
;
end
CI2COO1
:
begin
CI2COl0I
<=
5
'b
01000
;
end
CI2CIO1
:
begin
CI2COl0I
<=
5
'b
01001
;
end
CI2ClO1
:
begin
CI2COl0I
<=
5
'b
01010
;
end
CI2COI1
:
begin
CI2COl0I
<=
5
'b
01011
;
end
CI2CII1
:
begin
CI2COl0I
<=
5
'b
01100
;
end
CI2ClI1
:
begin
CI2COl0I
<=
5
'b
01101
;
end
CI2COl1
:
begin
CI2COl0I
<=
5
'b
01110
;
end
CI2CIl1
:
begin
CI2COl0I
<=
5
'b
01111
;
end
CI2Cll1
:
begin
CI2COl0I
<=
5
'b
10000
;
end
CI2CO01
:
begin
CI2COl0I
<=
5
'b
10001
;
end
CI2CI01
:
begin
CI2COl0I
<=
5
'b
10010
;
end
CI2Cl01
:
begin
CI2COl0I
<=
5
'b
10011
;
end
CI2CO11
:
begin
CI2COl0I
<=
5
'b
10100
;
end
CI2CI11
:
begin
CI2COl0I
<=
5
'b
10101
;
end
CI2Cl11
:
begin
CI2COl0I
<=
5
'b
10110
;
end
CI2COOOI
:
begin
CI2COl0I
<=
5
'b
10111
;
end
CI2CIOOI
:
begin
CI2COl0I
<=
5
'b
11000
;
end
CI2ClOOI
:
begin
CI2COl0I
<=
5
'b
11001
;
end
CI2CIIOI
:
begin
CI2COl0I
<=
5
'b
00000
;
end
CI2ClIOI
:
begin
CI2COl0I
<=
5
'b
11010
;
end
CI2COlOI
:
begin
CI2COl0I
<=
5
'b
11011
;
end
CI2CO00
:
begin
CI2COl0I
<=
5
'b
11100
;
end
default
:
begin
CI2COl0I
<=
5
'b
11111
;
end
endcase
end
else
begin
CI2COl0I
<=
5
'b
11111
;
end
end
end
generate
begin
:
CI2CIlll
if
(
SMB_EN
==
1
)
begin
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cllll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CIl0I
<=
CI2COl0
[
7
]
;
CI2Cll0I
<=
CI2COl0
[
6
]
;
CI2CI00I
<=
CI2COl0
[
4
]
;
CI2CO10I
<=
CI2COl0
[
2
]
;
CI2CI10I
<=
CI2COl0
[
1
]
;
CI2Cl10I
<=
CI2COl0
[
0
]
;
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2ClI0
)
)
begin
CI2CIl0I
<=
PWDATA
[
7
]
;
CI2Cll0I
<=
PWDATA
[
6
]
;
CI2CI00I
<=
PWDATA
[
4
]
;
CI2CO10I
<=
PWDATA
[
2
]
;
CI2CI10I
<=
PWDATA
[
1
]
;
CI2Cl10I
<=
PWDATA
[
0
]
;
end
else
if
(
(
CI2CIl0I
==
1
'b
1
)
&&
(
CI2COIlI
==
1
'b
1
)
)
begin
CI2CIl0I
<=
1
'b
0
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CO0ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2Cl11I
<=
1
'b
1
;
CI2CIOOl
<=
1
'b
1
;
CI2COOOl
<=
1
'b
1
;
CI2ClOOl
<=
1
'b
1
;
end
else
begin
CI2Cl11I
<=
SMBSUS_NI
;
CI2CIOOl
<=
SMBALERT_NI
;
CI2COOOl
<=
CI2Cl11I
;
CI2ClOOl
<=
CI2CIOOl
;
end
end
assign
CI2CI11I
=
1
'b
0
;
assign
CI2ClI1I
=
CI2CIl0I
;
assign
SMBSUS_NO
=
CI2Cll0I
;
assign
CI2CO00I
=
CI2COOOl
;
assign
SMBALERT_NO
=
CI2CI00I
;
assign
CI2Cl00I
=
CI2ClOOl
;
assign
CI2CO11I
=
CI2CO10I
;
assign
SMBS_INT
=
(
CI2CI10I
==
1
'b
1
)
?
~
CI2COOOl
:
1
'b
0
;
assign
SMBA_INT
=
(
CI2Cl10I
==
1
'b
1
)
?
~
CI2ClOOl
:
1
'b
0
;
end
else
if
(
IPMI_EN
==
1
)
begin
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cllll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CO10I
<=
CI2COl0
[
2
]
;
end
else
begin
if
(
(
PENABLE
&&
PWRITE
&&
PSEL
)
&&
(
PADDR
==
CI2ClI0
)
)
begin
CI2CO10I
<=
PWDATA
[
2
]
;
end
end
end
assign
CI2CI11I
=
CI2CO10I
;
assign
CI2ClI1I
=
1
'b
0
;
assign
SMBSUS_NO
=
1
'b
1
;
assign
CI2CO00I
=
1
'b
1
;
assign
SMBALERT_NO
=
1
'b
1
;
assign
CI2Cl00I
=
1
'b
1
;
assign
CI2CO11I
=
1
'b
0
;
assign
SMBS_INT
=
1
'b
0
;
assign
SMBA_INT
=
1
'b
0
;
end
else
begin
assign
CI2CI11I
=
1
'b
0
;
assign
CI2ClI1I
=
1
'b
0
;
assign
SMBSUS_NO
=
1
'b
1
;
assign
CI2CO00I
=
1
'b
1
;
assign
SMBALERT_NO
=
1
'b
1
;
assign
CI2Cl00I
=
1
'b
1
;
assign
CI2CO11I
=
1
'b
0
;
assign
SMBS_INT
=
1
'b
0
;
assign
SMBA_INT
=
1
'b
0
;
end
end
endgenerate
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CI0ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CIl1I
<=
1
'b
0
;
CI2Cll1I
<=
1
'b
0
;
CI2CO01I
<=
1
'b
0
;
end
else
begin
CI2CIl1I
<=
CI2ClI1I
;
CI2Cll1I
<=
CI2CIl1I
;
CI2CO01I
<=
CI2Cll1I
;
end
end
assign
CI2COl1I
=
(
(
CI2Cll1I
==
1
'b
1
)
&&
(
CI2CO01I
==
1
'b
0
)
)
?
1
'b
1
:
1
'b
0
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cl0ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CO0Ol
<=
{
GLITCHREG_NUM
{
1
'b
1
}
}
;
end
else
begin
if
(
CI2CIO1I
)
begin
CI2CO0Ol
<=
{
CI2CO0Ol
[
GLITCHREG_NUM
-
2
:
0
]
,
SCLI
}
;
end
else
begin
CI2CO0Ol
<=
{
GLITCHREG_NUM
{
1
'b
1
}
}
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CO1ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CI0Ol
<=
1
'b
1
;
CI2CI1Ol
<=
1
'b
0
;
CI2Cl1Ol
<=
1
'b
0
;
end
else
begin
if
(
|
CI2CO0Ol
==
1
'b
0
)
begin
CI2CI0Ol
<=
1
'b
0
;
if
(
CI2CI0Ol
)
begin
CI2CI1Ol
<=
1
'b
1
;
end
else
begin
CI2CI1Ol
<=
1
'b
0
;
end
end
else
if
(
&
CI2CO0Ol
==
1
'b
1
)
begin
CI2CI0Ol
<=
1
'b
1
;
if
(
!
CI2CI0Ol
)
begin
CI2Cl1Ol
<=
1
'b
1
;
end
else
begin
CI2Cl1Ol
<=
1
'b
0
;
end
end
else
begin
CI2Cl1Ol
<=
1
'b
0
;
CI2CI1Ol
<=
1
'b
0
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CI1ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CIlOl
<=
{
GLITCHREG_NUM
{
1
'b
1
}
}
;
end
else
begin
if
(
CI2CIO1I
)
begin
CI2CIlOl
<=
{
CI2CIlOl
[
GLITCHREG_NUM
-
2
:
0
]
,
SDAI
}
;
end
else
begin
CI2CIlOl
<=
{
GLITCHREG_NUM
{
1
'b
0
}
}
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cl1ll
if
(
PRESETN
==
1
'b
0
)
begin
CI2CllOl
<=
1
'b
1
;
end
else
begin
if
(
|
CI2CIlOl
==
1
'b
0
)
begin
CI2CllOl
<=
1
'b
0
;
end
else
if
(
&
CI2CIlOl
==
1
'b
1
)
begin
CI2CllOl
<=
1
'b
1
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2COO0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2Cl0Ol
<=
1
'b
0
;
CI2CO1Ol
<=
1
'b
0
;
end
else
begin
if
(
!
CI2CI0Il
&
CI2COI1I
)
begin
CI2Cl0Ol
<=
1
'b
0
;
CI2CO1Ol
<=
1
'b
0
;
end
else
if
(
CI2Cl01I
==
1
'b
0
)
begin
CI2Cl0Ol
<=
1
'b
0
;
CI2CO1Ol
<=
1
'b
0
;
end
else
begin
if
(
CI2COO0I
==
CI2CI0OI
)
begin
CI2CO1Ol
<=
1
'b
1
;
end
else
if
(
CI2CO0Il
==
4
'b
1000
&
CI2CI1Ol
)
begin
CI2CO1Ol
<=
1
'b
0
;
end
if
(
(
CI2COO0I
==
CI2CI0OI
|
CI2COO0I
==
CI2CO1OI
)
|
(
(
CI2ClO0I
==
CI2CO01
|
CI2ClO0I
==
CI2Cl01
|
CI2ClO0I
==
CI2ClOOI
|
CI2ClO0I
==
CI2CIOOI
|
CI2ClO0I
==
CI2Cl10
|
CI2ClO0I
==
CI2CO11
|
CI2ClO0I
==
CI2CIIOI
)
&
(
CI2COOll
)
)
)
begin
CI2Cl0Ol
<=
1
'b
0
;
end
else
if
(
(
CI2CO1Ol
&
CI2CO0Il
==
4
'b
0111
&
CI2CI1Ol
&
CI2CII1I
)
&
(
~
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
&
CI2ClIOl
)
)
&
(
(
(
CI2ClI0I
[
6
:
0
]
==
seradr0
[
7
:
1
]
)
|
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
&
(
seradr0
[
0
]
)
)
)
|
(
(
(
(
ADD_SLAVE1_ADDRESS_EN
==
1
)
&&
(
seradr1apb0
==
1
'b
1
)
)
&&
(
CI2ClI0I
[
6
:
0
]
==
seradr1
[
7
:
1
]
)
&&
FIXED_SLAVE1_ADDR_EN
)
|
(
(
ADD_SLAVE1_ADDRESS_EN
==
1
)
&&
(
CI2ClI0I
[
6
:
0
]
==
seradr1
[
7
:
1
]
)
&&
~
FIXED_SLAVE1_ADDR_EN
)
|
(
(
(
(
ADD_SLAVE1_ADDRESS_EN
==
1
)
&&
(
seradr1apb0
==
1
'b
1
)
)
&&
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
)
&&
~
FIXED_SLAVE1_ADDR_EN
)
)
)
)
&
(
!
CI2CI0Il
|
CI2ClO0I
==
CI2Cl10
)
)
begin
CI2Cl0Ol
<=
1
'b
1
;
end
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CIO0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2Cl0Il
<=
{
CI2CI0l
{
1
'b
0
}
}
;
end
else
begin
if
(
CI2CI1lI
==
CI2ClOII
)
begin
if
(
~
(
CI2Cl0Il
==
CI2Cl0l
)
)
begin
CI2Cl0Il
<=
CI2Cl0Il
+
1
'b
1
;
end
end
else
begin
CI2Cl0Il
<=
{
CI2CI0l
{
1
'b
0
}
}
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2ClO0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2CO0Il
<=
4
'b
1111
;
end
else
begin
if
(
CI2COO0I
==
CI2CI0OI
)
begin
CI2CO0Il
<=
4
'b
1111
;
end
else
if
(
(
CI2COO0I
==
CI2CO1OI
)
|
(
CI2COOll
&
!
CI2CI0Ol
)
)
begin
CI2CO0Il
<=
4
'b
1001
;
end
else
if
(
CI2CO0Il
==
4
'b
1001
)
begin
if
(
CI2ClO0I
==
CI2CO11
|
CI2ClO0I
==
CI2CO01
|
CI2ClO0I
==
CI2ClOOI
|
CI2ClO0I
==
CI2Cl01
|
CI2ClO0I
==
CI2CIOOI
)
begin
CI2CO0Il
<=
4
'b
0000
;
end
else
begin
if
(
(
!
CI2COOll
)
&
(
!
CI2COI1I
)
&
(
!
CI2ClO1I
|
CI2ClO0I
==
CI2CIl0
|
CI2ClO0I
==
CI2Cll0
)
)
begin
CI2CO0Il
<=
4
'b
0000
;
end
else
begin
CI2CO0Il
<=
4
'b
1001
;
end
end
end
else
if
(
CI2CI1Ol
)
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
(
!
CI2COOll
)
&
(
!
CI2COI1I
)
&
(
!
CI2ClO1I
|
CI2ClO0I
==
CI2CIl0
|
CI2ClO0I
==
CI2Cll0
)
)
begin
CI2CO0Il
<=
4
'b
0000
;
end
else
begin
CI2CO0Il
<=
4
'b
1001
;
end
end
else
begin
CI2CO0Il
<=
CI2CO0Il
+
1
'b
1
;
end
end
end
end
assign
CI2CllIl
=
(
(
CI2CI1lI
==
CI2COOII
|
CI2CI1lI
==
CI2COIII
|
CI2CI1lI
==
CI2CIIII
)
|
(
!
CI2CI0Il
&
CI2COI1I
)
|
(
CI2COO0I
==
CI2CO1OI
)
|
(
CI2COO0I
==
CI2CI0OI
)
|
(
CI2Cl0lI
==
CI2Cl0II
&
!
CI2CI0Ol
&
CI2Cl1Il
)
|
(
CI2CO1Il
&
!
CI2CI0Ol
&
~
(
CI2Cl0lI
==
CI2CO1II
)
)
)
?
1
'b
1
:
1
'b
0
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2COI0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
if
(
CI2CllIl
)
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
case
(
CI2COO1I
)
3
'b
000
:
begin
if
(
CI2COOIl
<
4
'b
1111
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
001
:
begin
if
(
CI2COOIl
<
4
'b
1101
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
010
:
begin
if
(
CI2COOIl
<
4
'b
1011
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
011
:
begin
if
(
CI2COOIl
<
4
'b
1001
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
100
:
begin
if
(
CI2COOIl
<
4
'b
1110
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
101
:
begin
if
(
CI2COOIl
<
4
'b
1110
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
3
'b
110
:
begin
if
(
CI2COOIl
<
4
'b
1110
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
default
:
begin
if
(
BCLKe
)
begin
if
(
CI2COOIl
<
4
'b
0001
)
begin
CI2COOIl
<=
CI2COOIl
+
1
'b
1
;
CI2CIOIl
<=
1
'b
0
;
end
else
begin
CI2COOIl
<=
4
'b
0000
;
CI2CIOIl
<=
1
'b
1
;
end
end
else
begin
CI2CIOIl
<=
1
'b
0
;
end
end
endcase
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CII0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClOIl
<=
4
'b
0000
;
CI2COIIl
<=
1
'b
0
;
end
else
begin
if
(
CI2CllIl
)
begin
CI2ClOIl
<=
4
'b
0000
;
CI2COIIl
<=
1
'b
0
;
end
else
begin
if
(
CI2CIOIl
)
begin
CI2ClOIl
<=
CI2ClOIl
+
1
'b
1
;
case
(
CI2COO1I
)
3
'b
101
:
begin
if
(
CI2ClOIl
[
0
]
)
begin
CI2COIIl
<=
1
'b
1
;
end
else
begin
CI2COIIl
<=
1
'b
0
;
end
end
3
'b
000
,
3
'b
001
,
3
'b
010
,
3
'b
011
:
begin
if
(
CI2ClOIl
[
1
:
0
]
==
2
'b
11
)
begin
CI2COIIl
<=
1
'b
1
;
end
else
begin
CI2COIIl
<=
1
'b
0
;
end
end
3
'b
100
:
begin
if
(
CI2ClOIl
==
4
'b
1111
)
begin
CI2COIIl
<=
1
'b
1
;
end
else
begin
CI2COIIl
<=
1
'b
0
;
end
end
default
:
begin
CI2COIIl
<=
1
'b
1
;
end
endcase
end
else
begin
CI2COIIl
<=
1
'b
0
;
end
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2ClI0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2CIIIl
<=
1
'b
1
;
CI2ClIIl
<=
1
'b
1
;
end
else
begin
if
(
CI2CllIl
)
begin
CI2CIIIl
<=
1
'b
1
;
CI2ClIIl
<=
1
'b
1
;
end
else
begin
if
(
CI2COIIl
)
begin
CI2CIIIl
<=
~
CI2CIIIl
;
end
CI2ClIIl
<=
CI2CIIIl
;
end
end
end
assign
CI2COlIl
=
(
~
CI2ClIIl
)
&
CI2CIIIl
;
assign
CI2CIlIl
=
CI2ClIIl
&
(
~
CI2CIIIl
)
;
always
@
(
CI2CI1lI
or
CI2CI0Ol
or
CI2COlIl
or
CI2Cl0Il
or
CI2COOll
or
CI2CllOl
or
CI2COI1I
or
CI2CO0Il
or
CI2Cl0lI
)
begin
:
CI2COl0l
CI2Cl1lI
=
CI2COlII
;
case
(
CI2CI1lI
)
CI2Cl1OI
:
begin
if
(
!
CI2CI0Ol
)
begin
CI2Cl1lI
=
CI2COOII
;
end
else
begin
if
(
CI2COlIl
&
~
(
CI2Cl0lI
==
CI2CI0II
|
CI2Cl0lI
==
CI2Cl0II
)
)
begin
CI2Cl1lI
=
CI2CIOII
;
end
else
begin
CI2Cl1lI
=
CI2Cl1OI
;
end
end
end
CI2COOII
:
begin
CI2Cl1lI
=
CI2CIOII
;
end
CI2CIOII
:
begin
if
(
CI2COlIl
)
begin
if
(
CI2COOll
)
begin
CI2Cl1lI
=
CI2CIIII
;
end
else
begin
if
(
CI2COI1I
&
CI2CO0Il
==
4
'b
1001
)
begin
CI2Cl1lI
=
CI2ClIII
;
end
else
begin
CI2Cl1lI
=
CI2ClOII
;
end
end
end
else
begin
CI2Cl1lI
=
CI2CIOII
;
end
end
CI2ClOII
:
begin
if
(
CI2Cl0Il
==
CI2Cl0l
)
begin
if
(
CI2CI0Ol
)
begin
CI2Cl1lI
=
CI2Cl1OI
;
end
else
begin
CI2Cl1lI
=
CI2COIII
;
end
end
else
begin
CI2Cl1lI
=
CI2ClOII
;
end
end
CI2COIII
:
begin
if
(
CI2CI0Ol
)
begin
CI2Cl1lI
=
CI2Cl1OI
;
end
else
begin
CI2Cl1lI
=
CI2COIII
;
end
end
CI2CIIII
:
begin
if
(
!
CI2COOll
)
begin
if
(
CI2COI1I
)
begin
CI2Cl1lI
=
CI2ClIII
;
end
else
begin
CI2Cl1lI
=
CI2ClOII
;
end
end
else
begin
CI2Cl1lI
=
CI2CIIII
;
end
end
CI2ClIII
:
begin
if
(
!
CI2CllOl
)
begin
CI2Cl1lI
=
CI2COlII
;
end
else
begin
CI2Cl1lI
=
CI2ClIII
;
end
end
default
:
begin
CI2Cl1lI
=
CI2COlII
;
end
endcase
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CIl0l
if
(
PRESETN
==
1
'b
0
)
begin
CI2CI1lI
<=
CI2Cl1OI
;
CI2Cl1Il
<=
1
'b
1
;
end
else
begin
if
(
CI2Cl0lI
==
CI2CIlII
)
begin
CI2CI1lI
<=
CI2Cl1OI
;
end
else
begin
CI2CI1lI
<=
CI2Cl1lI
;
end
if
(
(
CI2CIO1I
)
&
(
(
CI2CI1lI
==
CI2COOII
|
CI2CI1lI
==
CI2CIOII
|
CI2CI1lI
==
CI2CIIII
|
CI2CI1lI
==
CI2ClIII
)
|
(
(
(
(
CI2ClO0I
==
CI2CI11
|
CI2ClO0I
==
CI2Cl11
|
CI2ClO0I
==
CI2CIOOI
|
CI2ClO0I
==
CI2ClOOI
|
CI2ClO0I
==
CI2COOOI
)
&&
(
CI2CO1l
==
0
)
)
|
CI2ClO0I
==
CI2CII1
|
CI2ClO0I
==
CI2ClI1
|
CI2ClO0I
==
CI2Cll1
|
CI2ClO0I
==
CI2CO01
|
CI2ClO0I
==
CI2COl1
|
CI2ClO0I
==
CI2CIl1
|
CI2ClO0I
==
CI2CI01
|
CI2ClO0I
==
CI2Cl01
|
CI2ClO0I
==
CI2CO11
)
&
(
!
CI2CI0Ol
)
&
(
CI2COOll
)
)
)
)
begin
CI2Cl1Il
<=
1
'b
0
;
end
else
begin
CI2Cl1Il
<=
1
'b
1
;
end
end
end
always
@
(
CI2ClO0I
or
CI2Cl1Ol
or
CI2ClIOl
or
CI2CllOl
or
CI2CI1Il
or
CI2CO0Il
or
CI2CII1I
or
CI2Cl0Ol
or
CI2CO1Ol
or
CI2ClI0I
or
seradr0
or
seradr1
)
begin
:
CI2Cll0l
CI2COI0I
=
CI2COIOI
;
case
(
CI2ClO0I
)
CI2ClIOI
:
begin
CI2COI0I
=
CI2ClIOI
;
end
CI2CIl0
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2ClIOl
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2Cl00
;
end
else
begin
CI2COI0I
=
CI2CI00
;
end
end
else
if
(
CI2CO1l
==
0
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CIO1
;
end
else
begin
CI2COI0I
=
CI2COO1
;
end
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2CIl0
;
end
end
end
CI2Cll0
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2ClIOl
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2Cl00
;
end
else
begin
CI2COI0I
=
CI2CI00
;
end
end
else
if
(
CI2CO1l
==
0
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CIO1
;
end
else
begin
CI2COI0I
=
CI2COO1
;
end
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2Cll0
;
end
end
end
CI2CI00
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CI10
;
end
else
begin
CI2COI0I
=
CI2CO10
;
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2CI00
;
end
end
end
CI2Cl00
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CI10
;
end
else
begin
CI2COI0I
=
CI2CO10
;
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2Cl00
;
end
end
end
CI2CO10
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CI10
;
end
else
begin
CI2COI0I
=
CI2CO10
;
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2CO10
;
end
end
end
CI2CI10
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CI10
;
end
else
begin
CI2COI0I
=
CI2CO10
;
end
end
else
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2CI10
;
end
end
end
CI2Cl10
:
begin
if
(
CI2Cl0Ol
&
CI2CO1Ol
&
CI2CO0Il
==
4
'b
1000
)
begin
if
(
(
CI2ClIOl
)
&&
(
CI2CO1l
==
0
)
)
begin
CI2COI0I
=
CI2Cl11
;
end
else
begin
if
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
&
(
seradr0
[
0
]
)
)
begin
CI2COI0I
=
CI2CIl1
;
end
else
if
(
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
)
&&
(
seradr1
[
0
]
==
1
'b
1
)
&&
(
ADD_SLAVE1_ADDRESS_EN
==
1
)
)
begin
CI2COI0I
=
CI2CIl1
;
end
else
begin
CI2COI0I
=
CI2ClI1
;
end
end
end
else
begin
CI2COI0I
=
CI2Cl10
;
end
end
CI2COO1
:
begin
if
(
(
CI2CO0Il
==
4
'b
1000
)
&&
(
CI2CO1l
==
0
)
)
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2ClO1
;
end
else
begin
CI2COI0I
=
CI2COI1
;
end
end
end
else
begin
CI2COI0I
=
CI2COO1
;
end
end
CI2CIO1
:
begin
CI2COI0I
=
CI2CIO1
;
end
CI2ClO1
:
begin
if
(
(
CI2CO0Il
==
4
'b
1000
)
&&
(
CI2CO1l
==
0
)
)
begin
if
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2ClO1
;
end
else
begin
CI2COI0I
=
CI2COI1
;
end
end
end
else
begin
CI2COI0I
=
CI2ClO1
;
end
end
CI2COI1
:
begin
CI2COI0I
=
CI2COI1
;
end
CI2COlOI
:
begin
CI2COI0I
=
CI2COlOI
;
end
CI2CII1
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2Cll1
;
end
else
begin
CI2COI0I
=
CI2CO01
;
end
end
else
begin
CI2COI0I
=
CI2CII1
;
end
end
CI2ClI1
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2Cll1
;
end
else
begin
CI2COI0I
=
CI2CO01
;
end
end
else
begin
CI2COI0I
=
CI2ClI1
;
end
end
CI2Cll1
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2Cll1
;
end
else
begin
CI2COI0I
=
CI2CO01
;
end
end
else
begin
CI2COI0I
=
CI2Cll1
;
end
end
CI2CO01
:
begin
CI2COI0I
=
CI2CO01
;
end
CI2COl1
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2CI01
;
end
else
begin
CI2COI0I
=
CI2Cl01
;
end
end
else
begin
CI2COI0I
=
CI2COl1
;
end
end
CI2CIl1
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2CI01
;
end
else
begin
CI2COI0I
=
CI2Cl01
;
end
end
else
begin
CI2COI0I
=
CI2CIl1
;
end
end
CI2CI01
:
begin
if
(
CI2CO0Il
==
4
'b
1000
)
begin
if
(
!
CI2CI1Il
)
begin
CI2COI0I
=
CI2CI01
;
end
else
begin
CI2COI0I
=
CI2Cl01
;
end
end
else
begin
CI2COI0I
=
CI2CI01
;
end
end
CI2Cl01
:
begin
CI2COI0I
=
CI2Cl01
;
end
CI2CO11
:
begin
CI2COI0I
=
CI2CO11
;
end
CI2CI11
:
begin
if
(
(
CI2CO0Il
==
4
'b
1000
)
&&
(
CI2CO1l
==
0
)
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CIOOI
;
end
else
begin
if
(
!
CI2CII1I
)
begin
CI2COI0I
=
CI2ClOOI
;
end
else
begin
CI2COI0I
=
CI2COOOI
;
end
end
end
else
begin
if
(
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
&&
(
CI2CO1l
==
0
)
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2CI11
;
end
end
end
CI2Cl11
:
begin
if
(
(
CI2CO0Il
==
4
'b
1000
)
&&
(
CI2CO1l
==
0
)
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CIOOI
;
end
else
begin
if
(
!
CI2CII1I
)
begin
CI2COI0I
=
CI2ClOOI
;
end
else
begin
CI2COI0I
=
CI2COOOI
;
end
end
end
else
begin
if
(
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
&&
(
CI2CO1l
==
0
)
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2Cl11
;
end
end
end
CI2COOOI
:
begin
if
(
(
CI2CO0Il
==
4
'b
1000
)
&&
(
CI2CO1l
==
0
)
)
begin
if
(
CI2CllOl
)
begin
CI2COI0I
=
CI2CIOOI
;
end
else
begin
if
(
!
CI2CII1I
)
begin
CI2COI0I
=
CI2ClOOI
;
end
else
begin
CI2COI0I
=
CI2COOOI
;
end
end
end
else
begin
if
(
(
CI2CI1Il
&
!
CI2CllOl
&
CI2Cl1Ol
)
&&
(
CI2CO1l
==
0
)
)
begin
CI2COI0I
=
CI2Cl10
;
end
else
begin
CI2COI0I
=
CI2COOOI
;
end
end
end
CI2CIOOI
:
begin
CI2COI0I
=
CI2CIOOI
;
end
CI2ClOOI
:
begin
CI2COI0I
=
CI2ClOOI
;
end
CI2CO00
:
begin
CI2COI0I
=
CI2CO00
;
end
CI2CIIOI
:
begin
CI2COI0I
=
CI2CIIOI
;
end
default
:
begin
CI2COI0I
=
CI2COIOI
;
end
endcase
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CO00l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClO0I
<=
CI2COIOI
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
begin
if
(
(
CI2COl1I
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
begin
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
CI2ClO0I
<=
CI2ClIOI
;
end
else
if
(
(
CI2COIlI
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
begin
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
0
;
CI2ClO0I
<=
CI2COIOI
;
end
else
if
(
(
CI2COllI
==
1
'b
1
)
&&
(
CI2CO11I
==
1
)
&&
(
CI2ClO0I
!=
CI2ClIOI
)
&&
(
CI2CI0Il
!=
1
'b
1
)
)
begin
CI2ClO0I
<=
CI2COlOI
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
if
(
(
CI2CO0lI
==
1
'b
1
)
&&
(
CI2CI11I
==
1
)
)
begin
CI2ClO0I
<=
CI2COlOI
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
if
(
(
CI2ClO0I
==
CI2COlOI
)
&&
(
CI2COOll
!=
1
'b
1
)
&&
(
CI2CO11I
==
1
)
)
begin
CI2ClO0I
<=
CI2COIOI
;
CI2CI01I
<=
1
'b
1
;
CI2Cl01I
<=
1
'b
0
;
end
else
if
(
CI2COO0I
==
CI2CI0OI
&
CI2Cl0lI
==
CI2CllII
)
begin
CI2ClO0I
<=
CI2CIl0
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
if
(
CI2COO0I
==
CI2CI0OI
&
CI2Cl0lI
==
CI2CI1II
)
begin
CI2ClO0I
<=
CI2Cll0
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
if
(
CI2Cl0lI
==
CI2Cl0II
&
CI2CIlIl
)
begin
CI2ClO0I
<=
CI2CO00
;
end
else
if
(
CI2COO0I
==
CI2CI0OI
|
CI2COO0I
==
CI2CO1OI
)
begin
if
(
(
CI2CO0Il
==
4
'b
0000
|
CI2CO0Il
==
4
'b
1001
)
&
(
!
CI2COOll
)
)
begin
if
(
CI2Cl0Ol
)
begin
CI2ClO0I
<=
CI2CO11
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
begin
CI2ClO0I
<=
CI2COIOI
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
end
else
if
(
(
CI2CO0Il
==
4
'b
0001
|
CI2CO0Il
==
4
'b
0010
|
CI2CO0Il
==
4
'b
0011
|
CI2CO0Il
==
4
'b
0100
|
CI2CO0Il
==
4
'b
0101
|
CI2CO0Il
==
4
'b
0110
|
CI2CO0Il
==
4
'b
0111
|
CI2CO0Il
==
4
'b
1000
)
&
(
CI2Cl0Ol
|
CI2CI0Il
)
)
begin
CI2ClO0I
<=
CI2CIIOI
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
end
else
if
(
CI2CO0Il
==
4
'b
1000
&
CI2Cl1Ol
&
CI2Cl0Ol
&
CI2CO1Ol
&
~
(
CI2ClO0I
==
CI2Cl10
)
)
begin
if
(
!
CI2ClIOl
)
begin
if
(
CI2ClI0I
[
6
:
0
]
==
7
'b
0000000
)
begin
CI2ClO0I
<=
CI2COl1
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
else
begin
CI2ClO0I
<=
CI2CII1
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
end
else
if
(
CI2CO1l
==
0
)
begin
CI2ClO0I
<=
CI2CI11
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
end
else
begin
if
(
CI2Cl1Ol
)
begin
CI2ClO0I
<=
CI2COI0I
;
CI2CI01I
<=
1
'b
0
;
CI2Cl01I
<=
1
'b
1
;
end
end
end
end
always
@
(
CI2COO0I
or
CI2CllOl
)
begin
:
CI2CI00l
CI2CIO0I
=
CI2CI1OI
;
case
(
CI2COO0I
)
CI2CIlOI
:
begin
if
(
!
CI2CllOl
)
begin
CI2CIO0I
=
CI2CO0OI
;
end
else
begin
CI2CIO0I
=
CI2CllOI
;
end
end
CI2CllOI
:
begin
if
(
!
CI2CllOl
)
begin
CI2CIO0I
=
CI2CI0OI
;
end
else
begin
CI2CIO0I
=
CI2CllOI
;
end
end
CI2CO0OI
:
begin
if
(
!
CI2CllOl
)
begin
CI2CIO0I
=
CI2CO0OI
;
end
else
begin
CI2CIO0I
=
CI2CO1OI
;
end
end
CI2CI0OI
:
begin
CI2CIO0I
=
CI2Cl0OI
;
end
CI2Cl0OI
:
begin
if
(
!
CI2CllOl
)
begin
CI2CIO0I
=
CI2Cl0OI
;
end
else
begin
CI2CIO0I
=
CI2CO1OI
;
end
end
CI2CO1OI
:
begin
CI2CIO0I
=
CI2CI1OI
;
end
default
:
begin
if
(
!
CI2CllOl
)
begin
CI2CIO0I
=
CI2CI0OI
;
end
else
begin
CI2CIO0I
=
CI2CI1OI
;
end
end
endcase
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cl00l
if
(
PRESETN
==
1
'b
0
)
begin
CI2COO0I
<=
CI2CIlOI
;
end
else
begin
if
(
!
CI2CI0Ol
)
begin
CI2COO0I
<=
CI2CIlOI
;
end
else
begin
CI2COO0I
<=
CI2CIO0I
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CO10l
if
(
PRESETN
==
1
'b
0
)
begin
CI2CO1Il
<=
1
'b
1
;
end
else
begin
if
(
CI2COO0I
==
CI2CI0OI
)
begin
CI2CO1Il
<=
1
'b
0
;
end
else
if
(
(
CI2COO0I
==
CI2CO1OI
)
|
(
CI2Cl0lI
==
CI2Cl0II
&
CI2COlIl
&
CI2CI0Ol
)
|
(
!
CI2CI0Il
&
CI2COI1I
)
|
(
!
CI2CIO1I
)
)
begin
CI2CO1Il
<=
1
'b
1
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CI10l
if
(
PRESETN
==
1
'b
0
)
begin
CI2CIOll
<=
1
'b
0
;
end
else
begin
if
(
CI2Cl0lI
==
CI2CO1II
)
begin
if
(
CI2Cl1Ol
)
begin
CI2CIOll
<=
1
'b
1
;
end
end
else
begin
CI2CIOll
<=
1
'b
0
;
end
end
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2Cl10l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClOll
<=
1
'b
0
;
end
else
begin
if
(
CI2CO1Il
&
CI2CI0Ol
&
~
(
CI2Cl0lI
==
CI2CO1II
)
)
begin
if
(
CI2COlIl
)
begin
CI2ClOll
<=
1
'b
1
;
end
end
else
begin
CI2ClOll
<=
1
'b
0
;
end
end
end
always
@
(
CI2Cl0lI
or
CI2CllOl
or
CI2CI0Ol
or
CI2CIlIl
or
CI2COlIl
or
CI2COI1I
or
CI2ClO1I
or
CI2CI1Ol
or
CI2CO0Il
or
CI2ClOll
or
CI2COOll
or
CI2ClO0I
or
CI2Cl1Ol
or
CI2CIOll
)
begin
:
CI2COO1l
CI2CI0Il
=
1
'b
1
;
CI2CO1lI
=
CI2CI1II
;
case
(
CI2Cl0lI
)
CI2CIlII
:
begin
CI2CI0Il
=
1
'b
0
;
if
(
CI2ClOll
&
CI2ClO1I
&
!
CI2COOll
&
CI2COlIl
)
begin
if
(
!
CI2CllOl
)
begin
CI2CO1lI
=
CI2CO1II
;
end
else
begin
CI2CO1lI
=
CI2CllII
;
end
end
else
begin
CI2CO1lI
=
CI2CIlII
;
end
end
CI2CllII
:
begin
CI2CI0Il
=
1
'b
1
;
if
(
CI2CI1Ol
)
begin
CI2CO1lI
=
CI2CO0II
;
end
else
begin
CI2CO1lI
=
CI2CllII
;
end
end
CI2CO0II
:
begin
CI2CI0Il
=
1
'b
1
;
if
(
CI2CO0Il
==
4
'b
1001
&
!
CI2COOll
)
begin
if
(
CI2COI1I
)
begin
CI2CO1lI
=
CI2Cl0II
;
end
else
if
(
CI2ClO1I
&
~
(
CI2ClO0I
==
CI2CIl0
|
CI2ClO0I
==
CI2Cll0
)
&
CI2CIlIl
)
begin
CI2CO1lI
=
CI2CI0II
;
end
else
begin
CI2CO1lI
=
CI2CO0II
;
end
end
else
begin
CI2CO1lI
=
CI2CO0II
;
end
end
CI2CI0II
:
begin
CI2CI0Il
=
1
'b
1
;
if
(
(
CI2COlIl
|
CI2CIlIl
)
&
CI2CI0Ol
)
begin
CI2CO1lI
=
CI2CI1II
;
end
else
begin
CI2CO1lI
=
CI2CI0II
;
end
end
CI2Cl0II
:
begin
CI2CI0Il
=
1
'b
1
;
if
(
CI2CI0Ol
&
CI2COlIl
)
begin
CI2CO1lI
=
CI2CIlII
;
end
else
begin
CI2CO1lI
=
CI2Cl0II
;
end
end
CI2CO1II
:
begin
CI2CI0Il
=
1
'b
0
;
if
(
CI2CIOll
&
CI2Cl1Ol
)
begin
CI2CO1lI
=
CI2CIlII
;
end
else
begin
CI2CO1lI
=
CI2CO1II
;
end
end
default
:
begin
CI2CI0Il
=
1
'b
1
;
if
(
CI2CI1Ol
)
begin
CI2CO1lI
=
CI2CO0II
;
end
else
begin
CI2CO1lI
=
CI2CI1II
;
end
end
endcase
end
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CIO1l
if
(
PRESETN
==
1
'b
0
)
begin
CI2Cl0lI
<=
CI2CIlII
;
end
else
begin
if
(
(
CI2COO0I
==
CI2CO1OI
)
|
(
CI2ClO0I
==
CI2Cl10
&
CI2CO0Il
==
4
'b
1000
&
CI2Cl1Ol
)
|
(
!
CI2CIO1I
)
)
begin
CI2Cl0lI
<=
CI2CIlII
;
end
else
begin
CI2Cl0lI
<=
CI2CO1lI
;
end
end
end
assign
PRDATA
=
(
PADDR
==
CI2Cl1l
)
?
CI2CII0I
:
(
PADDR
==
CI2COI0
)
?
CI2ClI0I
:
(
PADDR
==
CI2CIO0
)
?
{
CI2COl0I
,
3
'b
000
}
:
(
PADDR
==
CI2CII
)
?
seradr0
:
(
PADDR
==
CI2COl
)
?
seradr1
:
(
(
PADDR
==
CI2ClI0
)
&&
(
SMB_EN
==
1
)
)
?
{
CI2CIl0I
,
CI2Cll0I
,
CI2CO00I
,
CI2CI00I
,
CI2Cl00I
,
CI2CO10I
,
CI2CI10I
,
CI2Cl10I
}
:
(
(
PADDR
==
CI2ClI0
)
&&
(
IPMI_EN
==
1
)
)
?
{
5
'b
0
,
CI2CO10I
,
2
'b
0
}
:
8
'b
00000000
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2ClO1l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClOlI
<=
0
;
end
else
begin
if
(
CI2CO11I
==
1
)
begin
if
(
(
CI2COl1I
==
1
'b
1
)
)
begin
CI2ClOlI
<=
0
;
end
else
if
(
(
CI2ClI1I
==
1
'b
0
)
)
begin
CI2ClOlI
<=
0
;
end
else
if
(
(
CI2ClOlI
!=
CI2CIOlI
)
&&
(
pulse_215us
==
1
'b
1
)
)
begin
CI2ClOlI
<=
CI2ClOlI
+
1
;
end
end
end
end
assign
CI2COIlI
=
(
(
(
CI2ClOlI
>=
CI2CIOlI
)
&&
(
CI2ClI1I
==
1
'b
1
)
)
||
(
CI2CO11I
==
0
)
)
?
1
'b
1
:
1
'b
0
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2COI1l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClIlI
<=
0
;
end
else
begin
if
(
CI2CO11I
==
1
)
begin
if
(
CI2CI0Ol
==
1
'b
1
)
begin
CI2ClIlI
<=
0
;
end
else
if
(
(
CI2ClIlI
!=
CI2CIIlI
)
&&
(
pulse_215us
==
1
'b
1
)
)
begin
CI2ClIlI
<=
CI2ClIlI
+
1
;
end
end
end
end
assign
CI2COllI
=
(
(
(
CI2ClIlI
==
(
CI2CIIlI
-
1
)
)
&&
(
pulse_215us
==
1
'b
1
)
)
||
(
CI2CO11I
==
0
)
)
?
1
'b
1
:
1
'b
0
;
always
@
(
posedge
PCLK
or
negedge
PRESETN
)
begin
:
CI2CII1l
if
(
PRESETN
==
1
'b
0
)
begin
CI2ClllI
<=
0
;
end
else
begin
if
(
CI2CI11I
==
1
)
begin
if
(
CI2CI0Ol
==
1
'b
1
)
begin
CI2ClllI
<=
0
;
end
else
if
(
(
CI2ClllI
!=
CI2CIllI
)
&&
(
pulse_215us
==
1
'b
1
)
)
begin
CI2ClllI
<=
CI2ClllI
+
1
;
end
end
end
end
assign
CI2CO0lI
=
(
(
(
CI2ClllI
==
(
CI2CIllI
-
1
)
)
&&
(
pulse_215us
==
1
'b
1
)
)
||
(
CI2CI11I
==
0
)
)
?
1
'b
1
:
1
'b
0
;
endmodule