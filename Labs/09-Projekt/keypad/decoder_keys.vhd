----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:06:43 04/24/2020 
-- Design Name: 
-- Module Name:    decoder_keys - Behavioral 
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

entity decoder_keys is
port(
clk_i : in std_logic;
rst_i : in std_logic;
keys_in : in   std_logic_vector(3 downto 0); -- Outputs of keypad
unlock_in : in   std_logic; -- Unlock signal
ledgreen_out : out std_logic:= '1'; -- Unlock LED
ledred_out : out std_logic:= '1' -- Lock LED
);
end decoder_keys;

architecture Behavioral of decoder_keys is
constant new_pin: std_logic_vector(3 downto 0) := "1111";
constant agree: std_logic_vector(3 downto 0) := "1110";
signal sum_keys: std_logic_vector(5 downto 0):= "000000"; -- Sum numbers of inputs
signal pin: std_logic_vector(5 downto 0):= "001010"; -- default pin 1234
signal limit: std_logic_vector(2 downto 0) := "000";

begin
decode_keys:process(clk_i,rst_i) --Process decoder numbers
begin

if rst_i='1' then
		sum_keys<= "000000"; -- Zero Sum
		pin<= "001010"; -- default pin
		limit <= "000";
elsif rising_edge(clk_i) then
		if unlock_in='1' then --Unlock
			if sum_keys=pin then --Yes, Sum = Pin
				if limit ="100" then
					sum_keys<="000000";
					ledgreen_out<='0'; -- Unlock!
					limit <= "000";
					ledred_out<='1';
				else
					limit <= "000";
					sum_keys<="000000";
				end if;
			else	
				ledred_out<='0'; -- Numbers to unlock
				ledgreen_out<='1';
				if limit < "100" then
					case(keys_in) is
						when "0000"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0001"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0010"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0011"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0100"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0101"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0110"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "0111"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "1000"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when "1001"=>
							sum_keys<=sum_keys+keys_in;
							limit <= limit + "001";
						when new_pin =>
							sum_keys<= "000000";
							limit <= "000";
							ledred_out<='0';
						when others => --  no_click
							sum_keys<= sum_keys+"000000";
					end case;
				else
					sum_keys<="000000";
					limit <= "000";
					ledred_out<='1';
					ledgreen_out<='1';
				end if;
			end if;
		elsif unlock_in='0' then -- New Pin
			if	limit ="100" then --Agree new pin
				ledgreen_out<='1';
				case(keys_in) is
					when agree=>
						pin<=sum_keys; -- Save new pin
						ledred_out<='1';
						limit <= "000";
						sum_keys<="000000";
					when others => -- zahrnut i no_click
						sum_keys<= sum_keys+"000000";
					end case;
			elsif limit < "100" then -- Numbers to new pin
				ledgreen_out<='1';
				case(keys_in) is
					when "0000"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0001"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0010"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0011"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0100"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0101"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0110"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "0111"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "1000"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when "1001"=>
						sum_keys<=sum_keys+keys_in;
						limit <= limit + "001";
					when others => -- no_click
						sum_keys<= sum_keys+"000000";
				end case;
			else
				sum_keys<="000000";
				limit <= "000";
				ledred_out<='1';
				ledgreen_out<='1';
			end if;
		end if;
end if;

end process decode_keys;

end Behavioral;

