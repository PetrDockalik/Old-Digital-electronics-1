------------------------------------------------------------------------
--
-- Generates clock enable signal.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for clock enable
------------------------------------------------------------------------
entity clock_enable is
generic (
    g_NPERIOD : std_logic_vector(16-1 downto 0) := x"1388" -- 2kHz Clock
);
port (
    clk_i          : in  std_logic; -- Input 10kHz
    rst_i       : in  std_logic; --  Reset (active high)
    clock_o : out std_logic -- 2kHz other circuits
);
end entity clock_enable;

------------------------------------------------------------------------
-- Architecture declaration for clock enable
------------------------------------------------------------------------
architecture Behavioral of clock_enable is
    signal s_cnt : std_logic_vector(16-1 downto 0) := x"0000";
begin

    --------------------------------------------------------------------
    -- p_clk_enable:
    -- Generate clock enable signal instead of creating another clock 
    -- domain. By default enable signal is low and generated pulse is 
    -- always one clock long.
    --------------------------------------------------------------------
    p_clk_enable : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if rst_i = '1' then  -- Reset (active high)
                s_cnt <= (others => '0');   -- Clear all bits
                clock_o <= '0';
            elsif s_cnt >= g_NPERIOD-1 then -- Enable pulse
                s_cnt <= (others => '0');
                clock_o <= '1';
            else
                s_cnt <= s_cnt + x"0001";
                clock_o <= '0';
            end if;
        end if;
    end process p_clk_enable;

end architecture Behavioral;