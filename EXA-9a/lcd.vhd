----------------------------------------------------------------------------------
--- IN PSTYROFPGA-SP3 + 2 X 16 CHARACTER LCD INTERFACE CARD

--- "  vhdl CODE TO DISPLAY " PANTECH SOLUTION " IN LCD USING BEHAVIOURAL MODEL "

-- I/P & O/P DETAILS 


----===== I/P : CLK <P55>
-----===== O/P  :
-----------			LCD COMAND LINE
-----					READ/WRITE LCD_RW <P63 > / REGISTER SELECT LCD_RS <P60> / LCD ENABLE LCD_EN <P68>
-------				DATA LINE : D(0) <P77> /D(1) <P78> /D(2) <P79> /D(3) <P80> 
----									D(4) <P82> /D(5) <P83> /D(6) <P84> /D(7) <P85> 
--/////////////////////////////////////////////////////////////////////////////////////////////////////////

---- NOTE : CONNECT "2 X 16 CHARACTER LCD INTERFACE CARD" IN J6 CONNECTOR IN =>  " PSTYROFPGA-SP3"
			
--//////////////////////////////////////////////////////////////////////////////////////////////////////////
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

------ Uncomment the following library declaration if instantiating
------ any Xilinx primitives in this code.
----library UNISIM;
----use UNISIM.VComponents.all;
--
entity lcd is
port ( clk : in std_logic;    ----clock i/p
       
		 lcd_rw : out std_logic;   ---read&write control
		 lcd_e  : out std_logic;   ----enable control
		 lcd_rs : out std_logic;   ----data or command control
		 data   : out std_logic_vector(7 downto 0));   ---data line
end lcd;

architecture Behavioral of lcd is
constant N: integer :=22; 
type arr is array (1 to N) of std_logic_vector(7 downto 0); 
constant datas : arr :=    (X"38",X"0c",X"06",X"01",X"C0",X"50",x"41",x"4e",x"54",x"45",x"43",x"48",x"20",x"53",x"4f",x"4c",x"55",
                                    x"54",x"49",x"4f",x"4e",X"53"); --command and data to display                                              

begin
lcd_rw <= '0';  ----lcd write
process(clk)
variable i : integer := 0;
variable j : integer := 1;
begin

if clk'event and clk = '1' then
if i <= 1000000 then
i := i + 1;
lcd_e <= '1';
data <= datas(j)(7 downto 0);
elsif i > 1000000 and i < 2000000 then
i := i + 1;
lcd_e <= '0';
elsif i = 2000000 then
j := j + 1;
i := 0;
end if;
if j <= 5  then
lcd_rs <= '0';    ---command signal
elsif j > 5   then
lcd_rs <= '1';   ----data signal
end if;
if j = 22 then  ---repeated display of data
j := 5;
end if;
end if;

end process;
end Behavioral;


