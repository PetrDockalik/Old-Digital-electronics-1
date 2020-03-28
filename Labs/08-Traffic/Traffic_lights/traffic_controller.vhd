----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:29 03/27/2020 
-- Design Name: 
-- Module Name:    traffic_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic_controller is
port (
    clock_i          : in  std_logic;
    ryg1_o: out std_logic_vector(3-1 downto 0);
	 ryg2_o : out std_logic_vector(3-1 downto 0);
	 srst_n_i       : in  std_logic
);
end traffic_controller;

architecture traffic_controller of traffic_controller is
	 type state_type is (gr,yr1,ry1,rg,ry2,yr2);
	 signal state: state_type;
	 signal cnt: unsigned(4-1 downto 0);
    constant sec: unsigned(4-1 downto 0) := "0001";
    constant fivesec: unsigned(4-1 downto 0) := "0100";
	  
begin

traffic_simulator:process(clock_i,srst_n_i) 
  begin 
    if srst_n_i = '0' then          
		state <= gr;
		cnt <= "0000";
	 elsif rising_edge(clock_i) then
		case state is
			when gr =>
				if cnt < fivesec then
					state<= gr;
					cnt <= cnt +1;
				else
					state<= yr1;
					cnt <= "0000";
				end if;
			when yr1 =>
				if cnt = sec then
					state<= yr1;
					cnt <= cnt +1;
				else
					state<= ry1;
					cnt <= "0000";
				end if;
			when ry1 =>
				if cnt = sec then
					state<= ry1;
					cnt <= cnt +1;
				else
					state<= rg;
					cnt <= "0000";
				end if;
			when rg =>
				if cnt < fivesec then
					state<= rg;
					cnt <= cnt +1;
				else
					state<= ry2;
					cnt <= "0000";
				end if;
			when ry2 =>
				if cnt = sec then
					state<= ry2;
					cnt <= cnt +1;
				else
					state<= yr2;
					cnt <= "0000";
				end if;
			when yr2 =>
				if cnt = sec then
					state<= yr2;
					cnt <= cnt +1;
				else
					state<= gr;
					cnt <= "0000";
				end if;
			when others =>
					state <= gr;
					cnt <= "0000";
					
		end case;
	end if;
end process traffic_simulator;

traffic_light: process(state)
begin
	case state is
		when gr =>
			ryg1_o <= "110";
			ryg2_o <= "011";
		when yr1 =>
			ryg1_o <= "101";
			ryg2_o <= "011";
		when ry1 =>
			ryg1_o <="011";
			ryg2_o <="101";
		when rg =>
			ryg1_o <="011";
			ryg2_o <="110";
		when ry2 =>
			ryg1_o <="011";
			ryg2_o <="101";
		when yr2 =>
			ryg1_o<="101";
			ryg2_o<="011";
		when others =>
			ryg1_o <="110";
			ryg2_o <="011";
	end case;
end process traffic_light;

end traffic_controller;

