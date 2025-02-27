library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

Entity Sensor is
    Port ( sensin: in STD_LOGIC;
			 sensout: in STD_LOGIC;
	           clk: in STD_LOGIC;
				   en: in std_logic;
             seg1: out  STD_LOGIC_VECTOR (6 downto 0);
             seg2: out  STD_LOGIC_VECTOR (6 downto 0));
End Sensor;

Architecture Behavioral of Sensor is
signal q:integer range 0 to 3000000;

begin
PROCESS (clk)
variable fin:integer range 0 to 1;
variable fout:integer range 0 to 1;
variable n1:integer range 0 to 10;
variable n2:integer range 0 to 10;

begin 

if (clk' EVENT and clk='1' and en='1')then
q <=q+1;
if (q= 3000000) then 
q <= 0;

if (sensin='0' and fin=0)then
n1:=n1+1;
fin:=1;

if (n1=10)then 
n1:=0;
n2:=n2+1;
if (n2=10)then 
n2:=0;


end if;
end if;
end if;

if (sensout='0' and fout=0)then
if (n1 /= 0 or n2 /= 0) then

if (n1=0)then 
n1:=9;
n2:=n2-1;
fout:=1;
else
n1:=n1-1;
fout:=1;



end if;
end if;

end if;

end if;
end if;

if (sensin='1') then
fin:=0;
end if;

if (sensout='1') then
fout:=0;
end if;

Case n1 is
when 0 =>seg1 <="0000001";
when 1 =>seg1 <="1001111";
when 2 =>seg1 <="0010010";
when 3 =>seg1 <="0000110";
when 4 =>seg1 <="1001100";
when 5 =>seg1 <="0100100";
when 6 =>seg1 <="0100000";
when 7 =>seg1 <="0001111";
when 8 =>seg1 <="0000000";
when 9 =>seg1 <="0000100";
when others =>null;
end case;

Case n2 is
when 0 =>seg2 <="0000001";
when 1 =>seg2 <="1001111";
when 2 =>seg2 <="0010010";
when 3 =>seg2 <="0000110";
when 4 =>seg2 <="1001100";
when 5 =>seg2 <="0100100";
when 6 =>seg2 <="0100000";
when 7 =>seg2 <="0001111";
when 8 =>seg2 <="0000000";
when 9 =>seg2 <="0000100";
when others =>null;
end case;
end PROCESS;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Sensor_package is 
    component Sensor is 
				Port ( sensin: in STD_LOGIC;
						sensout: in STD_LOGIC;
							 clk: in STD_LOGIC;
							  en: in std_logic;
							seg1: out  STD_LOGIC_VECTOR (6 downto 0);
							seg2: out  STD_LOGIC_VECTOR (6 downto 0));
	 end component;
end Sensor_package;