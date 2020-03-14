// (c) Copyright 2005 Actel Corporation
// Rev:                 2.1 24Jan05 TFB - Production
`timescale 1ns/1ps
module
CSPIlI
#
(
parameter
USE_MASTER
=
1
,
parameter
USE_SLAVE
=
1
)
(
sysclk
,
nreset
,
m_sck
,
m_miso
,
m_mosi
,
m_ss
,
s_sck
,
s_miso
,
s_mosi
,
s_ss
,
enable_master
,
enable_slave
,
CSPIIl
,
CSPIll
,
CSPIO0
,
CSPII0
,
CSPIl0
,
interrupt
,
tx_reg_empty
,
rx_data_ready
)
;
input
sysclk
;
input
nreset
;
output
m_sck
;
input
m_miso
;
output
m_mosi
;
output
[
7
:
0
]
m_ss
;
input
s_sck
;
output
s_miso
;
input
s_mosi
;
input
s_ss
;
output
enable_master
;
output
enable_slave
;
input
[
7
:
0
]
CSPIIl
;
output
[
7
:
0
]
CSPIll
;
input
[
1
:
0
]
CSPIO0
;
input
CSPII0
;
input
CSPIl0
;
output
interrupt
;
output
tx_reg_empty
;
output
rx_data_ready
;
wire
m_sck
;
wire
m_mosi
;
wire
[
7
:
0
]
m_ss
;
wire
s_miso
;
wire
enable_master
;
wire
enable_slave
;
wire
[
7
:
0
]
CSPIll
;
wire
interrupt
;
wire
tx_reg_empty
;
wire
rx_data_ready
;
wire
cpol
;
wire
cpha
;
wire
CSPIO1
;
wire
CSPII1
;
wire
CSPIl1
;
reg
[
7
:
0
]
CSPIOOI
;
wire
[
7
:
0
]
CSPIIOI
;
wire
CSPIlOI
;
wire
CSPIOII
;
wire
CSPIIII
;
wire
tx_reg_we
;
wire
rx_reg_re
;
reg
CSPIlII
;
wire
[
2
:
0
]
CSPIOlI
;
wire
CSPIIlI
;
wire
CSPIllI
;
wire
CSPIO0I
;
wire
[
7
:
0
]
CSPII0I
;
wire
[
7
:
0
]
CSPIl0I
;
wire
[
7
:
0
]
CSPIO1I
;
wire
[
7
:
0
]
CSPII1I
;
wire
CSPIl1I
;
wire
CSPIOOl
;
wire
CSPIIOl
;
reg
[
7
:
0
]
tx_data_reg
;
wire
CSPIlOl
;
wire
CSPIOIl
;
wire
CSPIIIl
;
wire
CSPIlIl
;
reg
clear_error
;
wire
CSPIOll
;
wire
CSPIIll
;
wire
rx_error
;
wire
CSPIlll
;
wire
CSPIO0l
;
reg
[
7
:
0
]
CSPII0l
;
wire
CSPIl0l
;
wire
CSPIO1l
;
assign
CSPIO1l
=
8
'b
0
;
assign
enable_master
=
CSPIlll
;
assign
enable_slave
=
CSPIO0l
;
assign
tx_reg_empty
=
CSPIlOl
;
assign
rx_data_ready
=
CSPIOOl
;
assign
tx_reg_we
=
(
CSPII0
==
1
'b
1
&
CSPIO0
==
2
'b
00
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
assign
rx_reg_re
=
(
CSPIl0
==
1
'b
1
&
CSPIO0
==
2
'b
00
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
assign
CSPIO1
=
(
CSPII0
==
1
'b
1
&
CSPIO0
==
2
'b
01
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
assign
CSPII1
=
(
CSPIl0
==
1
'b
1
&
CSPIO0
==
2
'b
01
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
assign
CSPIl1
=
(
CSPII0
==
1
'b
1
&
CSPIO0
==
2
'b
10
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
assign
CSPIlOI
=
(
CSPIl0
==
1
'b
1
&
CSPIO0
==
2
'b
10
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
assign
CSPIOII
=
(
CSPII0
==
1
'b
1
&
CSPIO0
==
2
'b
11
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
assign
CSPIIII
=
(
CSPIl0
==
1
'b
1
&
CSPIO0
==
2
'b
11
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
sysclk
or
negedge
nreset
)
begin
if
(
nreset
==
1
'b
0
)
begin
CSPIOOI
<=
{
8
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
CSPIO1
==
1
'b
1
)
begin
CSPIOOI
<=
CSPIIl
;
end
end
end
assign
CSPIOlI
[
0
]
=
CSPIOOI
[
0
]
;
assign
CSPIOlI
[
1
]
=
CSPIOOI
[
1
]
;
assign
CSPIOlI
[
2
]
=
CSPIOOI
[
2
]
;
assign
cpol
=
CSPIOOI
[
3
]
;
assign
cpha
=
CSPIOOI
[
4
]
;
assign
CSPIIlI
=
CSPIOOI
[
5
]
;
generate
if
(
USE_MASTER
==
1
&
USE_SLAVE
==
1
)
begin
assign
CSPIllI
=
CSPIOOI
[
6
]
;
end
endgenerate
generate
if
(
USE_MASTER
==
1
&
USE_SLAVE
==
0
)
begin
assign
CSPIllI
=
1
'b
1
;
end
endgenerate
generate
if
(
USE_MASTER
==
0
&
USE_SLAVE
==
1
)
begin
assign
CSPIllI
=
1
'b
0
;
end
endgenerate
assign
CSPIO0I
=
CSPIOOI
[
7
]
;
always
@
(
posedge
sysclk
or
negedge
nreset
)
begin
if
(
nreset
==
1
'b
0
)
begin
clear_error
<=
1
'b
0
;
CSPIlII
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
CSPIl1
==
1
'b
1
)
begin
clear_error
<=
CSPIIl
[
0
]
;
CSPIlII
<=
CSPIIl
[
7
]
;
end
else
if
(
clear_error
==
1
'b
1
)
begin
clear_error
<=
1
'b
0
;
end
end
end
assign
CSPIll
=
(
rx_reg_re
==
1
'b
1
&
CSPIIlI
==
1
'b
0
)
?
CSPII0I
:
(
rx_reg_re
==
1
'b
1
&
CSPIIlI
==
1
'b
1
)
?
CSPII1I
:
(
CSPII1
==
1
'b
1
)
?
CSPIOOI
:
(
CSPIlOI
==
1
'b
1
)
?
CSPIIOI
:
(
CSPIIII
==
1
'b
1
)
?
CSPII0l
:
{
8
{
1
'b
0
}
}
;
assign
CSPII0I
=
(
CSPIlll
==
1
'b
1
)
?
CSPIl0I
:
CSPIO1I
;
assign
CSPIIOI
[
0
]
=
rx_error
;
assign
CSPIIOI
[
1
]
=
CSPIOOl
;
assign
CSPIIOI
[
2
]
=
CSPIlOl
;
assign
CSPIIOI
[
3
]
=
(
CSPIllI
==
1
'b
1
)
?
CSPIlIl
:
1
'b
0
;
assign
CSPIIOI
[
6
:
4
]
=
3
'b
000
;
assign
CSPIIOI
[
7
]
=
CSPIlII
;
assign
rx_error
=
CSPIOll
|
CSPIIll
;
assign
CSPII1I
[
0
]
=
CSPII0I
[
7
]
;
assign
CSPII1I
[
1
]
=
CSPII0I
[
6
]
;
assign
CSPII1I
[
2
]
=
CSPII0I
[
5
]
;
assign
CSPII1I
[
3
]
=
CSPII0I
[
4
]
;
assign
CSPII1I
[
4
]
=
CSPII0I
[
3
]
;
assign
CSPII1I
[
5
]
=
CSPII0I
[
2
]
;
assign
CSPII1I
[
6
]
=
CSPII0I
[
1
]
;
assign
CSPII1I
[
7
]
=
CSPII0I
[
0
]
;
always
@
(
posedge
sysclk
or
negedge
nreset
)
begin
if
(
nreset
==
1
'b
0
)
begin
tx_data_reg
<=
{
8
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
tx_reg_we
==
1
'b
1
)
begin
if
(
CSPIIlI
==
1
'b
0
)
begin
tx_data_reg
<=
CSPIIl
;
end
else
begin
tx_data_reg
[
0
]
<=
CSPIIl
[
7
]
;
tx_data_reg
[
1
]
<=
CSPIIl
[
6
]
;
tx_data_reg
[
2
]
<=
CSPIIl
[
5
]
;
tx_data_reg
[
3
]
<=
CSPIIl
[
4
]
;
tx_data_reg
[
4
]
<=
CSPIIl
[
3
]
;
tx_data_reg
[
5
]
<=
CSPIIl
[
2
]
;
tx_data_reg
[
6
]
<=
CSPIIl
[
1
]
;
tx_data_reg
[
7
]
<=
CSPIIl
[
0
]
;
end
end
end
end
assign
interrupt
=
CSPIlII
&
(
CSPIO0I
&
(
CSPIlOl
|
CSPIOOl
)
)
;
assign
CSPIlOl
=
(
CSPIlll
==
1
'b
1
)
?
CSPIOIl
:
(
CSPIO0l
==
1
'b
1
)
?
CSPIIIl
:
1
'b
0
;
assign
CSPIOOl
=
(
CSPIlll
==
1
'b
1
)
?
CSPIl1I
:
(
CSPIO0l
==
1
'b
1
)
?
CSPIIOl
:
1
'b
0
;
generate
if
(
USE_MASTER
==
1
)
begin
always
@
(
posedge
sysclk
or
negedge
nreset
)
begin
if
(
nreset
==
1
'b
0
)
CSPII0l
<=
{
8
{
1
'b
0
}
}
;
else
begin
if
(
CSPIOII
==
1
'b
1
)
CSPII0l
<=
CSPIIl
;
end
end
spi_master
CSPII1l
(
.sysclk
(
sysclk
)
,
.nreset
(
nreset
)
,
.enable
(
CSPIlll
)
,
.sck
(
m_sck
)
,
.miso
(
m_miso
)
,
.mosi
(
m_mosi
)
,
.ss
(
CSPIl0l
)
,
.cpol
(
cpol
)
,
.cpha
(
cpha
)
,
.clocksel
(
CSPIOlI
)
,
.rx_data_reg
(
CSPIl0I
)
,
.rx_data_ready
(
CSPIl1I
)
,
.rx_reg_re
(
rx_reg_re
)
,
.tx_data_reg
(
tx_data_reg
)
,
.tx_reg_empty
(
CSPIOIl
)
,
.busy
(
CSPIlIl
)
,
.tx_reg_we
(
tx_reg_we
)
,
.clear_error
(
clear_error
)
,
.rx_error
(
CSPIOll
)
)
;
assign
m_ss
[
0
]
=
CSPIl0l
|
(
~
CSPII0l
[
0
]
)
;
assign
m_ss
[
1
]
=
CSPIl0l
|
(
~
CSPII0l
[
1
]
)
;
assign
m_ss
[
2
]
=
CSPIl0l
|
(
~
CSPII0l
[
2
]
)
;
assign
m_ss
[
3
]
=
CSPIl0l
|
(
~
CSPII0l
[
3
]
)
;
assign
m_ss
[
4
]
=
CSPIl0l
|
(
~
CSPII0l
[
4
]
)
;
assign
m_ss
[
5
]
=
CSPIl0l
|
(
~
CSPII0l
[
5
]
)
;
assign
m_ss
[
6
]
=
CSPIl0l
|
(
~
CSPII0l
[
6
]
)
;
assign
m_ss
[
7
]
=
CSPIl0l
|
(
~
CSPII0l
[
7
]
)
;
end
endgenerate
generate
if
(
USE_MASTER
==
0
)
begin
always
@
(
CSPIO1l
)
CSPII0l
<=
CSPIO1l
;
assign
m_sck
=
1
'b
0
;
assign
m_mosi
=
1
'b
0
;
assign
CSPIl0l
=
1
'b
0
;
assign
CSPIl0I
=
8
'b
00000000
;
assign
CSPIl1I
=
1
'b
0
;
assign
CSPIOIl
=
1
'b
0
;
assign
CSPIlIl
=
1
'b
0
;
assign
CSPIOll
=
1
'b
0
;
assign
m_ss
=
8
'b
11111111
;
end
endgenerate
assign
CSPIlll
=
CSPIlII
&
CSPIllI
;
generate
if
(
USE_SLAVE
==
1
)
begin
spi_slave
CSPIl1l
(
.sysclk
(
sysclk
)
,
.nreset
(
nreset
)
,
.enable
(
CSPIO0l
)
,
.sck
(
s_sck
)
,
.miso
(
s_miso
)
,
.mosi
(
s_mosi
)
,
.ss
(
s_ss
)
,
.cpol
(
cpol
)
,
.cpha
(
cpha
)
,
.rx_data_reg
(
CSPIO1I
)
,
.rx_data_ready
(
CSPIIOl
)
,
.rx_reg_re
(
rx_reg_re
)
,
.tx_data_reg
(
tx_data_reg
)
,
.tx_reg_we
(
tx_reg_we
)
,
.tx_reg_empty
(
CSPIIIl
)
,
.clear_error
(
clear_error
)
,
.rx_error
(
CSPIIll
)
)
;
end
endgenerate
generate
if
(
USE_SLAVE
==
0
)
begin
assign
s_miso
=
1
'b
0
;
assign
CSPIO1I
=
8
'b
00000000
;
assign
CSPIIOl
=
1
'b
0
;
assign
CSPIIIl
=
1
'b
0
;
assign
CSPIIll
=
1
'b
0
;
end
endgenerate
assign
CSPIO0l
=
CSPIlII
&
(
~
CSPIllI
)
;
endmodule
