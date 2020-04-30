----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:49:32 04/24/2020 
-- Design Name: 
-- Module Name:    keypad - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keypad is
port(
clk_i : in std_logic; -- 2kHz
rst_i : in std_logic; --Reset(active high)
unlock_o : out std_logic:= '1'; -- Control unlock or new pin
rows : in   std_logic_vector(3 downto 0):= "1111"; -- Input rows of keyboard
columns : out std_logic_vector(2 downto 0):= "111"; -- Columns as output of keyboard
keys_out : out   std_logic_vector(3 downto 0) -- Outputed numbers to Decoder
);
end keypad;

architecture Behavioral of keypad is
type state_type is (s1,s2,s3); -- Define State
signal state: state_type;
signal unlock: std_logic :='1'; -- Property unlocku
constant new_pin: std_logic_vector(3 downto 0) := "1111"; -- Constant number of new pin
constant no_click: std_logic_vector(3 downto 0) := "1100"; -- Constant number of no_click
constant agree: std_logic_vector(3 downto 0) := "1110"; -- Accept new pin
signal limit: std_logic_vector(2 downto 0) := "000"; -- Limit four numbers

begin


scan_keys:process(clk_i,rst_i) --Process scanning keyboard
begin


if rst_i='1' then -- Reset
	keys_out <= no_click; -- Output => no_click
	limit <= "000"; -- Zero Limit
	state<=s1; -- Go to First state
	columns <= "111"; -- Turn OFF columns
	unlock<='1'; -- Unlock!
elsif rising_edge(clk_i) then 
		case state is
			when s1=>  -- First state
				columns <= "011"; -- First column ON
				if limit < "100" then -- Limit 
					case(rows) is -- Testing rows of keyboard
						when "0111" =>			-- First button (number 1)
							keys_out <= "0001";
							limit <= limit + "001"; -- Limit +1
							state<=s2;
						when "1011" =>	--  Number 4
							keys_out <= "0100";
							limit <= limit + "001";
							state<=s2;
						when "1101" =>		--Number 7
							keys_out <= "0111";
							limit <= limit + "001";
							state<=s2;
						when others =>-- No_click for others
							keys_out <= no_click;
							state<=s2;
					end case;
				elsif limit ="100" then -- Evaluation for agree new pin
					if unlock='0' then   --
					case(rows) is
						when "1110" =>
							keys_out <= agree;
							limit <= "000";
							state<=s2;
							unlock<='1';
							unlock_o<='1'; -- The end new pin
						when others =>
							keys_out <= no_click;
							state<=s2;
					end case;
					else
						limit <= "000";
						keys_out <= no_click;
						state<=s2;
					end if;
				else
					limit <= "000";
					keys_out <= no_click;
					state<=s2;
				end if;

				
				
				
			when s2=>  -- Second state
				columns <= "101";
				if limit < "100" then
					case(rows) is
						when "0111" => 
							keys_out <= "0010";
							limit <= limit + "001";
							state<=s3;
						when "1011" => 
							keys_out <= "0101";
							limit <= limit + "001";
							state<=s3;
						when "1101" => 
							keys_out <= "1000";
							limit <= limit + "001";
							state<=s3;
						when "1110" => 
							keys_out <= "0000";
							limit <= limit + "001";
							state<=s3;
						when others =>
							keys_out <= no_click;
							state<=s3;
					end case;
				else 
					keys_out <= no_click;
					state<=s3;
				end if;
				
				
				
				
			when s3=> -- Third state
				columns <= "110";
				if limit < "100" then
					case(rows) is
						when "0111" => 
							keys_out <= "0011";
							limit <= limit + "001";
							state<=s1;
						when "1011" => 
							keys_out <= "0110";
							limit <= limit + "001";
							state<=s1;
						when "1101" => 
							keys_out <= "1001";
							limit <= limit + "001";
							state<=s1;
						when others =>
							keys_out <= no_click;
							state<=s1;
						end case;	
					if unlock='1' then  -- Evaluation to new pin
						case(rows) is 
							when "1110" =>
								keys_out <= new_pin; 
								limit <= "000";
								state<=s1;
								unlock<='0';
								unlock_o<= '0'; --  Start new pin
							when others =>
								keys_out <= no_click;
								state<=s1;
							end case;
					end if;
					
				else 
					keys_out <= no_click;
					state<=s1;
				end if;
					
					
			when others =>
				keys_out <= no_click;
				state<=s1;
				columns <= "111";
		end case;
	end if;	


end process scan_keys;

end Behavioral;

